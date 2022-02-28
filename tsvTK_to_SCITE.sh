#!/bin/bash

# $1: target_tsv

target_tsv=$1
tsv_basename=$(basename ${target_tsv})
timeID=$(timeID)
prefix=$(echo ${tsv_basename} | cut -f 1- d ".")

prefix_timeID=${timeID}"_"${prefix}

echo "TSV file name: "${tsv_basename}
echo "prefix_timeID: "${prefix_timeID}
echo ""

mkdir -p ${prefix_timeID}
cp ${target_tsv} ${prefix_timeID}/.
cd ${prefix_timeID}

module -q load python

#   This will return 
#1. processed_nColNum_-mSampleNum_${prefix_timeID}_XXXXX.tsv (TSV file)
#2. MutationList: mutList_${prefix_timeID}_XXXXX.tsv
#3. SampleNameList: sampleList_${prefix_timeID}_XXXXX.tsv

tsv_process_mtx_toSCITE.py ${target_tsv} ${prefix}






cd ..
