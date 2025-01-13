#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --time=1-00:00:00
#SBATCH --job-name=TreePL_Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/treePL/

source /cm/shared/easybuild/software/AMUSE-Miniconda2/4.7.10/etc/profile.d/conda.sh
conda activate /data1/s2321041/treepl

/data1/s2321041/treepl/treePL 2_Neurergus_treePL.txt
