#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=GEM-TxS-M1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=144:00:00
#SBATCH --mem=30000
#SBATCH --output=GEM-TxS.%j.out
#SBATCH --error=GEM-TxS.%j.err
#SBATCH --array=1-22

i=$SLURM_ARRAY_TASK_ID

cd /work/kylab/mike/TxSmoking/GEM

#ml PLINK/2.00-alpha2.3-x86_64-20210920-dev
ml GEM/1.4.1-foss-2019b


genoindir=("/scratch/mf91122/TxSmoking/genotypeQC/GEM1")
phenodir=("/scratch/mf91122/TxSmoking/pheno/final")
outdir=("/scratch/mf91122/TxSmoking/GEM")

phenotypes=("LDL" "HDL" "Tot_Chol")

exposures=("Consistent_Self_Reported_Vegetarian_across_all_24hr" "Self_Reported_Vegetarian_plus_strict_initial_and24")


for j in ${phenotypes[@]} 
        do

for e in ${exposures[@]} 
        do

mkdir -p $outdir/$j

echo running "$j" and "$e"


GEM \
--bgen $genoindir/chr"$i".bgen \
--sample $genoindir/chr"$i".sample \
--pheno-file $phenodir/TxSmoking-model1-"$k"-10262021.csv \
--sampleid-name IID \
--pheno-name $j \
--covar-names Age Sex Geno_batch center1 center2 center3 center4 center5 \
center6 center7 center8 center9 center10 \
center11 center12 center13 center14 center15 \
center16 center17 center18 center20 center21 \
PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 \
--robust 1 \
--exposure-names "$e" \
--out $outdir/$j/"$j"x"$e"-10262021-chr"$i"

done
done
