# VM Instance
resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  # Tags connect this VM to the firewall rules above
  tags = ["http-server", "ssh-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

    # Gives the VM a public IP
    access_config {}
  }

  metadata_startup_script = file("${path.module}/startup.sh")
}
