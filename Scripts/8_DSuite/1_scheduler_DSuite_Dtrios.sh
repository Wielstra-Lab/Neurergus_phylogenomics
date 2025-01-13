#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3:00:00
#SBATCH --partition=cpu_natbio
#SBATCH --mem=20GB
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=DSuite-Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/DSuite/

# FOR DTRIOS WITH TREE (USES AN OUTGROUP)
/data1/s2321041/Dsuite/Build/Dsuite Dtrios --tree=NeurergusAstral.nwk NeurOut.g.vcf NeurOut.txt
