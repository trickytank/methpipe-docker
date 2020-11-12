FROM ubuntu:20.04

LABEL maintainer="Rick Tankard <Rick.Tankard@murdoch.edu.au>"
LABEL version="4.1.1"
LABEL description="This is a docker container for the MethPipe software. \
Song Q, Decato B, Hong E, Zhou M, Fang F, Qu J, Garvin T, Kessler M, Zhou J, Smith AD (2013) A reference methylome database and analysis pipeline to facilitate integrative and comparative epigenomics. PLOS ONE 8(12): e81148"

RUN apt-get update && \
    apt-get install -y \
        curl \
        g++ \
        make \
        libgsl-dev \
        zlib1g-dev \
        libhts-dev \
    && rm -rf /var/lib/apt/lists/* && apt-get clean


RUN ver=4.1.1 && \
    curl -SL https://github.com/smithlabcode/methpipe/releases/download/v$ver/methpipe-$ver.tar.gz \
        | tar xzC /usr/local/src && \
    cd /usr/local/src/methpipe-$ver && \
    mkdir build && \
    cd build && \
    ../configure --enable-hts && \
    make && \
    make install && \
    rm -r /usr/local/src/methpipe-$ver

