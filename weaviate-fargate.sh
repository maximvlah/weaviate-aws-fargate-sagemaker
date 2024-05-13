#!/bin/sh
aws ecs create-cluster --cluster-name weaviate-cluster > /dev/null
aws ecs register-task-definition --cli-input-json file://weaviate-task.json  > /dev/null
AWS_SUBNETS=$(aws ec2 describe-subnets --query "Subnets[*].SubnetId" --output text | tr '\t' ',')
AWS_SG=$(aws ec2 describe-security-groups --filters Name=group-name,Values=default --query 'SecurityGroups[0].GroupId' --output text)
aws ecs create-service --cluster weaviate-cluster --service-name weaviate-service --task-definition weaviate-task --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={securityGroups=[${AWS_SG}],subnets=[${AWS_SUBNETS}],assignPublicIp=ENABLED}"  > /dev/null
SM_IP=$(host myip.opendns.com resolver1.opendns.com | awk '/has address/ { print $4 }')
aws ec2 authorize-security-group-ingress --group-id ${AWS_SG} --protocol tcp --port 8080-50051 --cidr ${SM_IP}/32
