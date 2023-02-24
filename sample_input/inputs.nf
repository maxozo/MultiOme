params {

  // Project ID (2021_XXX) or Run ID (date: e.g. YYMMDD-sc-arc-10x)
	metaid="nf_dir"
	cellranger_arc_path = '/lustre/scratch123/hgi/projects/huvec/scripts/run/required_files/cellranger-arc-2.0.2' //Due to the licensing issues every user shall retrieve their own software from 10x
	// therefore cellranger-arc is not provided in the container. Please point your software to here as in:
	// cellranger_arc_path = ''
	// Similarly for genome, please retrieve this from 10x. 
	genome = '/lustre/scratch123/hgi/projects/huvec/scripts/run/required_files/refdata-cellranger-arc-mm10-2020-A-2.0.0'
	
	// Sample Sheet (Must be in the specified runfolder!)
	inputsheet = "/lustre/scratch123/hgi/projects/huvec/scripts/run/nf_libraries.csv"

	// aggregate function from cellranger-arc, y=yes, n=no (assuming no)
	run_aggregate="n"


	// Base dirs:
	// outdir="/suffolk/WorkGenomicsH/mn367/Projects/MBU_groupleader/MBU_groupid_projId/${metaid}/"
	// basedir="/suffolk/WorkGenomicsH/mn367/Projects/MBU_groupleader/MBU_groupid_projId/${metaid}/"

	// create count matrix for the samples processed (y=yes, n=no)
	count_matrix="y"

	// run mgatk
	mgatk_run="y"


	// software params
	tool_qualimap="/usr/mbu/software/qualimap/qualimap-2.2.1/qualimap"
	tool_cellranger_arc="/suffolk/WorkGenomicsE/mn367/tools/cellranger-arc-2.0.1/cellranger-arc"
	tool_fastq_screen="/suffolk/WorkGenomicsE/mn367/tools/FastQ-Screen-0.14.1/fastq_screen"
	tool_fastqc="/usr/mbu/software/anaconda3/bin/fastqc"
	tool_bwa="/usr/mbu/software/anaconda3/bin/bwa"
	tool_multiqc="/usr/mbu/software/anaconda3/envs/multiqc/bin/multiqc"
	//tool_mgatk="/home/cl873/miniconda3/envs/mgatk/bin/mgatk"
	tool_mgatk="/home/mn367/.conda/envs/env_nf/bin/mgatk"


	// if using other genome reference than hg38 or mm10
	custom_genome = "xxxpathtogenomexxx"

	/*
	   =================
	   AUTOMATIC PARAMS
	   =================
	*/

	// sheet="${basedir}/${ssheet}"
	// fqdir="${outdir}fastq/"
	// qcdir="${outdir}qc/"
	// countdir="${outdir}count/"
	// aggdir="${outdir}aggregate/"
	// metadir="${basedir}/metadata"
	// mgatkdir="${basedir}/mgatk"

}