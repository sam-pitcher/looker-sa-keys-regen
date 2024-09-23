# Terraform Google Cloud Service Account Key Management for Looker

This repository provides a Terraform configuration to manage a Google Cloud service account key and rotate in a Looker connection.

## Prerequisites

Ensure you have the following installed before running the scripts:

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (for authentication)
- A Google Cloud project with the necessary permissions

# Setup

## Spin Up VM in GCP

Make the script files executable.
```
chmod +x install_terraform.sh
chmod +x setup.sh
chmod +x run_script.sh
```
Install terraform
```
bash run_script.sh
```
Install Python and Pip
```
bash setup.sh
```
Clone this repo
```
git clone https://github.com/sam-pitcher/regenerate-looker-sa-keys.git
cd regenerate-looker-sa-keys
```
Update the looker.ini file with Admin Credentials
```
vim looker.ini
```
```
[Looker]
# Base URL for API. Do not include /api/* in the url
base_url=https://self-signed.looker.com:19999
# API 3 client id
client_id=YourClientID
# API 3 client secret
client_secret=YourClientSecret
# Set to false if testing locally against self-signed certs. Otherwise leave True
verify_ssl=True
```

### Authentication with Google Cloud:

Make sure you are authenticated with Google Cloud:

```bash
gcloud auth application-default login
```
Run the script
```
bash run_script.sh -project my-gcp-project -region us-central1 -service_account_email my-service-account@my-gcp-project.iam.gserviceaccount.com -connection_name my-db-connection
```


### Update variables:
Update the terraform.tfvars file:
You can define your variable values in a terraform.tfvars file:

```hcl
project="your-gcp-project-id"
region="your-gcp-region"
service_account_email="your-service-account-email"
```
OR write the variables in the plan.sh file.

### Terraform Bash Script

You can use the following script to initialize Terraform, plan, and apply changes. Make sure to replace the placeholder values with your actual project, region, and service account email.

```bash
#!/bin/bash

# Initialize Terraform
terraform init

# Define variables for project, region, and service account email
PROJECT="GCP-PROJECT-NAME"
REGION="us-central1"
SERVICE_ACCOUNT_EMAIL="SA-EMAIL"

# Run Terraform plan
terraform plan \
  -var="project=$PROJECT" \
  -var="region=$REGION" \
  -var="service_account_email=$SERVICE_ACCOUNT_EMAIL"

# Apply the Terraform configuration
terraform apply -auto-approve \
  -var="project=$PROJECT" \
  -var="region=$REGION" \
  -var="service_account_email=$SERVICE_ACCOUNT_EMAIL"
```

### Python Script for Service Account Key and Looker API

This Python script decodes a base64-encoded service account key output by Terraform, saves it to a JSON file, and initializes the Looker SDK to update a BigQuery connection with the credentials.

#### Script Overview:

1. **Decodes Base64-encoded service account key from a file**.
2. **Parses the key into a JSON structure**.
3. **Writes the key to a `credentials_file.json` file**.
4. **Initializes the Looker SDK** and authenticates with provided credentials.
5. **Updates a Looker BigQuery connection** by including the service account credentials.

sampitcher# looker-sa-keys-regen
