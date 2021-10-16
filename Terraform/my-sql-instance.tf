# Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 4
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "${var.app_name}-${var.app_environment}-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# create My SQL database instance
resource "google_sql_database_instance" "my_sql" {
  name                 = "${var.app_name}-${var.app_environment}-db-${random_id.instance_id.hex}"
  project              = var.app_project
  region               = var.gcp_region_1
  database_version     = var.db_version
  depends_on = [google_service_networking_connection.private_vpc_connection]
  
  settings {
    tier = var.db_tier
    activation_policy           = var.db_activation_policy
    disk_autoresize             = var.db_disk_autoresize
    disk_size                   = var.db_disk_size
    disk_type                   = var.db_disk_type
    pricing_plan                = var.db_pricing_plan
    
    location_preference {
      zone = var.gcp_zone_1
    }

    maintenance_window {
      day  = "7"  # sunday
      hour = "3" # 3am  
    }

    database_flags {
      name  = "log_bin_trust_function_creators"
      value = "on"
    }

    backup_configuration {
      binary_log_enabled = true
      enabled            = true
      start_time         = "00:00"
    }

ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }
  }
}

# create database
resource "google_sql_database" "my_sql_db" {
  name      = var.db_name
  project   = var.app_project
  instance  = google_sql_database_instance.my_sql.name
  charset   = var.db_charset
  collation = var.db_collation
}

# create user
resource "random_id" "user_password" {
  byte_length = 8
}

resource "google_sql_user" "my-sql" {
  name     = var.db_user_name
  project  = var.app_project
  instance = google_sql_database_instance.my_sql.name
  host     = var.db_user_host
  password = var.db_user_password
}