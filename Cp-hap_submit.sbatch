#!/bin/bash
#SBATCH -p cegs
#SBATCH -t 20:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=8g

cd Cp-hap

source activate cphap
Cp-hap.sh -r /project/noujdine_61/kelp_data/gk_pacbio/$1 -g 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled.fasta -o $2 -t 12


