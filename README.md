# *Macrocystis pyrifera* plastid assembly
A pipeline to assemble a plastid genome from *M. pyrifera* PacBio reads.

## The pipeline
### 1. BLAST reads against a custom plastid database to find *M. pyrifera* plastid reads
Convert sequencing FASTQs to FASTAs for BLAST using BBMap's reformat.sh:
```
mkdir fastas
conda activate bbmap
sbatch scripts/m-pyrifera-plastid-assembly/fastq_convert.sh
```

```
mkdir blast
```

