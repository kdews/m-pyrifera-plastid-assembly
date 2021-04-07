#!/bin/bash
#SBATCH --partition=cegs
#SBATCH --time=01:00:00

reformat.sh in=gk_pacbio/1_A01.fastq.gz out=fastas/1_A01.fasta.gz
reformat.sh in=gk_pacbio/2_B01.fastq.gz out=fastas/2_B01.fasta.gz
reformat.sh in=gk_pacbio/3_C01.fastq.gz out=fastas/3_C01.fasta.gz

