process CELLRANGER_ARC {
    tag "${samplename}"
    label 'process_medium'
    publishDir "${params.outdir}/count/${sample}", mode: "${params.copy_mode}", overwrite: true

    // if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
    //     container "/software/hgi/containers/mercury_scrna_deconvolution_62bd56a-2021-12-15-4d1ec9312485.sif"
    //     //// container "/software/hgi/containers/mercury_scrna_deconvolution_latest.img"
    // } else {
    //     container "mercury/scrna_deconvolution:62bd56a"
    // }
    input: 
      path(libcsv)
    script:
        mem="${task.memory}".replaceAll(' GB','')
        """
            /lustre/scratch123/hgi/projects/huvec/scripts/run/required_files/cellranger-arc-2.0.2/cellranger-arc count \
                --id=Sample1 \
                --libraries=${libcsv} \
                --reference=/lustre/scratch123/hgi/projects/huvec/scripts/run/required_files/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
                --localmem=${mem} \
                --jobmode=local \
                --localcores=${task.cpus} \
               
      """
}




process PREPERE_ARC_FILE {
    label 'process_low'   

    input: 
      path(libcsv)
    output:
        path('arc_input.csv'), emit:arc_input
    script:
        """
           prepere_arc_file.py --input_file ${libcsv}
        """

}