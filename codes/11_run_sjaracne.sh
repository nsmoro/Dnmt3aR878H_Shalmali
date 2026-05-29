#!/bin/bash

# Loop through each main directory
for main_dir in <cell.types>; do
    echo "Searching in: $main_dir"

    # Find all .sh files directly inside the main directory
    find "$main_dir" -maxdepth 1 -type f -name "*2.sh" | while read -r script; do
        echo "Submitting: $script"
        bsub < "$script"
    done
done

