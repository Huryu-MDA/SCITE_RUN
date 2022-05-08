#!/usr/bin/env python
# coding: utf-8

import sys, os
import numpy as np
import pandas as pd


target_tsv = sys.argv[1]
#target_tsv = "test_data.tsv"

prefix_timeID = sys.argv[2]
#prefix_timeID = "test_data"

output_tsv = "processed_" + prefix_timeID + ".tsv"
output_VariantList = "mutList_" + prefix_timeID + ".tsv"
output_sampleList = "sampleList_" + prefix_timeID + ".tsv"
output_NxM = "NxM_" + prefix_timeID
PutativeGeneList = "processed_" + prefix_timeID + ".geneNames"


# genotype set
GT_set = {0, 1, 2, 3}

df = pd.read_csv(target_tsv,sep ="\t")

#Var_annot = ["Chr", "Start", "End", "Ref", "Alt", 
Var_annot = ["chr", "start", "ref", "alt", 
             "Func.knownGene", "Gene.knownGene", "GeneDetail.knownGene", "ExonicFunc.knownGene"]
df_var = df[Var_annot].copy()

cell_list = [col for col in df.columns if (col != "KT") and (set(df[col]) <= GT_set)]

sample_num = len(cell_list)
var_num = len(df)

df_samples = df[cell_list].copy()
df_samples.to_csv(output_tsv, sep ="\t", header = False, index = False)

for cell_name in cell_list:
    print(cell_name, file=open(output_sampleList, "a"))
    
df_var.to_csv(output_VariantList, sep = "\t", index = False, header = False)
df_var["Gene.knownGene"].to_csv(PutativeGeneList, sep = "\t", index = False, header = False)
print(str(var_num) + "\t" + str(sample_num), file=open(output_NxM, "w"))
