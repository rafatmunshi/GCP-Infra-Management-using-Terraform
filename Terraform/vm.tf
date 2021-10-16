# Create web server #1
resource "google_compute_instance" "web_private_1" {
  count = var.app_node_count
  name = "${var.app_name}-${var.app_environment}-vm-${count.index}"
  
  machine_type = var.machine_type
  zone = var.gcp_zone_1
  
  hostname = "${var.app_name}-${var.app_environment}-vm1.${var.app_domain}"
  tags = ["ssh","http"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask; sudo apt install mysql-client; sudo apt-get install python-dev default-libmysqlclient-dev libssl-dev; pip install --user flask-mysqldb"
  network_interface {
    network = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.private_subnet_1.name
  }
}