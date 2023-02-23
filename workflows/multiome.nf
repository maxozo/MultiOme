include {CELLRANGER_ARC;PREPERE_ARC_FILE} from "$projectDir/modules/nf-core/modules/cellranger_arc/main"


workflow MULTIOME {
    log.info "Running Multiome processing"

    // extract RNA samplesheet info
    Channel
        .fromPath(params.inputsheet)
        .splitCsv(header:true)
        .map { row -> tuple( row.sample, row.fastqs, row.library_type,row.spiecies,row.sample_pair ) }
        .tap{infoall}
        .set { count_lib_csv }
    // .into { crlib_ch; cragg_ch; fqc_ch; fqs_ch }
    PREPERE_ARC_FILE(params.inputsheet)
    CELLRANGER_ARC(PREPERE_ARC_FILE.out.arc_input)
    // count_lib_csv.view()
}