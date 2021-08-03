#!/bin/bash
#SBATCH -p cegs
#SBATCH --mem=2gb
#SBATCH -t 01:00:00
#SBATCH -J seqtk_subseq
#SBATCH -o %x_%j.out

fa_or_fq=$1
subset_list=$2
output=$3

source activate seqtk
seqtk subseq $fa_or_fq $subset_list > $output
