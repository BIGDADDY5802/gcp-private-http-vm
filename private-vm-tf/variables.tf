variable "project_id" {
  description = "GCP project ID"
  default     = "class-7-5-dawg"
}

variable "region" {
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  default     = "us-central1-c"
}

variable "instance_name" {
  description = "Name of the VM instance"
  default     = "tf-instance-1"
}

variable "machine_type" {
  description = "GCP machine type"
  default     = "e2-medium"
}

variable "vpc_name" {
  description = "Name of the VPC network"
  default     = "tf-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  default     = "tf-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  default     = "10.52.0.0/24"
}

variable "bucket_name" {
  description = "Name of the storage bucket (must be globally unique)"
  default     = "class-7-5-tf-state-bucket-1"
}

variable "ssh_user" {
  description = "SSH username (your Google account username)"
  default     = "jeromegcloud7"
}
