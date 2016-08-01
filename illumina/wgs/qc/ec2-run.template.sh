#!/bin/bash
cd /home/ec2-user

su - ec2-user -c "aws s3 cp s3://simonsphase3/qc_auto/ec2-run.qc.cmd.sh ."
chmod a+x ec2-run.qc.cmd.sh
su - ec2-user -s /bin/bash -c "./ec2-run.qc.cmd.sh {family}"

shutdown -P now
