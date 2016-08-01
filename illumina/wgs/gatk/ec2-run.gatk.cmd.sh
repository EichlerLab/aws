family=$1

echo "$family" > FAMILY
aws s3 sync s3://simonsphase3/software/bitbucket/ .
cd genus/aws/gatk_multi/
aws s3 cp s3://simonsphase3/testing/dbsnp_138.b37.vcf.gz .
aws s3 cp s3://simonsphase3/testing/dbsnp_138.b37.vcf.gz.tbi .

cd ~/
mkdir bam
mkdir family_bam/

cd bam
aws s3 ls --recursive s3://sscwgs > bucket_contents

grep "$family"/ bucket_contents | grep 'bam' | grep -v 'md5' | awk '{FS=" "; print "aws s3 cp s3://sscwgs/"$4" ."}' > download.sh
grep "$family"/ bucket_contents | grep 'bai' | grep -v 'md5' | awk '{FS=" "; print "aws s3 cp s3://sscwgs/"$4" ."}' >> download.sh

split -l1 download.sh
for i in x*; do nohup sh "$i" & done

sleep 7200
cd ../family_bam/

awk '{FS="\t"; print "ln -s ../bam/"$2".final.bam "$1".final.bam"}' ../genus/manifests/aws_bucket_stats/sample_file/540families_idmapping | sh
awk '{FS="\t"; print "ln -s ../bam/"$2".final.bai "$1".final.bai"}' ../genus/manifests/aws_bucket_stats/sample_file/540families_idmapping | sh

find -L . -name . -o -type d -prune -o -type l -exec rm {} +

cd ../genus/aws/gatk_multi/
sed -i 's:/mnt/family_bam:/home/ec2-user/family_bam:g' config_gatk.json

snakemake -s master.snake -k -w 30 --rerun-incomplete 

echo 'ALL DONE NOW!'

