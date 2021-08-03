#!/bin/bash
#SBATCH -p cegs
#SBATCH --mem=115gb
#SBATCH -t 2-00
#SBATCH --cpus-per-task=12
#SBATCH -o get_organelle_2_B01_plastid.out

source activate getorg
get_organelle_from_reads.py -t 12 -u gk_pacbio/2_B01.fastq.gz\
 -o get_organelle_2_B01_plastid -s seed_fastas/u_pinnat_plastid.fasta\
 -F embplant_pt -k 21,45,65,85,105 --verbose --overwrite --memory-save

