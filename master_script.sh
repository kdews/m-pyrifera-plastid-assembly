

all_reads=gk_pacbio/2_B01.fastq.gz
blast_reads=chloro/2_B01_blast_reads_3.fa
blast_read_IDs=`basename $assembly_for_racon | sed 's/\..*//g'`_IDs.txt
reads_for_racon=2_B01_blast_reads_3.fq
assembly_for_racon=chloro/2_B01_best_chloro_assemb.fasta
alignment_for_racon=2_B01_blastreads_vs_bestassemb.paf
afr_base=`basename $assembly_for_racon | sed 's/\..*//g'`
afr_filtype=`basename $assembly_for_racon | sed 's/.*\.//g'`
polished_assembly=${afr_base}_racon.${afr_filetype}
related_genome=seed_fastas/u_pinnat_plastid.fasta

# Extract FASTQ reads matching BLAST-identified plastid reads
grep ">" $blast_reads > $blast_read_IDs
sbatch m-pyrifera-plastid-assembly/seqtk_subseq_submit.sbatch\
 $all_reads $blast_read_IDs $reads_for_racon
# Run racon to polish plastid genome
sbatch racon_submit.sbatch $reads_for_racon $assembly_for_racon\
 $alignment_for_racon
# Visualize effect of polishing with mummer
sbatch scripts/mummer_submit.sbatch $assembly_for_racon
# Run mummer to compare polished/unpolished assemblies w/ related plastid
sbatch scripts/mummer_submit.sbatch $polished_assembly $related_genome
sbatch scripts/mummer_submit.sbatch $assembly_for_racon $related_genome
# Anchor assemblies (if needed)
pol_base=`basename $polished_assembly | sed 's/\..*//g'`
unpol_base=`basename $assembly_for_racon | sed 's/\..*//g'`
related_base=`basename $related_genome | sed 's/\..*//g'`
base_mum1=${pol_base}_vs_${unpol_base}
base_mum2=${pol_base}_vs_${related_base}
base_mum3=${unpol_base}_vs_${related_base}
for i in $base_mum1 $base_mum2 $base_mum3
do
  test_mum=grep -v ">" ${i}/${i}.mums | awk '{print $1}' | head -n1
  if [[ $test_mum = "1" ]]
  then
    continue
  else
    min_mum=grep -v ">" ${i}/${i}.mums | awk '{print $2}' | sort -h | head -n1
    
    sbatch scripts/fasta_shift_submit.sbatch $polished_assembly 
sbatch scripst/fasta_shift_submit.sbatch $assembly_for_racon 

