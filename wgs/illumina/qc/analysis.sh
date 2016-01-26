#!/bin/bash

date
snakemake --snakefile Snakefile get_files_from_s3
date
aws s3 cp s3://simonsphase3/test_bam/SSC00090.final.bam.bai .
cp simonsphase3/test_bam/SSC00090.final.bam.bai simonsphase3/testing/
snakemake --snakefile Snakefile --rerun-incomplete --cluster 'qsub {params.sge_opts}' -j 3 
date




