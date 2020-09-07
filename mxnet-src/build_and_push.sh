account_id=$(aws sts get-caller-identity --query "Account" --output text)

$(aws ecr get-login --registry-ids ${account_id} --region cn-north-1 --no-include-email)

docker build -t mxnet-src -f Dockerfile .
docker run mxnet-src
docker tag mxnet-src ${account_id}.dkr.ecr.cn-north-1.amazonaws.com.cn/mxnet-src
docker push ${account_id}.dkr.ecr.cn-north-1.amazonaws.com.cn/mxnet-src
