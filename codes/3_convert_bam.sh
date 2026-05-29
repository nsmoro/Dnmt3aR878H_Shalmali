#!/bin/bash
#set -euo pipefail
set -x

module load samtools/1.15.1
# If scTE is in a conda env:
#conda activate scTEpy310

base_dir="/home/unzip"
index="/home/mm10.exclusive.idx"

[[ -f "$index" ]] || { echo "ERROR: scTE index not found: $index" >&2; exit 1; }

shopt -s nullglob

echo "Scanning samples in: $base_dir"

for sample_dir in "$base_dir"/*; do
  [[ -d "$sample_dir" ]] || continue
  sample_name="$(basename "$sample_dir")"

  process_dir="$sample_dir/process"
  [[ -d "$process_dir" ]] || { echo "WARNING: No 'process' folder for $sample_name"; continue; }

  bam_files=("$process_dir"/*.bam)
  if (( ${#bam_files[@]} == 0 )); then
    echo "WARNING: No BAM files in $process_dir"
    continue
  fi

  for bam in "${bam_files[@]}"; do
    bam_base="$(basename "$bam" .bam)"
    echo ">> Sample: $sample_name | BAM: $bam_base"
  
    # --- 0) Ensure original BAM is coordinate-sorted and indexed ---
    # This will:
    #  - detect coordinate sorting
    #  - sort if needed (multi-threaded)
    #  - create .bai index if missing

    # Threads for sort (adjust as appropriate)
    threads="${SLURM_CPUS_PER_TASK:-4}"

    # Check if BAM header indicates coordinate sorting
    if samtools view -H "$bam" | grep -q 'SO:coordinate'; then
      echo "   [Step 0] BAM is coordinate-sorted."

      # Index if missing
      if [[ -f "${bam}.bai" ]]; then
        echo "   [Step 0] Index exists: ${bam}.bai"
      else
        echo "   [Step 0] Indexing sorted BAM: $bam"
        samtools index -@ "$threads" "$bam"
      fi

    else
      echo "   [Step 0] BAM is NOT coordinate-sorted. Sorting now..."
      sorted_bam="$process_dir/${bam_base}.sorted.bam"
      tmp_prefix="$process_dir/${bam_base}.sorttmp"

      # Sort by coordinate (use threads, and a temp prefix to avoid /tmp pressure)
      samtools sort -@ "$threads" -T "$tmp_prefix" -o "$sorted_bam" "$bam"

      # Replace original BAM with sorted one (optional: keep a backup)
      mv "$sorted_bam" "$bam"
      echo "   [Step 0] Sorting complete. Replacing original with sorted BAM: $bam"

      # Index the now-sorted BAM
      echo "   [Step 0] Indexing sorted BAM: $bam"
      samtools index -@ "$threads" "$bam"
      echo "   [Step 0] ✔ Created index: ${bam}.bai"
    fi

    # --- 1) Reheader mm10_* -> chr* ---
    header_sam="$process_dir/${bam_base}.header.sam"
    header_chr_sam="$process_dir/${bam_base}.header.chr.sam"

    samtools view -H "$bam" > "$header_sam"
    awk 'BEGIN{OFS="\t"}
         /^@SQ/ {
           for (i=1;i<=NF;i++) {
             if ($i ~ /^SN:mm10_[0-9]+$/) { split($i,a,":"); split(a[2],b,"_"); $i="SN:chr" b[2] }
             else if ($i ~ /^SN:mm10_X$/) { $i="SN:chrX" }
             else if ($i ~ /^SN:mm10_Y$/) { $i="SN:chrY" }
             else if ($i ~ /^SN:mm10_MT$/){ $i="SN:chrM" }
           }
         }
         {print}' "$header_sam" > "$header_chr_sam"

    chr_bam="$process_dir/${bam_base}.chr.bam"
    samtools reheader "$header_chr_sam" "$bam" > "$chr_bam"
    samtools index "$chr_bam"

    # --- 2) Optional: filter to primary chr ---
    primary_bam="$process_dir/${bam_base}.chr.primary.bam"
    samtools view -h "$chr_bam" \
      chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 \
      chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chrX chrY chrM \
      -o "$primary_bam"
    samtools index "$primary_bam"

    # --- 3) Auto-detect tags in first 10k reads ---
    tag_scan="$(samtools view "$primary_bam" | head -n 10000)"

    # Detect UMI tag: prefer UB, then UR, then pN; else NONE
    umi_tag=""
    if echo "$tag_scan" | awk '{for(i=12;i<=NF;i++) if($i ~ /^UB:Z:/) exit 0} END{exit 1}'; then
      umi_tag="UB"
    elif echo "$tag_scan" | awk '{for(i=12;i<=NF;i++) if($i ~ /^UR:Z:/) exit 0} END{exit 1}'; then
      umi_tag="UR"
    elif echo "$tag_scan" | awk '{for(i=12;i<=NF;i++) if($i ~ /^pN:Z:/) exit 0} END{exit 1}'; then
      umi_tag="pN"
    else
      umi_tag="NONE"
    fi

    # Detect cell barcode tag: prefer CB, else CR, else NONE
    cell_tag=""
    if echo "$tag_scan" | awk '{for(i=12;i<=NF;i++) if($i ~ /^CB:Z:/) exit 0} END{exit 1}'; then
      cell_tag="CB"
    elif echo "$tag_scan" | awk '{for(i=12;i<=NF;i++) if($i ~ /^CR:Z:/) exit 0} END{exit 1}'; then
      cell_tag="CR"
    else
      cell_tag="NONE"
    fi

    echo "   Detected tags: cell=$cell_tag, UMI=$umi_tag"

    outdir="$process_dir/${sample_name}_${bam_base}_scTE_out"
    mkdir -p "$outdir"

    echo "   ✔ Done: $outdir"
  done

done

