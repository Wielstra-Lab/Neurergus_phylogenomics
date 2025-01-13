#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --time=1-00:00:00
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=Lissotriton
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

module load Java/11.0.20

cd /data1/s2321041/Neurergus/ASTRAL/

java -jar /home/s2321041/Astral/astral.5.7.8.jar -i NeurBest.tre -o NeurASTRAL.tre -a mapping.txt
