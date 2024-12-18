#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --time=0-01:00:00
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=HetExc
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/variants/

module load BCFtools

#creates a new .vcf file excluding the sites with heterozygote excess
bcftools +fill-tags Neurergus.g.vcf -Ou -- -t all | bcftools view -e'ExcHet<0.05' > Neurergus_Exchet.vcf
