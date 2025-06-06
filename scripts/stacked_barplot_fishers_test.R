---
title: "stacked_barplot_fishers_test"
author: "Selam Mehreteab(smehrete@ucsc.edu)"
date: "`r format(Sys.time(), '%B %d, %Y')`"
purpose: "Run fishers test on stacked barplot"
---

library(rstatix)

xtab <- as.table(rbind( c(209,51), c(104,12), c(180,79), c(212,92), c(636,298), c(18,1), c(7,3), c(44,0)))


dimnames(xtab) <- list( Class = c('Alternative acceptor', 'Alternative donor', 'Alternative first exon', 'Alternative last exon', 'Cassette', 'Coordinate cassette', 'Mutually exclusive', 'Intron retention'), Mutation = c("U2AF1 S34F LACZ", "U2AF1 S34F KRAS G12V"))


xtab <- row_wise_fisher_test(xtab)

write.csv(as.data.frame(xtab), file='~/Desktop/stacked_barplot_fishers_test')

