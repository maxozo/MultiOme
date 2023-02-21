
process sayHello {
    tag "${study_id}"
    publishDir "${params.outdir}/samples", mode: 'copy', pattern: "*_file.txt", overwrite: true
    
    input:
        val study_id
    output:
        tuple val(study_id), file('*_file.txt'), emit: samples_tsv
    when:

    script:
    """
    echo 'Hello world! ${study_id}' > ${study_id}_file.txt
    python $workflow.projectDir/bin/test_mo519.py
    """
}


workflow test_mo519 {
    log.info "running"
    ch = Channel.of( 1, 3, 5, 7 )
    ch.view { "value: $it" }

    sayHello(ch)

}