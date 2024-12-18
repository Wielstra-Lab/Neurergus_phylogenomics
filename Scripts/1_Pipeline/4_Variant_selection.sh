#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --time=0-01:00:00
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=variant_selection
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/variants/

module load VCFtools

vcftools --vcf Neurergus_Exchet.vcf --max-missing 0.5 --remove-indels --minQ 20 --recode --recode-INFO-all --out Neurergus0.5

perl /data1/s2321041/Neurergus/Scripts/4_subsampleVCF.pl Neurergus0.5.recode.vcf Neurergus0.5_SNPs_Subset.vcf
