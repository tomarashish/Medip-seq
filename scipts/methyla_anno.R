#Using chIPpeakAnno package for annotation of methylated data.

library(ChIPpeakAnno)
macs <- system.file("extdata", "disease_methylation.txt", package="ChIPpeakAnno")
macsOutput <- toGRanges(macs, format="MACS")

macs.anno <- annotatePeakInBatch(macsOutput, AnnotationData=TSS.human.GRCh38, output="overlapping", maxgap=5000L)
macs.anno <- addGeneIDs(annotatedPeak=macs.anno, orgAnn="org.Hs.eg.db",IDs2Add="symbol")
df.anno <- as.data.frame(macs.anno)
write.table(df.anno, file="normal_annotated.txt", sep="\t", row.names=F)

#creating tss feature plot
tss_feature <- table(as.data.frame(macs.anno)$insideFeature)
head(tss_feature)
#copy names and count to new data frame
feature <- c("downstram", "upstrams")
count<- c("2342","123124")
df <- data.frame(feature, count)

#use donut.r for plot
