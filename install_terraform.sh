#!/bin/bash

# Download Terraform (replace with the latest version)
wget https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip

# Unzip Terraform
unzip terraform_1.5.2_linux_amd64.zip

# Move Terraform to /usr/local/bin
sudo mv terraform /usr/local/bin/

# Verify installation
terraform -v