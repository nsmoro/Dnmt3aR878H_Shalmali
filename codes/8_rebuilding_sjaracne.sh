#!/bin/bash

# List of all main directories
for main_dir in <cell.types>; do
    echo "Processing main directory: $main_dir"

    # Process .txt and .sh files directly inside the main directory
    for ext in txt sh; do
        find "$main_dir" -maxdepth 1 -type f -name "*.${ext}" | while read -r file; do
            new_file="${file%.*}2.${ext}"
            tr -d '\r' < "$file" > "$new_file"
            echo "Created cleaned file: $new_file"
        done
    done

    # Process .txt files inside TF and SIG subdirectories
    for sub_dir in TF SIG; do
        target_dir="$main_dir/$sub_dir"
        if [ -d "$target_dir" ]; then
            echo "Processing subdirectory: $target_dir"
            find "$target_dir" -type f -name "*.txt" | while read -r file; do
                new_file="${file%.*}2.txt"
                tr -d '\r' < "$file" > "$new_file"
                echo "Created cleaned file: $new_file"
            done
        fi
    done
done

