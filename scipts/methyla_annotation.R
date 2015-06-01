#Methylation annotation using chipseeker 

#install the following packages if not installed

#source("http://bioconductor.org/biocLite.R")
#biocLite("clusterProfiler")
#biocLite(ChIPseeker)
#biocLite("AnnotationDbi")
#biocLite(TxDb.Hsapiens.UCSC.hg19.knownGene)

#load required packages
require(ChIPseeker)
require(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
require(clusterProfiler)

file.n = "normal_methylation.txt"
file.d = "disease_methylation.txt"

peak.n <- readPeakFile(file.n)
peak.d <- readPeakFile(file.d)

#coverage plot
covplot(peak,weightCol="disease_count", chrs=c("chr17","chr18"),xlim=c(4.5e7,5e7))

#peak annotation
normal_peak<- annotatePeak(file.n, tssRegion = c(-3000,2000),TxDb =txdb, annoDb= "org.Hs.eg.db")
disease_peak <- annotatePeak(file.d, tssRegion = c(-3000,2000),TxDb =txdb, annoDb= "org.Hs.eg.db")


require(clusterProfiler)
bp.n <- enrichGO(as.data.frame(normal_peak)$geneId,ont="BP",readable=TRUE)
bp.d <- enrichGO(as.data.frame(disease_peak)$geneId,ont="BP",readable=TRUE)

cc.n <- enrichGO(as.data.frame(normal_peak)$geneId,ont="CC",readable=TRUE)
cc.d <- enrichGO(as.data.frame(disease_peak)$geneId,ont="CC",readable=TRUE)

mf.n <- enrichGO(as.data.frame(normal_peak)$geneId,ont="MF",readable=TRUE)
mf.d <- enrichGO(as.data.frame(disease_peak)$geneId,ont="MF",readable=TRUE)


head(summary(bp.n),n=3)
x <- groupGO(gene =as.data.frame(disease_peak)$geneId , organism = "human", ont = "CC", level = 2, readable = TRUE)
df <- summary((x))
cc_anno <- df[2:3]
