#!/bin/bash
#SBATCH -p cegs
#SBATCH --mem=50gb
#SBATCH -t 2-00
#SBATCH -o get_organelle.out

source activate getorg
get_organelle_from_reads.py -1 Arabidopsis_simulated.1.fq.gz -2 Arabidopsis_simulated.2.fq.gz -t 1 -o Arabidopsis_simulated.plastome -F embplant_pt -R 10


