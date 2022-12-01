# VPC and Subnets
module "vpc-host-production" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0"

  project_id   = module.production.project_id
  network_name = "vpc-host-production"

  subnets = [

    {
      subnet_name               = "subnet-production-1"
      subnet_ip                 = "10.0.0.0/16"
      subnet_region             = "${var.region}1"
      subnet_private_access     = true
      subnet_flow_logs          = true
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },
    {
      subnet_name               = "subnet-production-2"
      subnet_ip                 = "10.1.0.0/16"
      subnet_region             = "${var.region}1"
      subnet_private_access     = true
      subnet_flow_logs          = true
      subnet_flow_logs_sampling = "0.5"
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
    },
  ]
}

# Firewall Rules
resource "google_compute_firewall" "vpc-host-production-allow-iap-rdp" {
  name      = "vpc-host-production-allow-iap-rdp"
  network   = module.vpc-host-production.network_name
  project   = module.production.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "tcp"
    ports    = ["3389", ]
  }

  source_ranges = [
    "35.235.240.0/20",
  ]
}

resource "google_compute_firewall" "vpc-host-production-allow-iap-ssh" {
  name      = "vpc-host-production-allow-iap-ssh"
  network   = module.vpc-host-production.network_name
  project   = module.production.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", ]
  }

  source_ranges = [
    "35.235.240.0/20",
  ]
}

resource "google_compute_firewall" "vpc-host-production-allow-icmp" {
  name      = "vpc-host-production-allow-icmp"
  network   = module.vpc-host-production.network_name
  project   = module.production.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "10.128.0.0/9",
  ]
}

# NAT Router and config
resource "google_compute_router" "cr-vpc-host-production-us-east1-router" {
  name    = "cr-vpc-host-production-us-east1-router"
  project = module.production.project_id
  region  = "us-east1"
  network = module.vpc-host-production.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-production-us-east1-egress" {
  name                               = "rn-vpc-host-production-us-east1-egress"
  project                            = module.production.project_id
  router                             = google_compute_router.cr-vpc-host-production-us-east1-router.name
  region                             = "us-east1"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-production-us-east1-1.*.self_link
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    filter = "TRANSLATIONS_ONLY"
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-production-us-east1-1" {
  project = module.production.project_id
  name    = "ca-vpc-host-production-us-east1-1"
  region  = "us-east1"
}

resource "google_compute_router" "cr-vpc-host-production-us-west1-router" {
  name    = "cr-vpc-host-production-us-west1-router"
  project = module.production.project_id
  region  = "us-west1"
  network = module.vpc-host-production.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-production-us-west1-egress" {
  name                               = "rn-vpc-host-production-us-west1-egress"
  project                            = module.production.project_id
  router                             = google_compute_router.cr-vpc-host-production-us-west1-router.name
  region                             = "us-west1"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-production-us-west1-1.*.self_link
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    filter = "TRANSLATIONS_ONLY"
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-production-us-west1-1" {
  project = module.production.project_id
  name    = "ca-vpc-host-production-us-west1-1"
  region  = "us-west1"
}