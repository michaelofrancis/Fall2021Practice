library(tidyverse)

#Load dataset - takes 15 min
tab<-read.delim("/scratch/mf91122/UKB-pheno/ukb34137.tab", header=TRUE, 
		stringsAsFactors=FALSE)

tab<-as_tibble(tab)
tabbackup<-tab

#Grab the columns we want
ourtab<-tab[c("f.eid", "f.31.0.0", "f.21003.0.0", "f.22001.0.0",
			"f.21000.0.0", "f.54.0.0", "f.22000.0.0", "f.189.0.0",
                        "f.40007.0.0",
                        "f.30690.0.0", "f.30780.0.0", "f.30870.0.0", "f.22020.0.0",
                        "f.22027.0.0", "f.22019.0.0",
                        "f.22021.0.0", "f.22006.0.0",
			"f.20080.0.0", "f.20080.1.0", "f.20080.2.0",
           		"f.20080.3.0", "f.20080.4.0")]

colnames(ourtab)<-c("IID", "Sex", "Age", "Genetic_sex",
		"Race", "Assessment_center", "Geno_batch","Townsend",
                        "Death_Age",
                      "Tot_Chol", "LDL", "TAGs", "Used_in_PCA",
                      "Outliers_for_het_or_missing", "SexchrAneuploidy",
                      "Genetic_kinship", "Genetic_ethnic_grouping",
			sprintf("daycol.%s", 0:4))

ourtab$FID<-outtab$IID
ourtab<-ourtab%>%select(FID, everything())

write.table(ourtab, "/scratch/mf91122/UKB-pheno/phenotable-09232021.txt", 
		sep="\t", row.names=FALSE, quote=FALSE)
