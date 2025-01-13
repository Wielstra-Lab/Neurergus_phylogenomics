#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=K_Admixture_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

#This script can be used to determine k, the number of ancestral populations, for admixture analysis
cd /data1/s2321041/Neurergus/Admixture

mkdir -p K_Admixture
cd K_Admixture

#specify file
FILE=Neurergus1_SNPs_Subset

#load modules locally (previously installed in home)
module use $HOME/plink
module use $HOME/admixture

#generate the input file in plink format
$HOME/plink --vcf /data1/s2321041/Neurergus/Admixture/$FILE.vcf --make-bed --out $FILE --allow-extra-chr --double-id

#For admixture change chromosomes to integers
awk '{$1=0;print $0}' $FILE.bim > $FILE.bim.tmp
mv $FILE.bim.tmp $FILE.bim

#run admixture multiple times
mkdir -p runs
cd runs

for k in {1..20}
do
	for r in {1..5}
	do
	$HOME/admixture -s ${RANDOM} --cv=10 /data1/s2321041/Neurergus/Admixture/K_Admixture/$FILE.bed $k > log.${k}.${r}.out
	done
done

#Creating input file for CVplot in R(studio) on desktop
cd ..

grep -h CV runs/log*.out |sed "s/CV error (K=//" | sed "s/)://" > CV_error
