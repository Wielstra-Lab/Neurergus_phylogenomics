#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --mem-per-cpu=10G
#SBATCH --partition=gpu-long
#SBATCH --output=output_%j.txt
#SBATCH --time=7-00:00:00
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=SNAPPER_Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/Snapper/

/data1/s2321041/beast/bin/beast -threads $SLURM_CPUS_PER_TASK Neurergus.xml
