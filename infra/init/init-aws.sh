#!/bin/sh
# Run once at startup, against Floci (secțiunea 9.1).
# TODO:
#   1. aws s3 mb s3://$S3_BUCKET
#   2. aws lambda create-function scan-processor (container image essenza/scan-processor)
#   3. aws s3api put-bucket-notification-configuration (ObjectCreated on uploads/ -> scan-processor)
set -e
export AWS_PAGER=""
echo "init-aws: TODO"
