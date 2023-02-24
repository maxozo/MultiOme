process CELLRANGER_ARC {
    tag "${samplename}"
    label 'process_medium'
    publishDir "${params.outdir}/count/${sample}", mode: "${params.copy_mode}", overwrite: true
    if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
        container "/software/hgi/containers/multiome_24_02_2023.img"
    } else {
        container "/software/hgi/containers/multiome_24_02_2023.img"
    }
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
           ${params.cellranger_arc_path}/cellranger-arc count \
                --id=Sample1 \
                --libraries=${libcsv} \
                --reference=${params.genome} \
                --localmem=${mem} \
                --jobmode=local \
                --localcores=${task.cpus} \
                --peaks /lustre/scratch123/hgi/projects/huvec/scripts/run/required_files/test_peaks.bed
      """
}




process PREPERE_ARC_FILE {
    label 'process_low'   
    if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
        container "/software/hgi/containers/multiome_24_02_2023.img"
    } else {
        container "/software/hgi/containers/multiome_24_02_2023.img"
    }
    input: 
      path(libcsv)
    output:
        path('arc_input.csv'), emit:arc_input
    script:
        """
           prepere_arc_file.py --input_file ${libcsv}
        """

}