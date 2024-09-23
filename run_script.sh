#!/bin/bash

while getopts p:r:s: option
do
 case "${option}"
 in
  p) PROJECT=${OPTARG};;
  r) REGION=${OPTARG};;
  s) SERVICE_ACCOUNT_EMAIL=${OPTARG};;
  c) CONNECTION_NAME=${OPTARG};;
 esac
done

echo "Project: $PROJECT"
echo "Region: $REGION"
echo "Service Account Email: $SERVICE_ACCOUNT_EMAIL"

# Initialize Terraform
terraform init

# Run Terraform plan
terraform plan \
  -var="project=$PROJECT" \
  -var="region=$REGION" \
  -var="service_account_email=$SERVICE_ACCOUNT_EMAIL"

terraform apply -auto-approve \
  -var="project=$PROJECT" \
  -var="region=$REGION" \
  -var="service_account_email=$SERVICE_ACCOUNT_EMAIL"

terraform output -json > service_account_key_base64.json

pip3 install -r requirements.txt

python3 main.py --connection_name "$CONNECTION_NAME"