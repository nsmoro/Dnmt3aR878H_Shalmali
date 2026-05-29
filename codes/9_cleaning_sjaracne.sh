#!/bin/bash

find /scMINER/SJARACNe -name runSJARACNe2.sh | while read file; do
  # Keep only lines starting with 'sjaracne lsf'
  grep '^sjaracne lsf' "$file" > "$file.tmp"
  mv "$file.tmp" "$file"
done

