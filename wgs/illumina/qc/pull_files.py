#!/bin/python

import boto3
import os
import argparse

client=boto3.client('s3','us-east-1')
from boto3.s3.transfer import S3Transfer
from boto3.s3.transfer import TransferConfig
from boto3 import utils

def copy_from_requester_pay_bucket(sample_file=None):
	config = TransferConfig(
	multipart_threshold=25 * 1024 * 1024,\
        multipart_chunksize=25 * 1024 * 1024,\
        max_concurrency=10,num_download_attempts=10,)
	transfer=S3Transfer(client, config)
	sample_file=sample_file
	os.makedirs((os.path.dirname(sample_file)))
	transfer.download_file('sscwgs',sample_file,sample_file,extra_args={'RequestPayer':'requester'})


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--sample_file", action="store", required=True)
    args = parser.parse_args()
    copy_from_requester_pay_bucket(args.sample_file)
