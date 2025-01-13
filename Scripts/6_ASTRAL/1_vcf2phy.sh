#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1-12:00:00
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=PGD_VCF2PHY
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Analyses/4.ASTRAL/4.2_vcf2phy/

module load Python/3.11.3-GCCcore-12.3.0

for FILE in /data1/s2321041/Analyses/4.ASTRAL/4.2_vcf2phy/*.vcf; do python3 vcf2phylip.py --input $FILE; done
