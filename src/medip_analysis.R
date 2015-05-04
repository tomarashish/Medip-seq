#!/usr/bin/env Rscript
#loading required libraries
library(BSgenome)
library(MEDIPS)
library("BSgenome.Taestivum")

#Creating parameter list 
ws = 500	#window size
shift = 0	#using extend
extend = 300	
uniq = TRUE	#mapping to unique reads
BSgenome = "BSgenome.Taestivum"	#BSgenome package

#Getting bam file path 
bam.file.A.MeDIP = "A.bam"
bam.file.B.MeDIP = "C.bam"
 
#creating set of two conditions
normal_medip = MEDIPS.createSet(file = bam.file.A.MeDIP, BSgenome = BSgenome, uniq = uniq, extend = extend, shift = shift, window_size = ws)

control_medip = MEDIPS.createSet(file = bam.file.B.MeDIP, BSgenome = BSgenome, uniq = uniq, extend = extend, shift = shift, window_size = ws)

#CAlculating correlation among sample
correlation = MEDIPS.correlation(MSets=c(normal_medip, control_medip), plot = T, method="pearson")

# Description The function calculates the local densities of a defined sequence pattern (e.g. CpGs) and returns a
# COUPLING SET object which is necessary for normalizing MeDIP data
CS = MEDIPS.couplingVector(pattern="CG", refObj=control_medip)
#jpeg("calibration_plot.jpg")
#MEDIPS.plotCalibrationPlot(CSet = CS, main = "Calibration Plot", MSet = normal_medip, rpkm = TRUE,xrange = TRUE)
#dev.off()

mr.edgeR = MEDIPS.meth(MSet1 = normal_medip, MSet2 = control_medip, CSet = CS, p.adj = "bonferroni", diff.method = "edgeR", prob.method = "poisson", MeDIP = T, CNV = F,type = "rpkm", minRowSum = 1)

mr.edgeR.s = MEDIPS.selectSig(results = mr.edgeR, p.value = 0.1, adj = T, ratio = NULL, bg.counts = NULL, CNV = F) 
write.table(mr.edgeR.s , file="diif_meth_CD.txt", sep="\t")
#

mr.edgeR.s.gain = mr.edgeR.s[which(mr.edgeR.s[, grep("logFC",colnames(mr.edgeR.s))] > 0), ]
mr.edgeR.s.gain.m = MEDIPS.mergeFrames(frames = mr.edgeR.s.gain,distance = 1)
columns = names(mr.edgeR)[grep("counts", names(mr.edgeR))]
rois = MEDIPS.selectROIs(results = mr.edgeR, rois = mr.edgeR.s.gain.m, columns = columns, summarize = NULL)
rois.s = MEDIPS.selectROIs(results = mr.edgeR, rois = mr.edgeR.s.gain.m, columns = columns, summarize = "avg")

#write to table
write.table(rois.s, file="merged_region_methylation_CD.txt", sep = "\t")
