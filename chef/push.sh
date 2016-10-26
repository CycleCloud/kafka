#!/bin/bash

LOCKER=$1
if [ "$LOCKER" == "" ]; then
  echo "ERROR: Locker URL required (format: s3://bucket/prefix/)" >&2
  exit -1
fi
LOCKER=${LOCKER%/}/chef

VERSION=$2
if [ "$VERSION" == "" ]; then
  VERSION="kafka"
fi

CONFIG=$3



if which pogo; then
    echo "Using pogo..."
    if [ "$CONFIG" != "" ]; then
        CONFIG="--config=${CONFIG}"
    fi
    S3_CP_CMD="pogo ${CONFIG} put --force"
elif which aws; then
    echo "Using aws-cli..."
    if [ "$CONFIG" != "" ]; then
        CONFIG="--profile=${CONFIG}"
    fi
    S3_CP_CMD="aws ${CONFIG} s3 cp"
elif which aws; then
    echo "Using s3cmd..."
    if [ "$CONFIG" != "" ]; then
        CONFIG="-c ${CONFIG}"
    fi
    S3_CP_CMD="s3cmd ${CONFIG} put"
else
    echo "No S3 transfer tool found!"
    exit -1
fi

# Copies the cookbooks and roles to S3. Note: this overwrites latest so you may be fighting with someone else running this at the same time!
for REPO in site-cookbooks roles data_bags; do
    if [ -e  $REPO ]; then
        tar -czf ${REPO}.tgz ${REPO}
        ${S3_CP_CMD} ${REPO}.tgz ${LOCKER}/${VERSION}/${REPO}.tgz
        rm ${REPO}.tgz
    fi
done


