#!/bin/bash
#SBATCH -p cegs
#SBATCH -t 20:00:00
#SBATCH --mem=8g
#SBATCH -o fastq_convert.out

reformat.sh in=gk_pacbio/1_A01.fastq.gz out=fastas/1_A01.fasta.gz
reformat.sh in=gk_pacbio/2_B01.fastq.gz out=fastas/2_B01.fasta.gz
reformat.sh in=gk_pacbio/3_C01.fastq.gz out=fastas/3_C01.fasta.gz

