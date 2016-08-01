#!/bin/bash
cd /home/ec2-user

su - ec2-user -c "aws s3 cp s3://simonsphase3/vh_auto/ec2-run.vh.auto.cmd.sh ."
chmod a+x ec2-run.vh.auto.cmd.sh
su - ec2-user -s /bin/bash -c "./ec2-run.vh.auto.cmd.sh {family}"

shutdown -P now
