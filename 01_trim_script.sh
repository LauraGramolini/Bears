#!/bin/bash

# Define the input directory and output directory
input_dir=~/rawdata
output_dir=~/trimmed

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
for forward_read in *_R1_001.fastq.gz; do
    # Get the base filename without the _R1.fastq extension
    base=$(basename "$forward_read" _R1_001.fastq.gz)

    # Get the corresponding reverse read file
    reverse_read="${base}_R2_001.fastq.gz"

    # Run trim_galore on the forward and reverse reads
    trim_galore --cores 8 --paired --output_dir "$output_dir" "$forward_read" "$reverse_read"
done
