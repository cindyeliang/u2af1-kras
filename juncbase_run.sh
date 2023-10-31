

####################################################################################################
### JuncBASE command
####################################################################################################

python run_preProcess_by_chr_step1.py \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/juncbase_samp2bam.tsv \
	-o /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	--preProcess_options "–unique -j /private/groups/brookslab/U2AF1-KRAS-RNA-seq/Analysis_v1_Amit/JuncBASE_output/sqlite_db_dir/genecode.v33_pr.as.an_intron_coordinate.txt" \
	-p 20 --nice

python run_preProcess_by_chr_step1.py \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/juncbase_samp2bam.tsv \
	-o /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	--check

####################################################################################################
### STEP 1b: Desambiguate splice juntion orientations
####################################################################################################

# After removing all non-standard chromosomes subfolders
cd /JuncBASE/
python disambiguate_junctions.py \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	-g /private/groups/brookslab/reference_sequence/GRCh38.u2af1_fix.v1.2020_04_01.fa \
	--by_chr --majority_rules

####################################################################################################
### STEP 2: Identify all junctions
####################################################################################################

python preProcess_getASEventReadCounts_by_chr_step2.py \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	--by_chr

####################################################################################################
### STEP 3: Create exon-intron junction count files
####################################################################################################

python run_preProcess_step3_by_chr.py \
	--input_dir /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	--LSF --lsf_queue --min_overhang 6 \
	--num_processes 8 --force --nice

####################################################################################################
### STEP 4: Create a pseudo/"all junction" sample
####################################################################################################

python createPseudoSample.py \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	-s mut2_krasG12V_rep1 --by_chr

####################################################################################################
### STEP 5: Run build_DB_FromGTF.py twice with/without --initialize
####################################################################################################

python run_getASEventReadCounts_multiSample.py \
	-s mut2_krasG12V_rep1,mut2_krasG12V_rep2,mut2_krasG12V_rep3,mut2_krasWT_rep1,mut2_krasWT_rep2,mut2_krasWT_rep3,mut2_lacz_rep1,mut2lacz_rep2,mut2_lacz_rep3,wt2_krasG12V_rep1,wt2_krasG12V_rep2,wt2_krasG12V_rep3,wt2_krasWT_rep1,wt2_krasWT_rep2,wt2_krasWT_rep3,wt2_lacz_rep1,wt2_lacz_rep2,wt2_lacz_rep3 \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	-o /scratch/carevalo/getASEventReadCounts/update/ \
	--sqlite_db_dir /private/groups/brookslab/U2AF1-KRAS-RNA-seq/Analysis_v1_Amit/JuncBASE_output/sqlite_db_dir \
	--txt_db1 genecode.v33_pr.as.an_db1 \
	--txt_db2 genecode.v33_basic.ann_db1 \
	--txt_db3 genecode.v33_pr.as.an_db1 \
	--jcn_seq_len 240 -p 20 --by_chr

python run_getASEventReadCounts_multiSample.py \
	-s mut2_krasG12V_rep1,mut2_krasG12V_rep2,mut2_krasG12V_rep3,mut2_krasWT_rep1,mut2_krasWT_rep2,mut2_krasWT_rep3,mut2_lacz_rep1,mut2lacz_rep2,mut2_lacz_rep3,wt2_krasG12V_rep1,wt2_krasG12V_rep2,wt2_krasG12V_rep3,wt2_krasWT_rep1,wt2_krasWT_rep2,wt2_krasWT_rep3,wt2_lacz_rep1,wt2_lacz_rep2,wt2_lacz_rep3 \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update \
	-o /scratch/carevalo/getASEventReadCounts/update/ \
	--sqlite_db_dir /private/groups/brookslab/U2AF1-KRAS-RNA-seq/Analysis_v1_Amit/JuncBASE_output/sqlite_db_dir \
	--txt_db1 genecode.v33_pr.as.an_db1 \
	--txt_db2 genecode.v33_basic.ann_db1 \
	--txt_db3 genecode.v33_pr.as.an_db1 \
	--jcn_seq_len 240 -p 20 --by_chr --check


####################################################################################################
### STEP 6-Part 1
####################################################################################################

python run_createAS_CountTables.py \
	-d /scratch/carevalo/getASEventReadCounts/update/ \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update/ \
	--jcn_seq_len 240 \
	-s mut2_krasG12V_rep1,mut2_krasG12V_rep2,mut2_krasG12V_rep3,mut2_krasWT_rep1,mut2_krasWT_rep2,mut2_krasWT_rep3,mut2_lacz_rep1,mut2lacz_rep2,mut2_lacz_rep3,wt2_krasG12V_rep1,wt2_krasG12V_rep2,wt2_krasG12V_rep3,wt2_krasWT_rep1,wt2_krasWT_rep2,wt2_krasWT_rep3,wt2_lacz_rep1,wt2_lacz_rep2,wt2_lacz_rep3 \
	--num_processes 30

python run_createAS_CountTables.py \
	-d /scratch/carevalo/getASEventReadCounts/update/ \
	-i /scratch/carevalo/U2AF1_juncbase_trimmed_bams/update/ \
	--jcn_seq_len 240 \
	-s mut2_krasG12V_rep1,mut2_krasG12V_rep2,mut2_krasG12V_rep3,mut2_krasWT_rep1,mut2_krasWT_rep2,mut2_krasWT_rep3,mut2_lacz_rep1,mut2lacz_rep2,mut2_lacz_rep3,wt2_krasG12V_rep1,wt2_krasG12V_rep2,wt2_krasG12V_rep3,wt2_krasWT_rep1,wt2_krasWT_rep2,wt2_krasWT_rep3,wt2_lacz_rep1,wt2_lacz_rep2,wt2_lacz_rep3 \
	--num_processes 30 --check

####################################################################################################
### STEP 6-Part 2
####################################################################################################

python combine_createAS_CountTables_by_chr.py \
	-d /scratch/carevalo/getASEventReadCounts/update/ \
	-o /scratch/carevalo/juncbase_tables/jb_table2/



