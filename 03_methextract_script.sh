#!/bin/bash

# Define the input directory and output directory
RefGenome=~/ncbi_dataset/data/GCF_023065955.2
input_dir=~/aligned
output_dir=~/meth_extract
RefGenome=~/ncbi_dataset/data/GCF_023065955.2

# Check if input directory exists
if [ ! -d "$input_dir" ]; then
    echo "Input directory does not exist: $input_dir"
    exit 1
fi

# Check if output directory exists; if not, create it
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi


# Change to the input directory
cd "$input_dir"

# Loop through each forward read file in the input directory
for forward_read in *_R1_001_val_1_bismark_bt2_pe.bam; do
    # Get the base filename without the _R1.fastq extension
    base=$(basename "$forward_read" _R1_001_val_1_bismark_bt2_pe.bam)

    echo "$base"
    echo "$forward_read"

    # Run bismark_methylation_extractor on the forward and reverse reads
    bismark_methylation_extractor --parallel 10 --comprehensive --ignore_r2 2 --bedGraph --CX --cytosine_report --buffer_size 20G --multicore 20 --genome_folder "$RefGenome" -o "$output_dir" "$forward_read"
done
