cd /home/scMINER/SJARACNe

for subtype in */; do
    echo "Processing $subtype"

    for driver in SIG TF; do
        dir="${subtype}${driver}"
        
        if [ -d "$dir" ]; then
            echo "  -> $dir"
            
            # remove weird tmp folders
            rm -rf "$dir"/tmp* 2>/dev/null
            
            # go into workflow folder
            cd "$dir"/sjaracne_workflow-* 2>/dev/null || continue
            
            # unzip outputs if needed
            gunzip -f *.gz 2>/dev/null
            
            # copy txt files one level up (to SIG/ or TF/)
            find . -name "*.txt" -exec cp {} .. \;
            
            cd - >/dev/null
        fi
    done
done
