#!/bin/bash
#SBATCH -p cegs
#SBATCH --mem=115gb
#SBATCH -t 2-00
#SBATCH --cpus-per-task=12
#SBATCH -o racon_2_B01_chloro.out

seqs=2_B01_blast_reads_3.fq
alignment=2_B01_blastreads_vs_bestassemb.paf
assembly=chloro/2_B01_best_chloro_assemb.fasta

source ~/bin/anaconda3/etc/profile.d/conda.sh
if [[ -f $alignment ]]
then
  printf "Using existing alignment file: $alignment"
#elif [[ $1 == "bowtie2" ]]
#  conda activate rsem
#  printf "Running bowtie2 to create $alignment"
#  assembly_base=`echo $assembly | sed 's/\..*//g'`
#  bowtie2-build $assembly $assembly_base
#  bowtie2 -p 12 -f -U $seqs -x $assembly_base -S $alignment
else
  printf "Running minimap2 to create $alignment"
  conda activate minimap2
  assembly_base=`echo $assembly | sed 's/\..*//g'`
  minimap2 $assembly $seqs > $alignment 
fi

conda activate racon
racon -t 12 $seqs $alignment $assembly

