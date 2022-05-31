rule flye:
    input: "reads-np.fq"
    output: "flye/assembly.fasta"
    threads: 12
    params: config["flye"]
    shell: "flye -t {threads} {params} --nano-hq {input} -o flye"

rule flye_post:
    input: "flye/assembly.fasta"
    output: "flye/{run}.fna"
    shell: "flye-post --min-length 2000 --id-pattern '%s_%03d' flye flye/{run}"
