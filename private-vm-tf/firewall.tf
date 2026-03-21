# Allow HTTP traffic (port 80)
resource "google_compute_firewall" "allow_http" {
  name    = "tf-allow-http"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# Allow SSH traffic (port 22)
resource "google_compute_firewall" "allow_ssh" {
  name    = "tf-allow-ssh"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-server"]
}
