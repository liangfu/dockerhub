# Note: We need to install NCCL, cuDNN, and CUDA libraries since we are using base container.
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

ARG PYTHON=python3
ARG PIP=pip3
ARG PYTHON_VERSION=3.6.8

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib" \
    PYTHONIOENCODING=UTF-8 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN DEBIAN_FRONTEND="noninteractive" apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    build-essential git libatlas-base-dev python3-pip \
    libcurl4-openssl-dev libgtest-dev cmake wget unzip

RUN cd /usr/src/gtest && cmake CMakeLists.txt && make && cp *.a /usr/lib

ENV BUILD_OPTS "USE_CUDA=1 USE_CUDA_PATH=/usr/local/cuda USE_CUDNN=1"
RUN git clone --recursive --branch master https://github.com/apache/incubator-mxnet mxnet && cd mxnet && \
    git checkout 86e96dc7decb9d51345d716e202e0be74ffdcf5b && git submodule update --recursive

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/ppa
RUN apt-get update
RUN apt-get install -y gcc-7 g++-7
