#!/bin/bash
#SBATCH -p cegs
#SBATCH -t 20:00:00
#SBATCH --mem=8g
#SBATCH -o getfasta_submit.out


cd Cp-hap


# subset GFF3 for Cp-hap
# copy GFF3 header
head -n3 chloro_best_assemb_tig00000001_GFF3.gff3 > IR_LSC_SSC_best_assemb_2_B01.gff3
# extract only GFF3 lines about large structural sequence features
tail -n4 chloro_best_assemb_tig00000001_GFF3.gff3 >> IR_LSC_SSC_best_assemb_2_B01.gff3
# have to do some reformatting for bedtools (can't handle circular FASTA)
# edit original LSC line
sed -i 's/18689/130056/g' IR_LSC_SSC_best_assemb_2_B01.gff3
# duplicate and edit LSC line just below the original
tail -n1 IR_LSC_SSC_best_assemb_2_B01.gff3 | sed 's/72422/1/g' | sed 's/130056/18689/g' >> IR_LSC_SSC_best_assemb_2_B01.gff3


# run bedtools' getfasta using subsetted GFF3 and assembly
source ~/bin/anaconda3/etc/profile.d/conda.sh
conda activate bedtools
bedtools getfasta -fi 2_B01_best_chloro_assemb.fasta -bed IR_LSC_SSC_best_assemb_2_B01.gff3 -fo 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled_ORIGINAL.fasta


# cleanup resulting FASTA
# remove line splitting LSC halves
sed -i '/>tig00000001:0-18689/d' 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled_ORIGINAL.fasta
# remove extra IR sequence with seqtk
grep '>' 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled_ORIGINAL.fasta | sed 's/>//g' | grep -v 'tig00000001:18689-24113' > IR_LSC_SSC_original_FASTA_IDs.txt
conda activate seqtk
seqtk subseq 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled_ORIGINAL.fasta IR_LSC_SSC_original_FASTA_IDs.txt > 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled.fasta
# rename sequence IDs for Cp-hap input
sed -i 's/tig00000001:66996-72421/ir/g' 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled.fasta
sed -i 's/tig00000001:24113-66996/ssc/g' 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled.fasta
sed -i 's/tig00000001:72421-130056/lsc/g' 2_B01_best_chloro_assemb_IR_LSC_SSC_labeled.fasta

