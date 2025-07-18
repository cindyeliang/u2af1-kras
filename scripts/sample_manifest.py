
#define the output file paths
output_mapping = '/20241227_U2AF1_Juncbase/u2af1kras_samp2bam_docker.txt'
output_manifest = '/20241227_U2AF1_Juncbase/samplemanifest.txt'

# Define the samples and their corresponding file paths
samples = {
            "wt_lacz_clone1_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1WTL_1.filtered.bam",
                "wt_lacz_clone1_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1WTL_2.filtered.bam",
                    "wt_lacz_clone1_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1WTL_3.filtered.bam",
                        "s34f_lacz_clone1_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1MLA_1.filtered.bam",
                            "s34f_lacz_clone1_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1MLA_2.filtered.bam",
                                "s34f_lacz_clone1_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1MLA_3.filtered.bam",
                                    "wt_kv12_clone1_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1WTK_1.filtered.bam",
                                        "wt_kv12_clone1_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1WTK_2.filtered.bam",
                                            "wt_kv12_clone1_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1WTK_3.filtered.bam",
                                                "s34f_kv12_clone1_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1MKV_1.filtered.bam",
                                                    "s34f_kv12_clone1_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1MKV_2.filtered.bam",
                                                        "s34f_kv12_clone1_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-merged_clone1MKV_3.filtered.bam",
                                                            "wt_lacz_clone2_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-A_Aligned.sortedByCoord.out.filtered.bam",
                                                                "wt_lacz_clone2_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-G_Aligned.sortedByCoord.out.filtered.bam",
                                                                    "wt_lacz_clone2_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-M_Aligned.sortedByCoord.out.filtered.bam",
                                                                        "s34f_lacz_clone2_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-B_Aligned.sortedByCoord.out.filtered.bam",
                                                                            "s34f_lacz_clone2_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-H_Aligned.sortedByCoord.out.filtered.bam",
                                                                                "s34f_lacz_clone2_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-N_Aligned.sortedByCoord.out.filtered.bam",
                                                                                    "wt_kv12_clone2_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-E_Aligned.sortedByCoord.out.filtered.bam",
                                                                                        "wt_kv12_clone2_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-K_Aligned.sortedByCoord.out.filtered.bam",
                                                                                            "wt_kv12_clone2_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-Q_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                "s34f_kv12_clone2_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-F_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                    "s34f_kv12_clone2_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-L_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                        "s34f_kv12_clone2_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-R_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                            "wt_kraswt_clone2_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-C_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                                "wt_kraswt_clone2_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-I_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                                    "wt_kraswt_clone2_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-O_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                                        "s34f_kraswt_clone2_r1": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-D_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                                            "s34f_kraswt_clone2_r2": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-J_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                                                "s34f_kraswt_clone2_r3": "/20241227_U2AF1_Juncbase/filtered_bams/trimmed-P_Aligned.sortedByCoord.out.filtered.bam",
                                                                                                                                }

# Write the mapping and sample manifest
with open(output_mapping, 'w') as out, open(output_manifest, 'w') as out2:
    for sample, path in samples.items():
        out.write(f"{sample}\t{path}\n")
        out2.write(f"{sample}\n")

print("Sample manifest and mapping file created successfully.")

