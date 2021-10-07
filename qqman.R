library(tidyverse)
library(qqman)

#Load input file
indir="/scratch/mf91122/Fall2021practice/practiceGWAS1"

infile<-read.table(paste(indir,"chr1_test1.LDL.glm.linear", 
				sep="/"),
		header=FALSE, stringsAsFactors=FALSE)

#Set column names
colnames(infile)<-c("CHROM","POS","ID","REF",
		"ALT","A1","TEST","OBS_CT",
		"BETA",	"SE","T_STAT","P","ERRCODE")

#Get table in qqman format
sub<-infile[infile$TEST=="ADD",] #base R way
sub<-sub%>%select(CHROM, POS, P, ID) #grab columns we need
colnames(sub)<-c("CHR", "BP", "P", "SNP")

#Make output for manhattan plot
plotoutputpath<-paste(indir, "/plot", sep="")
dir.create(plotoutputpath, showWarnings=FALSE) #make plot dir
plotoutputfile<-paste(plotoutputpath, "/chr1man.png",sep="")

#run manhattan plot
png(filename=plotoutputfile, type="cairo")
manhattan(sub, 
	ylim = c(0, 100)
	)
dev.off() 
