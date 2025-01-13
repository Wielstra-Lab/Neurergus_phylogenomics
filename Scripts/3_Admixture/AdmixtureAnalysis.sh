#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=cpu_natbio
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=Admixture_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user=

#Go to the directory where you want to run the analysis, and make a new folder named "admixture". Then go to that folder.
cd /data1/s2321041/Neurergus/Admixture

mkdir -p Admixture_k5
cd Admixture_k5

#Specify your filename without the extension (the extension is specified when the file is called). Judging  from the name, this was a subset of SNPs, probably in a vcf, since the input file that is called in the next step is a .vcf.
FILE=Neurergus1_SNPs_Subset

#Load the modules and make them run on HOME
module use $HOME/plink
module use $HOME/admixture

#Generate input files in plink format. Since you specified FILE earlier, your filename is automatically called with $FILE.
##I added --geno 0.1, since I did not do a quality control yet, and I had SNPs without genotypes, so admixture crashed.
###https://github.com/roberta-davidson/ADMIXTURE-smartPCA-PLINK-and-EIGENSOFT
$HOME/plink --vcf /data1/s2321041/Neurergus/Admixture/$FILE.vcf --make-bed --out $FILE --allow-extra-chr --double-id

#For admixture change chromosomes to integers (basically assign a whole number to each chromosome). It does so in a temporary file, then saves that file with the same extension as the input had.
awk '{$1=0;print $0}' $FILE.bim > $FILE.bim.tmp
mv $FILE.bim.tmp $FILE.bim

#Runs admixture 25 times. K is the number of ancestral populations. cv is the amount of times you cross-validate.
mkdir -p runs
cd runs

K=5
for r in {1..25}
do
	$HOME/admixture -s ${RANDOM} --cv=10 /data1/s2321041/Neurergus/Admixture/Admixture_k5/$FILE.bed $K > log${r}.out
	mv $FILE.${K}.Q $FILE.${K}${r}.Q
done

#Zips all your admixture files, then removes the unzipped files.
zip ${FILE}.admixture.zip *Q
rm *Q
