#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=10G
#SBATCH --partition=gpu-long
#SBATCH --output=output_%j.txt
#SBATCH --time=3-00:00:00
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=RAxML_Neurergus
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

cd /data1/s2321041/Neurergus/RAxML/

/home/s2321041/standard-RAxML-8.2.12/raxmlHPC-PTHREADS-SSE3 -T 2 -f a -x 609516 -p 609516 -N 100 -m ASC_GTRGAMMA --asc-corr=lewis -O -n NeurOut.tre -s "out.phy" -w "/data1/s2321041/Neurergus/RAxML"
