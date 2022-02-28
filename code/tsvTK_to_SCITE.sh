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
#1. processed_${prefix_timeID}.tsv (TSV file)
#2. MutationList: mutList_${prefix_timeID}.tsv
#3. SampleNameList: sampleList_${prefix_timeID}.tsv
#4. NxM (tsv): "NxM_"${prefix_timeID}

tsv_process_mtx_toSCITE.py ${target_tsv} ${prefix_timeID}

N=$(cat NxM_${prefix_timeID} | cut -f 1)
M=$(cat NxM_${prefix_timeID} | cut -f 2)


CMD_main="scite -i processed_${prefix_timeID}.tsv -n ${N} -m ${M} -r 1 -l 900000 -fd 6.04e-5 -ad 0.21545 0.21545 -cc 1.299164e-05 1> scite_stdout 2> scite_stderr"
#CMD_rem_tempfile="rm processed_${prefix_timeID}.tsv"

${CMD_main}
#BsubM "${CMD_main}" SCITE_RUN
#BsubM "${CMD_main} && ${CMD_rem_tempfile}" SCITE_RUN

cd ..
