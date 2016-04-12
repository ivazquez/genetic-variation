#!/bin/bash

# RUN filterHD & cloneHD FOR A SIMULATED EXAMPLE DATA SET

# set the number of threads
export OMP_NUM_THREADS=4;

# change this to your population-dynamics directory, or remove if
# you put filterHD and cloneHD into your system-wide path:
CWD=$(git rev-parse --show-toplevel)
BUILD_DIR=${CWD}/build

# input and output directories
data=${CWD}/data/seq/subclonality/simulation
results=${CWD}/data/seq/subclonality/simulation

bulkSNV="${data}/bulk.snv.txt"
mixtureCNA="${data}/mixture.cna.txt"
mixtureSNV="${data}/mixture.snv.txt"
mixtureSNVjumps="${results}/mixture.snv.jumps.txt"
bulkProfile="${results}/bulk.snv.posterior-1.txt"
pre="${results}/mixture"
clones="${data}/clones.txt"
 

echo "*** cloneHD ***"
echo "True mass and cell fractions:" `cat $clones` 
   
cmd="${BUILD_DIR}/cloneHD --cna $mixtureCNA --snv $mixtureSNV --pre $pre --trials 5 --nmax 3 --force --max-tcn 2 --cna-jump 0 --snv-jumps $mixtureSNVjumps --min-jump 0.01 --restarts 10 --mass-gauging 1 --bulk-mean $bulkProfile --cna-pen-norm 0.9" 
echo $cmd
$cmd
echo
cat ${pre}.summary.txt
