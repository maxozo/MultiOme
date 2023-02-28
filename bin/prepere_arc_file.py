#!/usr/bin/env python
import argparse
import pandas as pd

__date__ = '2023-01-20'
__version__ = '0.0.1'

"""Run CLI."""
parser = argparse.ArgumentParser(
    description="""
        Read input
        """
)

parser.add_argument(
    '-v', '--version',
    action='version',
    version='%(prog)s {version}'.format(version=__version__)
)

parser.add_argument(
    '--input_file',
    action='store',
    dest='input_file',
    required=True,
    help='Output directory tag used in nextflow.'
)

# input_file = '/lustre/scratch123/hgi/projects/huvec/scripts/run/work/4e/570d6523beb53f73dbd5e40ca7c7c7/nf_libraries.csv'
options = parser.parse_args()
input_file = options.input_file
Dataset = pd.read_csv(input_file)

# 10x arc dataset should be in the folowing format:
# fastqs,sample,library_type
for unique_sample in set(Dataset['sample']):
    print(unique_sample)
    Dataset2 = Dataset[Dataset['sample']==unique_sample]
    ARC_FILE = Dataset2[['fastqs','sample','library_type']]
    ARC_FILE['library_type'][ARC_FILE['library_type']=='rna']='Gene Expression'
    ARC_FILE['library_type'][ARC_FILE['library_type']=='atac']='Chromatin Accessibility'
    ARC_FILE.to_csv(f'{unique_sample}___arc_input.csv',index=False)
print('Done')
