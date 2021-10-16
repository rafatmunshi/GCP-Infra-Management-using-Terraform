terraform {
  required_version = ">= 0.12"
 backend "gcs" {
   bucket="bucketassignment2"
  #  credentials="../coastalbloom.json"
   credentials="coastalbloom.json"
  } 
} 

provider "google" {
  project     = var.app_project
  credentials = file(var.gcp_auth_file)
  region      = var.gcp_region_1
  zone        = var.gcp_zone_1
}

provider "google-beta" {
  project     = var.app_project
  credentials = file(var.gcp_auth_file)
  region      = var.gcp_region_1
  zone        = var.gcp_zone_1
}
