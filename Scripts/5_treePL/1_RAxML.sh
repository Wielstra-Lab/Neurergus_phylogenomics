#!/bin/bash

#SBATCH --ntasks=2
#SBATCH --mem=150GB
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --time=1-00:00:00
#SBATCH --job-name=RAxML_Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/treePL/

/home/s2321041/standard-RAxML-8.2.12/raxmlHPC-PTHREADS-SSE3 -T 2 -m ASC_GTRGAMMA --asc-corr=lewis -o 1995_Triturus_marmoratus,7781_Triturus_marmoratus,5017_Triturus_marmoratus,312_Triturus_carnifex,292_Triturus_carnifex,405_Triturus_carnifex,3247_Triturus_macedonicus,3275_Triturus_macedonicus,3775_Triturus_macedonicus -n NeurBoot.tre -s "out.phy" -O -x 4 -N 100 -k -p 368 -w "/data1/s2321041/Neurergus/treePL"
