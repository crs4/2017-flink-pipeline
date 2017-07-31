#!/bin/bash

set -o errexit
set -o nounset

Programs="${HOME}/Programs"
Bin="${HOME}/bin"

mkdir -p "${Programs}"
cd "${Programs}"

sudo apt-get install -y --no-install-recommends build-essential libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev git

wget https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2
tar xjf samtools-1.5.tar.bz2
cd samtools*
./configure
make -j 30
cp samtools "${Bin}"

cd "${Programs}"
git clone https://github.com/ilveroluca/rapi.git
cd rapi
./rapi_bwa/setup_bwa.sh bwa-auto-build
cd bwa-auto-build
make -j 30
cp bwa "${Bin}"
