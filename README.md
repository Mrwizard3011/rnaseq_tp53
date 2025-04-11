# RNA-seq TP53 Analysis Pipeline

This is a Snakemake pipeline for analyzing RNA-seq data targeting the TP53 gene.

The input file is generated to demonstrate the workflow of Snakemae pipeline is run, not a real-world file.

## Prerequisites
- Conda
- Snakemake
- FastQC, Bowtie2, Samtools, Subread (featureCounts)

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Mrwizard3011/rnaseq_tp53.git
   cd rnaseq_tp53
   ```
2. Set up Conda environment:
   ```bash
   conda env create -n rnaseq_env python=3.9
   conda activate rnaseq_env
   conda install -c bioconda snakemake fastqc bowtie2 samtools subread
   ```

## Usage
Run the pipeline:
```bash
snakemake -c1
```

## Input
   -Sample FASTQ file (20 reads, 5% mapped to TP53)
   -TP53 reference sequence
   -TP53 annotation

## Output
   -FastQC reports
   -Aligned BAM files
   -Read counts on TP53
