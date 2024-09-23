# Define variables for the project and region
variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "service_account_email" {
  description = "The email address of the existing service account"
  type        = string
}

# Configure the Google Cloud provider using variables
provider "google" {
  project = var.project
  region  = var.region
}

# Reference an existing service account by its email
data "google_service_account" "existing" {
  account_id = var.service_account_email
}

# Generate a key for the existing service account
resource "google_service_account_key" "new_key" {
  service_account_id = data.google_service_account.existing.email
  key_algorithm      = "KEY_ALG_RSA_2048"
}

# Output the new key as a JSON file
output "service_account_key_json" {
  value     = google_service_account_key.new_key.private_key
  sensitive = true
}