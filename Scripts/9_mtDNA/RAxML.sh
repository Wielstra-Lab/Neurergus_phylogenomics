#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --time=1-00:00:00
#SBATCH --job-name=RAxML_Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/mtDNA/

/home/s2321041/standard-RAxML-8.2.12/raxmlHPC-PTHREADS-SSE3 -T 2 -m GTRGAMMA -q "partition.txt" -o Triturus_marmoratus_HQ697279,Triturus_carnifex_HQ697272,Triturus_macedonicus_HQ697278 -n NeurBoot.tre -s "NeurergusND4.fasta" -O -x 4 -N 100 -k -p 22335 -w "/data1/s2321041/Neurergus/mtDNA"
