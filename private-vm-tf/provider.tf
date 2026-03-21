terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }

# backend "gcs" {
#     bucket = "class-7-5-dawg-tf-bucket"
#     prefix = "lab1-state"
#   }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
