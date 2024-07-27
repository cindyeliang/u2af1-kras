# u2af1-kras
Repository of scripts &amp; analysis used for U2AF1 KRAS project

Description of contents:
* TCGA Smoke vs Nonsmoker  JB Analysis: Analysis of JuncBASE output table of TCGA lung adenocarcinoma (ADC) primary sample data stratified by patient smoking status. Written by Cameron Soulette, Brooks lab alum
* CSC-EdU+pH3+LC3: Analysis of EdU and PHH3 fluorescent/immunofluorescent signal of HBECs with U2AF1 and KRAS mutations produced by immunostaining.
* DESeq2_Run_GeneExp: DESeq2 R commands used to perform differential gene expression analysis of HBECs with U2AF1 and KRAS mutations. All mutant cell lines were compared to the control, U2AF1 WT + LACZ genotype. 
* TCGA-LUAD-U2AF1-KRAS_pfiltered: Script used to analyze immune signature predictions of lung ADC primary sample data from TCGA that was analyzed with CIBERSORT. Script was written by Alexis Thornton, Brooks lab alum. Cindy Liang added p-value filtering for CIBERSORT input file and post-hoc statistical tests.
* U2AF1_KRAS_normexp_clone1vsclone2: Script used to plot and statistically analyze normalized gene expression values from DESeq2 of interesting genes (U2AF1 and KRAS) in U2AF1 and KRAS-mutant HBEC lines. 
* cbioportal_lungADC_co-occurringEGFR_KRAS_Other: Using lung ADC primary sample mutational status data downloaded from cBioPortal, calculate fractions of EGFR, KRAS and all other mutations.
* cbioportal_lungADC_co-occurringEGFR_KRAS_otherdrivers: Using lung ADC primary sample mutational status data downloaded from cBioPortal, calculate fractions of EGFR, KRAS and all other driver mutations as defined by Tessema et al. 2018.
* clone1_splicinganalysis: Exploratory differential splicing visualization for clone 1 HBEC JuncBASE results.
* clone2_splicinganalysis: Differential splicing visualization for clone 1 HBEC JuncBASE results. Includes filtering JuncBASE table for significant events, plotting differential splicing events in volcano plots, abundance of splicing event categories as a stacked bar plot, and delta percent spliced in (dPSI) values of genes in interesting biological pathways in heatmaps. 
* geneHeatmapsFromDESeq2: Script used to filter gene expression results from DESeq2 and produce an input file for Gene Set Enrichment Analysis (GSEA) Preranked analysis. Then, takes GSEA output and plots heat maps of enrichment scores for significantly enriched pathways. 
* juncbase_run: .sh file of JuncBASE commands and parameters used for this project. Run was performed by and file was created by Carlos Arevalo, Brooks lab alum
