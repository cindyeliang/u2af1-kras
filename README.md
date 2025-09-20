# u2af1-kras
Repository of scripts &amp; analysis used for U2AF1 KRAS project. Data files (DESeq2 contrast results, JuncBASE differential expression results) are also uploaded on GEO under GSE267349. Additional commands used during preprocessing such as alignment and generation of the counts files used for DESeq2 can be found in the methods section of our [preprint](https://www.biorxiv.org/content/10.1101/2024.09.11.612492v1.full).

## Description of contents:
* [TCGA Smoke vs Nonsmoker JB Analysis](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/20180821%20TCGA%20Smoker%20vs%20NonSmoker%20JB%20Analysis.ipynb): Analysis of JuncBASE output table of TCGA lung adenocarcinoma (ADC) primary sample data stratified by patient smoking status. Written by Cameron Soulette, Brooks lab alum
* [CSC-EdU+pH3+LC3](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/20240308-CSC-EdU%2BpH3%2BLC3.ipynb): Analysis of EdU and PHH3 fluorescent/immunofluorescent signal of HBECs with U2AF1 and KRAS mutations produced by immunostaining.
* cbioportal_lungADC_co-occurringEGFR_KRAS_Other: Using lung ADC primary sample mutational status data downloaded from cBioPortal, calculate fractions of EGFR, KRAS and all other mutations.
* [cbioportal_lungADC_co-occurringEGFR_KRAS_otherdrivers](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/cbioportal_lungADC_co-occurringEGFR_KRAS_Other.ipynb): Using lung ADC primary sample mutational status data downloaded from cBioPortal, calculate fractions of EGFR, KRAS and all other driver mutations as defined by Tessema et al. 2018.
### Gene expresion analysis
* [clone_1_clone_2_deseq2_batch_correction.Rmd](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/clone_1_clone_2_deseq2_batch_correction.Rmd) : Collapsing of clone 1 technical replicates and batch correction of samples to account for clones. Used to generate PCA for QC
* [20250402clone_1_clone_2_deseq2_analysis]([https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/DESeq2_Run_GeneExp](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/20250402clone_1_clone_2_deseq2_analysis.Rmd)): DESeq2 R commands used to perform differential gene expression analysis of HBECs with U2AF1 and KRAS mutations. All mutant cell lines were compared to the control, U2AF1 WT + LACZ genotype. Since preprint submission, this analysis has been updated to include additional technical replicates of clone 1 to obtain more equivalent sequencing depth to clone 2!
* [20250318geneHeatmapsFromDESeq2](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/20250318geneHeatmapsFromDESeq2.ipynb): Script used to filter gene expression results from DESeq2 and produce an input file for Gene Set Enrichment Analysis (GSEA) Preranked analysis. Then, takes GSEA output and plots heat maps of enrichment scores for significantly enriched pathways. Since preprint submission, this analysis has been updated to include additional technical replicates of clone 1 to obtain more equivalent sequencing depth to clone 2!
### Splicing analysis
* [02252025_Juncbase_run.sh](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/02252025_Juncbase_run.sh): JuncBASE commands used to perform differential splicing analysis on both HBEC clones, with additional clone 1 technical replicates. Performed by Selam Mehreteab.
* [U2AF1_KRAS_Clone_1_and_2_GSEA-3](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/U2AF1%20KRAS%20Clone%201%20and%202%20GSEA-3.ipynb): GSEA analysis of splicing results from JuncBASE. Performed by Selam Mehreteab.
* [both_clones_splicing_analysis-2](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/%20both_clones_splicing_analysis-2.ipynb): Summary analyses of differential splicing for HBEC genotypes of both clones (splicing event type proportions, volcano plots). Performed by Selam Mehreteab.
* [20250128_SG_analysis_combineclones-normbywtdmso_spotintensityonly](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/20250128_SG_analysis_combineclones-normbywtdmso_spotintensityonly.ipynb): Stress granule fluorescent signal intensity analysis for HBEC lines harboring only U2AF1 S34F mutation, compared to wild-type
* [stacked_barplot_fishers_test](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/stacked_barplot_fishers_test.R): Statistical analysis to compare differential splice event usage between HBEC genotyps (for stacked bar plot of event proportions). Performed by Selam Mehreteab.
#### Splicing analysis input files & preprocessing:
* [sample_manifest.py](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/sample_manifest.py) : Script used to create sample to bam manifest file to run JuncBASE. Performed by Selam Mehreteab.
* [u2af1kras_samp2bam_docker.txt](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/u2af1kras_samp2bam_docker.txt) : sample to bam manifest file for JuncBASE
##### Unnamed gene list: JuncBASE will occasionally fail to assign gene names to splice junctions close to neighboring genes. In these cases, we manually annotate gene names by examining coordinates on alignments on IGV. The events manually annotated are in these files.
* https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/wtkv12_nas%20-%20wtkv12_nas.csv
* https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/s34flacz_nas%20-%20s34flacz_nas.csv
* https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/s34fkv12_nas%20-%20s34fkv12_nas.csv
* After naming, we combine these events with the pre-named events to create the final junction counts tables. These are used to run GSEA analysis on the splicing results.
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nojcnonly_named_s34fkv12.csv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nojcnonly_named_s34flacz.csv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nojcnonly_named_wtkv12.csv
* individual sample-level PSI tables (JuncBASE output used by the tool to obtain delta PSI values in the above tables)
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvsS34Fkv12_clone1_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvsS34Fkv12_clone2_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvsS34Flacz_clone1_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvsS34fkv12_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvsS34flacz_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvswtkraswt_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvswtkv12_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvswtkv12_clone1_PSI.tsv
  * https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/nonredundant_JuncBase_wt_laczvswtkv12_clone2_PSI.tsv

### Archived: 
* DESeq2_Run_GeneExp: DESeq2 R commands used to perform differential gene expression analysis of HBECs with U2AF1 and KRAS mutations. All mutant cell lines were compared to the control, U2AF1 WT + LACZ genotype.
* clone1_splicinganalysis: Exploratory differential splicing visualization for clone 1 HBEC JuncBASE results.
* clone2_splicinganalysis: Differential splicing visualization for clone 1 HBEC JuncBASE results. Includes filtering JuncBASE table for significant events, plotting differential splicing events in volcano plots, abundance of splicing event categories as a stacked bar plot, and delta percent spliced in (dPSI) values of genes in interesting biological pathways in heatmaps. 
* juncbase_run: .sh file of JuncBASE commands and parameters used for this project. Run was performed by and file was created by Carlos Arevalo, Brooks lab alum
* U2AF1_KRAS_normexp_clone1vsclone2: Script used to plot and statistically analyze normalized gene expression values from DESeq2 of interesting genes (U2AF1 and KRAS) in U2AF1 and KRAS-mutant HBEC lines.
* geneHeatmapsFromDESeq2: Script used to filter gene expression results from DESeq2 and produce an input file for Gene Set Enrichment Analysis (GSEA) Preranked analysis. Then, takes GSEA output and plots heat maps of enrichment scores for significantly enriched pathways.
* [TCGA-LUAD-U2AF1-KRAS_pfiltered](https://github.com/cindyeliang/u2af1-kras/blob/main/scripts/TCGA-LUAD-U2AF1-KRAS_pfiltered.ipynb): Script used to analyze immune signature predictions of lung ADC primary sample data from TCGA that was analyzed with CIBERSORT. Script was written by Alexis Thornton, Brooks lab alum. Cindy Liang added p-value filtering for CIBERSORT input file and post-hoc statistical tests.
