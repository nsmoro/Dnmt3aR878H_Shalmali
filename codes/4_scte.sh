#!/bin/bash
#set -euo pipefail
set -x

module load samtools/1.15.1
conda activate scTEpy310

BASE_DIR="/home/unzip"
INDEX="/home/mm10.exclusive.idx"

# Ensure missing globs expand to empty instead of literal patterns
shopt -s nullglob

for sample_dir in "$BASE_DIR"/*; do
  [[ -d "$sample_dir" ]] || continue
  sample_name="$(basename "$sample_dir")"

  process_dir="$sample_dir/process"
  if [[ ! -d "$process_dir" ]]; then
    echo "WARNING: No 'process' folder for $sample_name"
    continue
  fi

  # Collect BAM(s); if you expect exactly one, this still works; if none, array will be empty
  bam_files=("$process_dir"/barcode_headAligned_anno.chr.primary.bam)

  if (( ${#bam_files[@]} == 0 )); then
    echo "WARNING: No BAM files in $process_dir"
    continue
  fi

  outdir="$process_dir/${sample_name}_scTE_out"
  out_prefix="${sample_name}_barcode_headAligned_anno"

  mkdir -p "$outdir"

  # Run scTE in the outdir; use subshell so we don't change parent directory
  (
    cd "$outdir" && \
    scTE -i "${bam_files[@]}" \
      -o "$out_prefix" \
      -x "$INDEX" \
      --expect-cells 99999 \
      --hdf5 True \
      -CB CB \
      -UMI False \
      -p 4 \
      | tee "scTE_run.log"
  )

  echo "   ✔ Done: $outdir"
done

bsub -J "scTE_${sample_name}" -n 8 -R "rusage[mem=6000]" -M 70000 -q standard -oo "$outdir/run.log" \
    "cd $outdir && scTE -i ${bam_files[@]} -o $out_prefix -x $INDEX -CB CB -UMI False --hdf5 True --expect-cells 99999"
done

