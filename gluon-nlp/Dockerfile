# Note: We need to install NCCL, cuDNN, and CUDA libraries since we are using base container.
FROM 250779322837.dkr.ecr.cn-north-1.amazonaws.com.cn/mxnet:latest

RUN mkdir -p /opt/program
COPY gluon-nlp /opt/program
COPY serve.py /opt/program
WORKDIR /opt/program

ENTRYPOINT ["python3", "-u", "serve.py"]
