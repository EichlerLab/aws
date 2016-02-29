#!/bin/python
# Usage : python pull_files.py --s3_bucket <s3_bucket> --sample_file <sample_file>
# Example : python pull_files.py --s3_bucket simonsphase3 --sample_file testing/13833/Sample_SSCtest/analysis/13833.fa.final.sort.bam.bai

import boto3
import os
import argparse

client=boto3.client('s3','us-east-1')
from boto3.s3.transfer import S3Transfer
from boto3.s3.transfer import TransferConfig
from boto3 import utils

def copy_from_requester_pay_bucket(s3_bucket=None,sample_file=None):
    config = TransferConfig(
    multipart_threshold=25 * 1024 * 1024,\
        multipart_chunksize=25 * 1024 * 1024,\
        max_concurrency=10,num_download_attempts=10,)
    transfer=S3Transfer(client, config)
    sample_file=sample_file
    dirname=os.path.dirname(sample_file)
    # Create the directory structure only if it doesn't exist
    if not os.path.exists(dirname):
    	os.makedirs(dirname)
    #if not os.path.exists(dirname):
    #	try:
    #		os.makedirs(dirname)
    #	except:
    #		raise OSError("Can't create destination directory (%s)!" % (dirname))
    #		pass
    transfer.download_file(s3_bucket,sample_file,sample_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--s3_bucket",action="store" , required=True,help="Specify an s3 bucket name from which you want to download files")
    parser.add_argument("--sample_file", action="store", required=True,help="Specify the complete path of the sample file you want to download")
    args = parser.parse_args()

    copy_from_requester_pay_bucket(args.s3_bucket,args.sample_file)
