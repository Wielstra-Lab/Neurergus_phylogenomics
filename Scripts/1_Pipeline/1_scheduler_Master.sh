#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --time=1-00:00:00
#SBATCH --mem=250GB
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/

module load skewer
module load VCFtools
module load BWA
module load SAMtools
module load picard

perl /data1/s2321041/Neurergus/Scripts/Master_BQSR.pl
