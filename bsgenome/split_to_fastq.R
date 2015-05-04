###
library(Biostrings)
taes <- readDNAStringSet("chromosome_fasta/Triticum_aestivum_concat.fa")

### Send each chromosome to a FASTA file.
seqnames <- paste("chr_", c(1:7), rep(c("A","B","D"), c(7,7,7)),sep="")

#for mitochondrial and chloroplast genome
circ_seqs <-  c("chr_Mt", "chr_Pt")

for (seqname in seqnames) {
    seq <- taes[match(seqname, names(taes))]
    filename <- paste(seqname, ".fa", sep="")
    cat("writing ", filename, "\n", sep="")
    writeXStringSet(seq, file=filename, width=50L)
}

### Send the 1278 chrNN_*_random sequences to 1 FASTA file.
mt_seq <- taes[circ_seqs[1]]
writeXStringSet(mt_seq, file="chr_Mt.fa", width=50L)

### Send the 1439 chrUn_* sequences to 1 FASTA file.
pt_seq <- taes[circ_seqs[2]]
writeXStringSet(pt_seq, file="chr_Pt.fa", width=50L)
