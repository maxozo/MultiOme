process CELLRANGER_ARC {
    tag "${samplename}"
    label 'process_medium'
    publishDir "${params.outdir}/cellranger_arc", mode: "${params.copy_mode}", overwrite: true
    if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
        container "/software/hgi/containers/multiome_24_02_2023.img"
    } else {
        container "/software/hgi/containers/multiome_24_02_2023.img"
    }
    output:
        tuple val(sample), path("${sample}__Cellranger"), emit:arc_outputs


    input: 
      path(libcsv)
    script:
        mem="${task.memory}".replaceAll(' GB','')
        sample = "${libcsv}".split("___")[0]
        if ("${sample}"=="Sample2"){
            peaks = " --peaks /lustre/scratch123/hgi/projects/huvec/scripts/run/required_files/test_peaks.bed"
        }else{
            peaks = "" 
        }
        peaks = " --peaks /lustre/scratch123/hgi/projects/huvec/scripts/run/required_files/test_peaks.bed"
        
        """
           ${params.cellranger_arc_path}/cellranger-arc count \
                --id=${sample} \
                --libraries=${libcsv} \
                --reference=${params.genome} \
                --localmem=${mem} \
                --jobmode=local \
                --localcores=${task.cpus} \
               ${peaks}

           mkdir ${sample}__cellranger
           ln -s ${sample}/outs ${sample}__Cellranger

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
        path('*___arc_input.csv'), emit:arc_input
    script:
        """
           prepere_arc_file.py --input_file ${libcsv}
        """

}