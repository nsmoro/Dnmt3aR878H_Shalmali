#!/usr/bin/env bash
set -euo pipefail

# Ensure the target base directory exists
mkdir -p keep

# Loop over matching zip files
shopt -s nullglob
for z in output_*.zip; do
    # Strip "output_" prefix and ".zip" suffix
    base="${z#output_}"
    name="${base%.zip}"
    folder="unzip/$name"

    echo "Unzipping '$z' -> '$folder' ..."
    mkdir -p "$folder"
    unzip -o "$z" -d "$folder"
done

