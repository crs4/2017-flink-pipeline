#!/bin/bash

set -o nounset
set -o errexit

TmpDir=/tmp

function usage_error() {
  echo "Usage: $(basename ${0}) <REF> <SAM> <CRAM>"
  exit 1
}

if [ $# -ne 3 ]; then
  usage_error
fi

Reference="${1}"
Input="${2}"
Output="${3}"

echo "Converting SAM data in ${Input} to CRAM in ${Output}"
echo "Using reference ${Reference}"

echo "Starting conversion at $(date)"
samtools sort -O bam -l 0 -T "${TmpDir}" --threads 4 "${Input}" | samtools view -T "${Reference}" -C --threads 4 -o "${Output}"
echo "Ending conversion at $(date)"
