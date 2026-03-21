# Prints useful info after terraform apply

output "vm_external_ip" {
  description = "External IP of the VM"
  value       = "http://${google_compute_instance.vm.network_interface[0].access_config[0].nat_ip}"
}

output "vm_internal_ip" {
  description = "Internal IP of the VM"
  value       = google_compute_instance.vm.network_interface[0].network_ip
}

output "vpc_name" {
  description = "Name of the VPC"
  value       = google_compute_network.vpc.name
}

output "subnet_cidr" {
  description = "CIDR range of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

# output "bucket_name" {
#   description = "Name of the storage bucket"
#   value       = google_storage_bucket.bucket.name
# }

# output "bucket_url" {
#   description = "URL of the storage bucket"
#   value       = google_storage_bucket.bucket.url
# }

output "ssh_command" {
  description = "Command to SSH into the VM"
  value       = "ssh -i ~/.ssh/google_compute_engine ${var.ssh_user}@${google_compute_instance.vm.network_interface[0].access_config[0].nat_ip}"
}