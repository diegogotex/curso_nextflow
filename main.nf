#!/usr/bin/env nextflow

/*
params.greeting = 'hello world!'
greeting_ch = Channel.of(params.greeting)

process SPLITLETTERS {
    input:
    val x

    output:
    path 'chunk_*'

    """
    printf '$x' | split -b 3 - chunk_
    """
}

process CONVERTTOUPPER {
    input:
    path y

    output:
    stdout

    """
    cat $y | tr '[a-z]' '[A-Z]' 
    """
}

workflow {
    letters_ch = SPLITLETTERS(greeting_ch)
    //results_ch = CONVERTTOUPPER(letters_ch.flatten())
    results_ch = CONVERTTOUPPER(letters_ch)
    results_ch.view{ it }
}
*/


/*
 * parametros de input do pipeline
 */

params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"

//configurano o log a ser printado durante a execução
log.info
"""\
R N A S E Q - N F  P I P E L I N E
==================================
transcriptome: ${params.transcriptome_file}
reads: ${params.reads}
outdir: ${params.outdir}
"""
.stripIdent()

/*
*   criando o index binario do salmon
*   a partir de um transcriptoma de referencia
*/

process INDEX {
    input:
    path transcriptome

    output:
    path 'salmon_index'

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i salmon_index
    """
}

workflow {
    index_ch = INDEX(params.transcriptome_file)
}