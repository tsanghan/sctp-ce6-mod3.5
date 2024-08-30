### This repository demonstrates
1. The creation of container images using `docker build` command.
2. Running of container instances from container images using `docker run` command.
3. Multi-stage build techniques with distroless images.
4. Please read [node/Dockerfile](node/Dockerfile) and [python/Dockerfile](python/Dockerfile) for details.
5. Creation of ECR Public repository with `AWS CLI`.
6. Login to AWS ECR Public repository with `AWS CLI` & `Docker` command.
6. Pushing Container images to ECR Public repository with `Docker` command.

### To build the container images
```
for app in node python; do
    docker build -t sctp-ce6-mod3.5:"$app" "$app"
done
```

### To run the container
```
cat <<'EOF' | tee run.sh
#!/usr/bin/env bash
declare -A arr
arr=( ["node"]="8081" ["python"]="8082" )
export APP_PORT=9090
for app in ${!arr[@]}; do
    docker run -e APP_PORT -d -p ${arr[${app}]}:"$APP_PORT" sctp-ce6-mod3.5:${app}
done
EOF
bash run.sh
rm run.sh
```

### To test the container
```
cat <<'EOF' | tee test.sh
#!/usr/bin/env bash
declare -A arr
arr=( ["node"]="8081" ["python"]="8082" )
for app in ${!arr[@]}; do
    port=${arr[${app}]}
    printf "Response from port %s\n" "$port"; curl -s localhost:"$port" | jq . ; echo
done
EOF
bash test.sh
rm test.sh
```

### To stop and remove the running containers
```
docker rm $(docker ps | \
            grep "sctp-ce6-mod3.5" | \
            awk '{print $1}') --force
```

### To tag container images before pushing to ECR
```
for app in node python; do
    docker tag sctp-ce6-mod3.5:"$app" \
               public.ecr.aws/u2q1a2y8/tsanghan-ce6/sctp-ce6-mod3.5:"$app"
done
```
### Create ECR Public container repository with AWS CLI or Tofu/Terraform
```
aws ecr-public create-repository \
    --repository-name tsanghan-ce6/sctp-ce6-mod3.5 \
    --region us-east-1
```
***Alternatively, we can use Tofu/Terrafom to create ECR Public container repository, please see main.tf file.***

### Login to AWS ECR Public repository with `AWS CLI` & `Docker` command.
```
aws ecr-public get-login-password --region us-east-1 | \
    docker login --username AWS --password-stdin public.ecr.aws/u2q1a2y8
```
### Pushing Container images to ECR Public repository with `Docker` command.
```
for app in node python; do
    docker push public.ecr.aws/u2q1a2y8/tsanghan-ce6/sctp-ce6-mod3.5:"$app"
done
```