#!/bin/python

import boto3
client=boto3.client('s3','us-east-1')
from boto3.s3.transfer import S3Transfer
from boto3.s3.transfer import TransferConfig
from boto3 import utils


config = TransferConfig(
    multipart_threshold=50 * 1024 * 1024,
    multipart_chunksize=50 * 1024 * 1024,
    max_concurrency=10,
    num_download_attempts=10,
)


transfer=S3Transfer(client, config)
transfer.download_file('sscwgs','11194/Sample_SSC00668/VCF/mtDNA/SSC00668.mtDNAcn.txt','SSC00668.mtDNAcn.txt',extra_args={'RequestPayer':'requester'})


