#!/bin/bash

# Define the input directory and output directory
RefGenome=~/refncbi/ursus_arctos/data/GCF_023065955.2
input_dir=~/trimmed
output_dir=~/aligned

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
cd "$input_dir" || exit 1

# Loop through each forward read file in the input directory
for forward_read in *_R1_001_val_1.fq_trimmed.fq.gz; do
    # Get the base filename without the _R1.fastq extension
    base=$(basename "$forward_read" _R1_001_val_1.fq_trimmed.fq.gz)

    # Get the corresponding reverse read file
    reverse_read="${base}_R2_001_val_2.fq_trimmed.fq.gz"

    echo "$base"
    #echo "$forward_read"
    #echo "$reverse_read"

    # Run bismark on the forward and reverse reads
    bismark -p 40 --output_dir "$output_dir" "$RefGenome" -1 "$forward_read" -2 "$reverse_read"
done
