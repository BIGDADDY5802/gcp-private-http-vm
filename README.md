# gcp-private-http-vm

![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![GCP](https://img.shields.io/badge/Google_Cloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![Shell Script](https://img.shields.io/badge/Shell_Script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)
![Infrastructure as Code](https://img.shields.io/badge/IaC-Infrastructure_as_Code-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

# Terraform GCP Infrastructure

## Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/install) installed
- [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed
- A GCP project

---

## Setup

### 1. Authenticate with GCP
```bash
gcloud auth application-default login
```

### 2. Clone the repo and navigate to the project folder
```bash
git clone <your-repo-url>
cd <your-project-folder>
```

### 3. Create a `.gitignore`
Copy the `.gitignore` from this repo into your project root. It protects you from accidentally committing state files and credentials.

---

## File Structure
```
.
├── provider.tf       # GCP connection and Terraform version config
├── variables.tf      # All configurable variables
├── vpc.tf            # VPC network and subnet
├── firewall.tf       # Firewall rules for HTTP and SSH
├── vm.tf             # VM instance
├── storage.tf        # Cloud Storage bucket
├── outputs.tf        # Prints useful info after apply
├── startup.sh        # VM startup script
└── .gitignore        # Keeps secrets and state out of git
```

---

## Usage

### Initialize Terraform (run once)
Downloads the Google provider plugin.
```bash
terraform init
```

### Preview changes
Shows what Terraform will create, change, or destroy — no changes made yet.
```bash
terraform plan
```

### Apply changes
Creates or updates your infrastructure.
```bash
terraform apply
```
Type `yes` when prompted.

### Destroy infrastructure
Tears down everything Terraform created.
```bash
terraform destroy
```
Type `yes` when prompted.

---

## After Apply
Terraform will print your outputs:
```
Outputs:

bucket_name    = "name-of-your-bucket-12345"
bucket_url     = "gs://name-of-your-bucket-12345"
ssh_command    = "ssh -i ~/.ssh/google_compute_engine <acct-username>@xx.xx.xx.xx"
subnet_cidr    = "10.10.0.0/24"
vm_external_ip = "xx.xx.xx.xx"
vm_internal_ip = "10.10.0.x"
vpc_name       = "tf-vpc"
```

Copy the `ssh_command` output to SSH directly into your VM.

---

## Important Rules
- **Never commit** `*.tfstate` files — they contain sensitive infrastructure details
- **Never commit** `*.json` credential files — they give full GCP access
- **Never commit** `*.tfvars` files — they may contain secrets
- Always run `terraform plan` before `terraform apply` to review changes