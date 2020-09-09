region=$(aws configure get region)
account_id=$(aws sts get-caller-identity --query "Account" --output text)
registry_uri=${account_id}.dkr.ecr.cn-north-1.amazonaws.com.cn
image=mxnet-cpu
fullname=${registry_uri}/${image}

$(aws ecr get-login --registry-ids ${account_id} --region cn-north-1 --no-include-email)

# If the repository doesn't exist in ECR, create it.
aws ecr describe-repositories --repository-names "${image}" --region ${region} || aws ecr create-repository --repository-name "${image}" --region ${region}

docker pull ${registry_uri}/mxnet-src:latest
docker build -t ${image} -f Dockerfile . --build-arg REGISTRY_URI=${registry_uri}

docker run -t ${image}

docker tag ${image} ${fullname}
docker push ${fullname}
