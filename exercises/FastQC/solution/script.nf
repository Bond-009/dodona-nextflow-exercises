#!/usr/bin/env nextflow

params.reads = "${launchDir}/*.fq.gz"

/**
 * Quality control fastq
 */

process fastqc {
    publishDir "${launchDir}", mode: 'copy'

    input:
    path read

    output:
    path "*.html"
    path "*.zip"

    script:
    """
    fastqc ${read}
    """
}

workflow {
    def reads_ch = Channel
        .fromPath(params.reads)
        .view()
    fastqc(reads_ch)
}
