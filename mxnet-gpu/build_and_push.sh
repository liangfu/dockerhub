account_id=$(aws sts get-caller-identity --query "Account" --output text)
registry_uri=${account_id}.dkr.ecr.cn-north-1.amazonaws.com.cn

$(aws ecr get-login --registry-ids ${account_id} --region cn-north-1 --no-include-email)

docker pull ${registry_uri}/mxnet-src:latest
docker build -t mxnet -f Dockerfile . --build-arg REGISTRY_URI=${registry_uri}

docker run --runtime=nvidia -t mxnet

docker tag mxnet ${registry_uri}/mxnet
docker push ${registry_uri}/mxnet
