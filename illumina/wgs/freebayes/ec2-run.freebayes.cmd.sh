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

cd ../genus/aws/freebayes_auto/
wget https://sourceforge.net/projects/vcftools/files/vcftools_0.1.13.tar.gz/download
tar xvzf download

cd vcftools_0.1.13
make
export PERL5LIB='/home/ec2-user/genus/aws/freebayes_auto/vcftools_0.1.13/perl/'
cd ../

sed -i 's:/mnt/family_bam:/home/ec2-user/family_bam:g' config_fb.json
source activate python
snakemake -s master.snake -k -w 30 --rerun-incomplete

echo 'ALL DONE NOW!'

