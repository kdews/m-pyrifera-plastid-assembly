#!/bin/bash
#SBATCH -p cegs
#SBATCH --mem=50gb
#SBATCH -t 2-00
#SBATCH -o get_organelle.out

get_organelle_from_reads.py 

