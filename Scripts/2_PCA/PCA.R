###Script written by Peter Scott UCLA

#set working directory
setwd("C:/Users/steph/OneDrive/Documenten/Analyses/Neurergus/PCA")
getwd()

#install.packages("ggplot2")
#if (!requireNamespace("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")
#BiocManager:::install("gdsfmt")
#BiocManager:::install("SNPRelate")

library("tidyverse")
library("ggplot2")
library("rlang")
library(gdsfmt)
library(SNPRelate)
library(ggplot2)
library(RColorBrewer)
library(cowplot)
library(ggrepel)
library(wesanderson)

vcf_ERC_Comb_rawgvcf <- "C:/Users/steph/OneDrive/Documenten/Analyses/Neurergus/PCA/Neurergus.g.vcf"

snpgdsVCF2GDS(vcf_ERC_Comb_rawgvcf, "C:/Users/steph/OneDrive/Documenten/Analyses/Neurergus/PCA/Neurergusvcf.gds", method="biallelic.only")

snpgdsSummary("C:/Users/steph/OneDrive/Documenten/Analyses/Neurergus/PCA/Neurergusvcf.gds")

vcf_ERC_Comb_allrawgvcf_gds<- snpgdsOpen("C:/Users/steph/OneDrive/Documenten/Analyses/Neurergus/PCA/Neurergusvcf.gds")

###new try phylogeny
set.seed(100)

par(mar=c(4,1,1,1))
par("mar")

#dissimilarity matrix
trial_dissim <- snpgdsHCluster(snpgdsIBS(vcf_ERC_Comb_allrawgvcf_gds,num.thread=2,autosome.onl=FALSE))
#maketree
cut_tree <- snpgdsCutTree(trial_dissim)
cut_tree
#save dendogram
dendogram = cut_tree$dendrogram

dendogram

snpgdsDrawTree(cut_tree,clust.count=NULL,dend.idx=NULL,
               type=c("dendrogram", "z-score"), yaxis.height=TRUE, yaxis.kinship=TRUE,
               y.kinship.baseline=NaN, y.label.kinship=FALSE, outlier.n=NULL,
               shadow.col=c(rgb(0.5, 0.5, 0.5, 0.25), rgb(0.5, 0.5, 0.5, 0.05)),
               outlier.col=rgb(1, 0.50, 0.50, 0.5), leaflab="perpendicular",
               labels=NULL, y.label=0.2)
plot(cut_tree$dendogram,horiz=T,main="trial dendogram SNP Tree")

###PCA
pca_vcf_ERC_Comb_allrawgvcf <- snpgdsPCA(vcf_ERC_Comb_allrawgvcf_gds, autosome.only = FALSE)
pca_vcf_ERC_Comb_allrawgvcf
pc.percent <- pca_vcf_ERC_Comb_allrawgvcf$varprop*100
(round(pc.percent, 2))

tab <- data.frame(sample.id = pca_vcf_ERC_Comb_allrawgvcf$sample.id,
                  EV1 = pca_vcf_ERC_Comb_allrawgvcf$eigenvect[,1], # the first eigenvector
                  EV2 = pca_vcf_ERC_Comb_allrawgvcf$eigenvect[,2], # the second eigenvector
                  stringsAsFactors = FALSE)
head(tab)

vcf_ERC_Comb_allrawgvcf_names<-read.csv("C:/Users/steph/OneDrive/Documenten/Analyses/Neurergus/PCA/Neurergus_list.txt",sep="\t")
head(vcf_ERC_Comb_allrawgvcf_names)

##plot PCA with no colors
plot(tab$EV2, tab$EV1, xlab="eigenvector 2", ylab="eigenvector 1")

####This is for Ben's PC1-2 and PC1-3 plots with 4 or 8 colors

pop=vcf_ERC_Comb_allrawgvcf_names$pop.code
sp=vcf_ERC_Comb_allrawgvcf_names$sp.code
cat=vcf_ERC_Comb_allrawgvcf_names$cat.code


### ALL RAW POP COLUMN TABS ###
### COUNTRIES

tab12 <- data.frame(sample.id = vcf_ERC_Comb_allrawgvcf_names$sample.id,
                    Species = vcf_ERC_Comb_allrawgvcf_names$sample.number,
                    EV1 = pca_vcf_ERC_Comb_allrawgvcf$eigenvect[,1], # the first eigenvector
                    EV2 = pca_vcf_ERC_Comb_allrawgvcf$eigenvect[,2], # the second eigenvector
                    key = pop)

tab34 <- data.frame(sample.id = vcf_ERC_Comb_allrawgvcf_names$sample.id,
                    Species = vcf_ERC_Comb_allrawgvcf_names$sample.number,
                    EV3 = pca_vcf_ERC_Comb_allrawgvcf$eigenvect[,3], # the third eigenvector
                    EV4 = pca_vcf_ERC_Comb_allrawgvcf$eigenvect[,4], # the fourth eigenvector
                    stringsAsFactors = FALSE)

#Choose: 1st = all labels, 2nd is only a few/not too much overlapping
options(ggrepel.max.overlaps = Inf)
#options(ggrepel.max.overlaps = 10)

sp.colors8<-c("cyan4", "cyan", "mediumorchid1","blue", "maroon3", "yellow", "darkgoldenrod3", "green")

gplot12 <- ggplot(tab12, aes(EV1,EV2,color=Species)) + geom_point(size=3) +
  scale_color_manual(values = sp.colors8) + 
  xlab("PC1 (15.62%)") +
  ylab("PC2 (8.99%)") +
  theme_bw() 

gplot34 <- ggplot(tab34, aes(EV3,EV4,color=Species)) + geom_point(size=3) +
  scale_color_manual(values = sp.colors8) +
  xlab("PC3 (7.21%)") +
  ylab("PC4 (2.88%)") +
  theme_bw() 

gplot12
gplot34
