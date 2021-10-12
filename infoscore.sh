#!/bin/bash
#SBATCH --job-name=infoscore         # Job name
#SBATCH --partition=highmem_p             # Partition (queue) name
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=500gb                     # Job memory request
#SBATCH --time=167:00:00               # Time limit hrs:min:sec
#SBATCH --output=infoscore.%j.out    # Standard output log
#SBATCH --error=infoscore.%j.err     # Standard error log
#SBATCH --array=1-22		#Run as array job

i=$SLURM_ARRAY_TASK_ID

cd /work/kylab/mike/Fall2021practice/INFOscore

#Load required packages and modules
ml PLINK/2.00-alpha2.3-x86_64-20210920-dev

#-----------
#steps
#-----------
step1=false
step2=true
#-----------


if [ $step1 = true ]; then
###-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#STEP 1: Filter UKB imputation SNPs by 0.5 quality score.
###-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

mfidir=("/scratch/mf91122/Fall2021practice/UKBpgen/mfi")
outdir=$mfidir/info0.5

mkdir -p $outdir

for i in {1..22}
	do

awk '{if ($8 >= 0.5) print $2}'	$mfidir/ukb_mfi_chr"$i"_v3.txt > $outdir/ukb_mfi_chr"$i"_v3_0.5.txt
echo chromosome $i completed

done

fi #end step 1


if [ $step2 = true ]; then
###-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#STEP 2: Make new genotype files with only INFO>=0.5=-=-
###-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#Set in/out directories
genodir=("/scratch/mf91122/Fall2021practice/UKBpgen")
infodir=("/scratch/mf91122/Fall2021practice/UKBpgen/mfi/info0.5")
outdir=("/scratch/mf91122/Fall2021practice/genotypeQC")

#create output directory
mkdir -p $outdir


plink2 \
--pfile $genodir/chr"$i" \
--extract $infodir/ukb_mfi_chr"$i"_v3_0.5.txt \
--make-pgen \
--out $outdir/chr"$i"

fi #close if
