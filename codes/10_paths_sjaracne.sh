#!/bin/bash

# Traverse all subdirectories and find runSJARACNe2.sh files
find /scMINER/SJARACNe -type f -name "runSJARACNe2.sh" | while read -r file; do
    echo "Updating: $file"
    # Replace Windows-style path with Linux-style path
    sed -i 's|/<>|/<>/|g' "$file"
done

