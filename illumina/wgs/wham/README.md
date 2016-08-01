To run the pipeline in this directory use:
sh do_run.sh <familyName>

For example:
sh do_run.sh 11006
would run old WHAM-GRAPHENING on family 11006

Note that right now the Snakefile outputs the data to a file as such:
s3://simonsphase3/results/wham/round2/{familyname}.wham.vcf

