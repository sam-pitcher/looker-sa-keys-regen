# Terraform Google Cloud Service Account Key Management for Looker

This repository provides a Terraform configuration to manage a Google Cloud service account key and rotate in a Looker connection.

# Setup

## Spin Up VM in GCP

Install necessary packages.
```
sudo apt-get update
sudo apt-get install -y git unzip python3 python3-venv python3-pip
git --version
```

Clone this repo
```
git clone https://github.com/sam-pitcher/looker-sa-keys-regen.git
cd looker-sa-keys-regen
```

Make the script files executable.
```
chmod +x install_terraform.sh
chmod +x run_script.sh
```

Install terraform
```
bash install_terraform.sh
```

Create and activate a virtual environment. Install the looker-sdk with pip.
```
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
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
- your_project_id Project associated with Service Account
- region us-central1
- service_account_email Service Account used for Looker > BigQuery
- connection_name: Connection Name set up in Looker
```
bash run_script.sh -p your_project_id -r region -s your_service_account_email -c connection_name

```

### Python Script for Service Account Key and Looker API

This Python script decodes a base64-encoded service account key output by Terraform, saves it to a JSON file, and initializes the Looker SDK to update a BigQuery connection with the credentials.

#### Script Overview:

1. **Decodes Base64-encoded service account key from a file**.
2. **Parses the key into a JSON structure**.
3. **Writes the key to a `credentials_file.json` file**.
4. **Initializes the Looker SDK** and authenticates with provided credentials.
5. **Updates a Looker BigQuery connection** by including the service account credentials.

## Stop the VM

sampitcher# looker-sa-keys-regen
