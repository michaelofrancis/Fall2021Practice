#!/bin/bash
#SBATCH --job-name=practiceGWAS1         # Job name
#SBATCH --partition=highmem_p             # Partition (queue) name
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=300gb                     # Job memory request
#SBATCH --time=167:00:00               # Time limit hrs:min:sec
#SBATCH --output=practiceGWAS1.%j.out    # Standard output log
#SBATCH --error=practiceGWAS1.%j.err     # Standard error log

#This script runs a basic test GWAS using PLINK2

#Set working directory
cd /work/kylab/mike/Fall2021practice/practiceGWAS1

#Load required packages and modules
ml PLINK/2.00-alpha2.3-x86_64-20210505-dev

#Set in/out directories
genoindir=("/scratch/mf91122/Fall2021practice/UKBpgen")
phenodir=("/scratch/mf91122/UKB-pheno")
outdir=("/scratch/mf91122/Fall2021practice/practiceGWAS1")

#create output directory
mkdir -p $outdir

for i in {1..22}
	do

#i=22 #test on chr22

#Run plink2
plink2 \
--pfile $genoindir/chr"$i" \
--pheno $phenodir/phenotable-09232021.txt \
--pheno-name LDL \
--covar $phenodir/phenotable-09232021.txt \
--covar-name Sex, Age \
--maf 0.01 \
--geno 0.02 \
--mind 0.05 \
--glm \
--out $outdir/chr"$i"_test1

done
