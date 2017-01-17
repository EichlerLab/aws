family=$1
family=$1
#family='11388'

echo "$family" > FAMILY
#git clone https://tycheleturner@bitbucket.org/tycheleturner/genus.git
aws s3 sync s3://simonsphase3/software/bitbucket/ .

mkdir bam
mkdir family_bam/

cd bam
aws s3 ls --recursive s3://sscwgs > bucket_contents

grep "$family"/BAM bucket_contents | grep 'bam' | grep -v 'md5' | awk '{FS=" "; print "aws s3 cp s3://sscwgs/"$4" ."}' > download.sh
grep "$family"/BAM bucket_contents | grep 'bai' | grep -v 'md5' | awk '{FS=" "; print "aws s3 cp s3://sscwgs/"$4" ."}' >> download.sh

split -l1 download.sh
for i in x*; do nohup sh "$i" & done

sleep 7200
cd ../family_bam/

awk '{FS="\t"; print "ln -s ../bam/"$2".final.bam "$1".final.bam"}' ../genus/manifests/aws_bucket_stats/sample_file/540families_idmapping | sh
awk '{FS="\t"; print "ln -s ../bam/"$2".final.bai "$1".final.bai"}' ../genus/manifests/aws_bucket_stats/sample_file/540families_idmapping | sh

find -L . -name . -o -type d -prune -o -type l -exec rm {} +

cd ~/
mkdir svtyper
cd svtyper
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".fa.gs.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".fa.vh.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".fa.lumpy.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".fa.wham.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".fa.whamg.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".fa.dcgh.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".mo.gs.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".mo.vh.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".mo.lumpy.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".mo.wham.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".mo.whamg.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".mo.dcgh.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".p1.gs.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".p1.vh.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".p1.lumpy.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".p1.wham.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".p1.whamg.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".p1.dcgh.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".s1.gs.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".s1.vh.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".s1.lumpy.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".s1.wham.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".s1.whamg.vcf .
aws s3 cp s3://simonsphase3/svtypervcfs/"$family".s1.dcgh.vcf .

#bring in software
aws s3 cp s3://simonsphase3/software/svtyper.snake .
aws s3 cp s3://simonsphase3/software/svtyper.json .
aws s3 cp s3://simonsphase3/software/svtyperdCGH.snake .
aws s3 cp s3://simonsphase3/software/svtyperdCGH.json .

source activate python
snakemake -s svtyperdCGH.snake -j 4 -k -w 30 --rerun-incomplete
snakemake -s svtyper.snake -j 4 -k -w 30 --rerun-incomplete

aws s3 sync genotyped_vcfs/ s3://simonsphase3/results/svtyper/

echo 'ALL DONE NOW!'


