df1 <- read.table("merged_region_methylation_GH.txt", sep="\t", header=T)
sampleA = data.frame(df1$chr, df1$start, df1$end, df1$G.bam.counts)
sampleB = data.frame(df1$chr, df1$start, df1$end, df1$H.bam.counts)
mr.edgeR.s.gainA = sampleA[which(sampleA[, grep("G.bam.counts", colnames(sampleA))] > 10), ]
mr.edgeR.s.gainB = sampleB[which(sampleB[, grep("H.bam.counts", colnames(sampleB))] > 10), ]
mr.edgeR.s.gain.mA = MEDIPS.mergeFrames(frames = mr.edgeR.s.gainA, distance = 1)
mr.edgeR.s.gain.mB = MEDIPS.mergeFrames(frames = mr.edgeR.s.gainB, distance = 1)

columnA = names(sampleA)[grep("G.bam.counts", names(sampleA))]
columnB = names(sampleB)[grep("H.bamcounts", names(sampleB))]

roisA = MEDIPS.selectROIs(results = sampleA, rois = mr.edgeR.s.gain.mA, columns = columns, summarize = NULL)
roisB = MEDIPS.selectROIs(results = sampleB, rois = mr.edgeR.s.gain.mB, columns = columns, summarize = NULL)

