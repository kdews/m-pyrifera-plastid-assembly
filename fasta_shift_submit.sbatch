#!/bin/bash
#SBATCH -p cegs
#SBATCH -J fasta_shift
#SBATCH --mem=2g
#SBATCH --time=01:00:00
#SBATCH -o %x_%j.out

input=$1
shift_num=$2
input_base=`basename $input | sed 's/\..*//g'`
input_filetype=`basename $input | sed 's/.*\.//g'`

fasta_shift -i $input -p $shift_num > ${input_base}_anchored_${shift_num}.${input_filetype}

