#!/bin/bash

base_dir="/home/fastqs"

for sample_dir in "$base_dir"/*; do

    # skip if not a directory
    [ -d "$sample_dir" ] || continue

    sample_name=$(basename "$sample_dir")

    output_dir="$sample_dir/merge"
    mkdir -p "$output_dir"

    fq1_merged="$output_dir/${sample_name}_R1_merged.fastq.gz"
    fq2_merged="$output_dir/${sample_name}_R2_merged.fastq.gz"

    echo "Processing $sample_name..."

    # Merge R1
    printf '%s\0' "$sample_dir"/*_R1_001.fastq.gz | sort -zV | xargs -0 cat -- > "$fq1_merged"

    # Merge R2
    printf '%s\0' "$sample_dir"/*_R2_001.fastq.gz | sort -zV | xargs -0 cat -- > "$fq2_merged"

    echo "Done $sample_name"

done