# Định nghĩa mẫu
SAMPLE = "sample1"

# Mục tiêu cuối cùng
rule all:
    input:
        "results/fastqc/{sample}_fastqc.html".format(sample=SAMPLE),
        "results/aligned/{sample}.sorted.bam".format(sample=SAMPLE),
        "results/counts_{sample}.txt".format(sample=SAMPLE)

rule fastqc:
    input:
        "data/{sample}.fastq"
    output:
        html="results/fastqc/{sample}_fastqc.html",
        zip="results/fastqc/{sample}_fastqc.zip"
    shell:
        "fastqc {input} -o results/fastqc"

rule bowtie2_index:
    input:
        "reference/TP53.fasta"
    output:
        directory("reference/bowtie2_index")
    shell:
        "mkdir -p {output} && bowtie2-build {input} {output}/TP53"

rule bowtie2_align:
    input:
        fq="data/{sample}.fastq",
        index="reference/bowtie2_index"
    output:
        "results/aligned/{sample}.sam"
    shell:
        "bowtie2 -x {input.index}/TP53 -U {input.fq} -S {output}"

rule samtools_sort:
    input:
        "results/aligned/{sample}.sam"
    output:
        "results/aligned/{sample}.sorted.bam"
    shell:
        "samtools view -bS {input} | samtools sort -o {output} -"

rule featureCounts:
    input:
        bam="results/aligned/{sample}.sorted.bam",
        gtf="reference/TP53.gtf"
    output:
        "results/counts_{sample}.txt"
    shell:
        "featureCounts -F GTF -t exon -a {input.gtf} -o {output} {input.bam}"
