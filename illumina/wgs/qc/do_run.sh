#!/bin/bash
FAMILIES="$1"
for fam in $FAMILIES; do
    mkdir -p $fam
	pushd $fam
	cp ../ec2-run.template.sh ec2-run.$fam.sh
	sed -i "s/{family}/$fam/g" ec2-run.$fam.sh
	aws ec2 run-instances --image-id ami-a7d91eca --user-data file://ec2-run.$fam.sh --key-name eichlerlab_cfncluster --security-group-ids sg-95acacf3 --instance-type m4.2xlarge --placement AvailabilityZone=us-east-1c --subnet-id subnet-42ed2234 --ebs-optimized --associate-public-ip-address --block-device-mappings "DeviceName=/dev/xvda,Ebs={VolumeSize=1000,VolumeType=gp2}" --instance-initiated-shutdown-behavior terminate > ec2_instance.json
	popd
done
