#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3:00:00
#SBATCH --partition=cpu_natbio
#SBATCH --mem=20GB
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=Fbranch-Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/DSuite/

# FOR FBRANCH (USES THE DTRIOS _tree.txt OUTPUT AND THE .nwk FILE WITH OUTGROUP)

/data1/s2321041/Dsuite/Build/Dsuite Fbranch NeurergusAstral.nwk NeurOut_tree.txt > output_fbranch.txt
