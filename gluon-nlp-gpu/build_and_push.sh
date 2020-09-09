region=$(aws configure get region)
account_id=$(aws sts get-caller-identity --query "Account" --output text)
registry_uri=${account_id}.dkr.ecr.${region}.amazonaws.com.cn
image=gluon-nlp
fullname=${registry_uri}/${image}

$(aws ecr get-login --registry-ids 250779322837 --region cn-north-1 --no-include-email)
$(aws ecr get-login --registry-ids ${account_id} --region ${region} --no-include-email)

# If the repository doesn't exist in ECR, create it.
aws ecr describe-repositories --repository-names "${image}" --region ${region} || aws ecr create-repository --repository-name "${image}" --region ${region}

docker pull 250779322837.dkr.ecr.cn-north-1.amazonaws.com.cn/mxnet:latest
docker build -t ${image} -f Dockerfile .

docker run --runtime=nvidia -t ${image}

docker tag ${image} ${fullname}
docker push ${fullname}
