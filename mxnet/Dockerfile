# Note: We need to install NCCL, cuDNN, and CUDA libraries since we are using base container.
ARG REGISTRY_URI
# FROM 250779322837.dkr.ecr.cn-north-1.amazonaws.com.cn/mxnet-src:latest
FROM ${REGISTRY_URI}/mxnet-src:latest

ARG PYTHON=python3
ARG PIP=pip3
ARG PYTHON_VERSION=3.6.8

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib" \
    PATH="${PATH}:/usr/local/cuda/bin" \
    PYTHONIOENCODING=UTF-8 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

ENV BUILD_OPTS "USE_CUDA=1 USE_CUDA_PATH=/usr/local/cuda USE_CUDNN=1"

RUN apt-get update
RUN apt-get install -y python3 aptitude python3-distutils

# the version of the pip shipped with ubuntu may be too lower, install a recent version here
RUN cd /tmp && wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py

RUN ls -lah /usr/bin | grep python 2>&1 | tee outfile
RUN pip3 install -i https://opentuna.cn/pypi/web/simple cmake opencv-python==4.2.0.34
RUN ln -sf /usr/bin/gcc-7 /usr/bin/gcc
RUN ln -sf /usr/bin/g++-7 /usr/bin/g++

RUN apt-get update && apt-get install -y python3-dev libopenblas-dev llvm-6.0-dev libomp-dev

RUN ls -lah /usr/local/lib/python3.6/dist-packages/mxnet 2>&1 | tee outfile

COPY mxnet-2.0.0-py2.py3-none-any.whl /tmp
RUN pip3 install /tmp/mxnet-2.0.0-py2.py3-none-any.whl
COPY libmxnet.so /usr/local/lib/python3.6/dist-packages/mxnet

ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib/x86_64-linux-gnu"

COPY libopencv_imgcodecs.so.4.2 /usr/local/lib/
COPY libopencv_imgproc.so.4.2 /usr/local/lib/
COPY libopencv_core.so.4.2 /usr/local/lib/

RUN apt-get install -y libjpeg-turbo8 libpng-dev libtiff-dev

RUN mkdir -p /opt/program
COPY serve.py /opt/program
WORKDIR /opt/program

ENTRYPOINT ["python3", "-u", "serve.py"]
