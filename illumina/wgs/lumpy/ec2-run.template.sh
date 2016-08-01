#!/bin/bash
cd /home/ec2-user

su - ec2-user -c "aws s3 cp s3://simonsphase3/lumpy/ec2-run.lumpy.cmd.sh ."
chmod a+x ec2-run.lumpy.cmd.sh
su - ec2-user -s /bin/bash -c "./ec2-run.lumpy.cmd.sh {family}"

shutdown -P now
