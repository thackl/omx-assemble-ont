FASTQ, = glob_wildcards('reads-np/{fastq}.fastq.gz')
FASTQ.sort()

rule filt_ont:
    input: "reads-np/{fastq}.fastq.gz"
    output: temp("reads-tmp/{fastq}.fq")
    params:
        min_length=config["prep_np"]["min_length"]
    shell: "seqkit seq -m {params.min_length} {input} > {output}"

rule prep_ont:
    output: "{run}-np.fq"
    input: expand("reads-tmp/{fastq}.fq", fastq=FASTQ)
    shell: "cat {input} > {output}"
