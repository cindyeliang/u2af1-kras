#This script and analysis was written and performed by Selam Mehreteab (smehrete@ucsc.edu)

##########################################################################################################################################JuncBASE comand
#######################################################################################################################################

python /JuncBASE/run_preProcess_by_chr_step1.py \
	-i /20241227_U2AF1_Juncbase/u2af1kras_samp2bam_docker.txt \ 
	-o /20241227_U2AF1_Juncbase/samples_folder \
	--preProcess_options "--unique -j /20241227_U2AF1_Juncbase/gencode.v33.primary_assembly.annotation.txt" \
	-p 20

#The following lines are necessary becasue even though we removed the reads from the bam files these chromosomes that we do't care about were presnt in the bam header(in the future come up witha more efficient way to do this rather than doing it one by one)
find /20241227_U2AF1_Juncbase/samples_folder -name "*_chrGL*" -exec rm -r {} \;
find /20241227_U2AF1_Juncbase/samples_folder -name "*_chrKI*" -exec rm -r {} \;
find /20241227_U2AF1_Juncbase/samples_folder -name "*_chrM*" -exec rm -r {} \;
find /20241227_U2AF1_Juncbase/samples_folder -name "*_chrUn*" -exec rm -r {} \;
find /20241227_U2AF1_Juncbase/samples_folder -name "*chrHLA*" -exec rm -r {} \;
find /20241227_U2AF1_Juncbase/samples_folder -name "*_chrEBV*" -exec rm -r {} \;
#there are more chromosomes that we want to filter out (only keep chr 1, 2, 3, 4, 5,6, 7, 8, 9, 10 - 22 and chr X and Y)


#######################################################################################################################################
###Step 1b: Disambiguate splice juntion orientations
#######################################################################################################################################
python /JuncBASE/disambiguate_junctions.py \ 
	-i /20241227_U2AF1_Juncbase/samples_folder \
	-g /20241227_U2AF1_Juncbase/GRCh38.u2af1_fix.v1.2020_04_01.fa \
       	--by_chr --majority_rules 

####################################################################################################
### STEP 2: Identify all junctions
####################################################################################################
python /JuncBASE/preProcess_getASEventReadCounts_by_chr_step2.py \
	-i /20241227_U2AF1_Juncbase/samples_folder \
	--by_chr 

####################################################################################################
### STEP 3: Create exon-intron junction count files
####################################################################################################
python /JuncBASE/run_preProcess_step3_by_chr.py \ 
	--input_dir /20241227_U2AF1_Juncbase/samples_folder \
	--min_overhang 6 \
	--num_processes 20 --force


####################################################################################################
### STEP 4: Create a pseudo/"all junction" sample
####################################################################################################
python /JuncBASE/createPseudoSample.py \
	-i /20241227_U2AF1_Juncbase/samples_folder \
	-s wt_lacz_clone1_r1 --by_chr 

####################################################################################################
### STEP 5: getASEventReadCOunts_multiSample.py
####################################################################################################
python /JuncBASE/run_getASEventReadCounts_multiSample.py \
	-s /20241227_U2AF1_Juncbase/samplemanifest.txt \
	-i /20241227_U2AF1_Juncbase/samples_folder \
	-o /20241227_U2AF1_Juncbase/getASEventReadCount 
	--sqlite_db_dir /20241227_U2AF1_Juncbase/ \ 
	--txt_db1 gencode.v33 \
	--txt_db2 gencode.v33.basic \ 
	--jcn_seq_len 290 -p 20 --by_chr --force

####################################################################################################
### STEP 6-Part 1
####################################################################################################

python /JuncBASE/run_createAS_CountTables.py \
	-d /20241227_U2AF1_Juncbase/getASEventReadCount/ \
	-i /20241227_U2AF1_Juncbase/samples_folder/ \
	--jcn_seq_len 290 \
	-s wt_lacz_clone1_r1,wt_lacz_clone1_r2,wt_lacz_clone1_r3,wt_lacz_clone2_r1,wt_lacz_clone2_r2,wt_lacz_clone2_r3,wt_kv12_clone1_r1,wt_kv12_clone1_r2,wt_kv12_clone1_r3,wt_kv12_clone2_r1,wt_kv12_clone2_r2,wt_kv12_clone2_r3,s34f_lacz_clone1_r1,s34f_lacz_clone1_r2,s34f_lacz_clone1_r3,s34f_lacz_clone2_r1,s34f_lacz_clone2_r2,s34f_lacz_clone2_r3,s34f_kv12_clone1_r1,s34f_kv12_clone1_r2,s34f_kv12_clone1_r3,s34f_kv12_clone2_r1,s34f_kv12_clone2_r2,s34f_kv12_clone2_r3,wt_kraswt_clone2_r1,wt_kraswt_clone2_r2,wt_kraswt_clone2_r3,s34f_kraswt_clone2_r1,s34f_kraswt_clone2_r2,s34f_kraswt_clone2_r3 \
	--num_processes 20 

####################################################################################################
### STEP 6-Part 2
####################################################################################################
python /JuncBASE/combine_createAS_CountTables_by_chr.py \
	-d /20241227_U2AF1_Juncbase/getASEventReadCount/ \
	-o /20241227_U2AF1_Juncbase/JuncBaseEventReadCounts_020425


