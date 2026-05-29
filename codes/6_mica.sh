#!/bin/bash
#BSUB -J mica_job
#BSUB -n 4
#BSUB -M 16000
#BSUB -R "rusage[mem=16000]"
#BSUB -oo mica_output.log
#BSUB -eo mica_error.log

mica ge -i /home/mica.txt \
        -o /home/micaOutput \
        -minr 0.1 -maxr 9.0 -ss 0.05 -nw 4

