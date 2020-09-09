# Note: We need to install NCCL, cuDNN, and CUDA libraries since we are using base container.
FROM 250779322837.dkr.ecr.cn-north-1.amazonaws.com.cn/mxnet-cpu:latest

RUN aptitude install cython3

RUN mkdir -p /opt/program
COPY gluon-nlp /opt/program/gluon-nlp
WORKDIR /opt/program/gluon-nlp

RUN ls -lah /opt/program | tee outputfile
RUN cd /opt/program/gluon-nlp && python3 setup.py bdist_wheel && cd dist && pip3 install gluonnlp-1.0.0.dev20200909-py3-none-any.whl

COPY serve.py /opt/program
WORKDIR /opt/program

# RUN ls -lah /usr/local/lib/python3.6/dist-packages/gluonnlp-1.0.0.dev20200909-py3.6.egg/gluonnlp/models
RUN ls -lah /usr/local/lib/python3.6/dist-packages/ | grep gluon | tee outputfile

ENTRYPOINT ["python3", "-u", "serve.py"]
