# VPC and Subnets
module "vpc-host-dev" {
    source  = "terraform-google-modules/network/google"
    version = "~> 5.0"

    project_id   = module.vpc-host-dev-kz792-gb530.project_id
    network_name = "vpc-host-dev"

    subnets = [
       
        {
            subnet_name           = "subnet-dev-1"
            subnet_ip             = "10.0.0.0/16"
            subnet_region         = "us-east1"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
        {
            subnet_name           = "subnet-dev-2"
            subnet_ip             = "10.1.0.0/16"
            subnet_region         = "us-west1"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
    ]
}
# Firewall Rules
resource "google_compute_firewall" "vpc-host-dev-allow-iap-rdp" {
  name      = "vpc-host-dev-allow-iap-rdp"
  network   = module.vpc-host-dev.network_name
  project   = module.vpc-host-dev-kz792-gb530.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["3389",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-dev-allow-iap-ssh" {
  name      = "vpc-host-dev-allow-iap-ssh"
  network   = module.vpc-host-dev.network_name
  project   = module.vpc-host-dev-kz792-gb530.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["22",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-dev-allow-icmp" {
  name      = "vpc-host-dev-allow-icmp"
  network   = module.vpc-host-dev.network_name
  project   = module.vpc-host-dev-kz792-gb530.project_id
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
resource "google_compute_router" "cr-vpc-host-dev-us-east1-router" {
  name    = "cr-vpc-host-dev-us-east1-router"
  project = module.vpc-host-dev-kz792-gb530.project_id
  region  = "us-east1"
  network = module.vpc-host-dev.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-dev-us-east1-egress" {
  name                               = "rn-vpc-host-dev-us-east1-egress"
  project                            = module.vpc-host-dev-kz792-gb530.project_id
  router                             = google_compute_router.cr-vpc-host-dev-us-east1-router.name
  region                             = "us-east1" 
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-dev-us-east1-1.*.self_link 
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config { 
    filter = "TRANSLATIONS_ONLY" 
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-dev-us-east1-1" {
  project = module.vpc-host-dev-kz792-gb530.project_id
  name    = "ca-vpc-host-dev-us-east1-1"
  region  = "us-east1"
}
resource "google_compute_router" "cr-vpc-host-dev-us-west1-router" {
  name    = "cr-vpc-host-dev-us-west1-router"
  project = module.vpc-host-dev-kz792-gb530.project_id
  region  = "us-west1"
  network = module.vpc-host-dev.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-dev-us-west1-egress" {
  name                               = "rn-vpc-host-dev-us-west1-egress"
  project                            = module.vpc-host-dev-kz792-gb530.project_id
  router                             = google_compute_router.cr-vpc-host-dev-us-west1-router.name
  region                             = "us-west1" 
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-dev-us-west1-1.*.self_link 
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config { 
    filter = "TRANSLATIONS_ONLY" 
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-dev-us-west1-1" {
  project = module.vpc-host-dev-kz792-gb530.project_id
  name    = "ca-vpc-host-dev-us-west1-1"
  region  = "us-west1"
}

# VPC and Subnets
module "vpc-host-nonprod" {
    source  = "terraform-google-modules/network/google"
    version = "~> 5.0"

    project_id   = module.vpc-host-nonprod-kz792-gb530.project_id
    network_name = "vpc-host-nonprod"

    subnets = [
       
        {
            subnet_name           = "subnet-non-prod-1"
            subnet_ip             = "10.0.0.0/16"
            subnet_region         = "us-east1"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
        {
            subnet_name           = "subnet-non-prod-2"
            subnet_ip             = "10.1.0.0/16"
            subnet_region         = "us-west1"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
    ]
}
# Firewall Rules
resource "google_compute_firewall" "vpc-host-nonprod-allow-iap-rdp" {
  name      = "vpc-host-nonprod-allow-iap-rdp"
  network   = module.vpc-host-nonprod.network_name
  project   = module.vpc-host-nonprod-kz792-gb530.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["3389",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-nonprod-allow-iap-ssh" {
  name      = "vpc-host-nonprod-allow-iap-ssh"
  network   = module.vpc-host-nonprod.network_name
  project   = module.vpc-host-nonprod-kz792-gb530.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["22",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-nonprod-allow-icmp" {
  name      = "vpc-host-nonprod-allow-icmp"
  network   = module.vpc-host-nonprod.network_name
  project   = module.vpc-host-nonprod-kz792-gb530.project_id
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
resource "google_compute_router" "cr-vpc-host-nonprod-us-east1-router" {
  name    = "cr-vpc-host-nonprod-us-east1-router"
  project = module.vpc-host-nonprod-kz792-gb530.project_id
  region  = "us-east1"
  network = module.vpc-host-nonprod.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-nonprod-us-east1-egress" {
  name                               = "rn-vpc-host-nonprod-us-east1-egress"
  project                            = module.vpc-host-nonprod-kz792-gb530.project_id
  router                             = google_compute_router.cr-vpc-host-nonprod-us-east1-router.name
  region                             = "us-east1" 
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-nonprod-us-east1-1.*.self_link 
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config { 
    filter = "TRANSLATIONS_ONLY" 
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-nonprod-us-east1-1" {
  project = module.vpc-host-nonprod-kz792-gb530.project_id
  name    = "ca-vpc-host-nonprod-us-east1-1"
  region  = "us-east1"
}
resource "google_compute_router" "cr-vpc-host-nonprod-us-west1-router" {
  name    = "cr-vpc-host-nonprod-us-west1-router"
  project = module.vpc-host-nonprod-kz792-gb530.project_id
  region  = "us-west1"
  network = module.vpc-host-nonprod.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-nonprod-us-west1-egress" {
  name                               = "rn-vpc-host-nonprod-us-west1-egress"
  project                            = module.vpc-host-nonprod-kz792-gb530.project_id
  router                             = google_compute_router.cr-vpc-host-nonprod-us-west1-router.name
  region                             = "us-west1" 
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-nonprod-us-west1-1.*.self_link 
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config { 
    filter = "TRANSLATIONS_ONLY" 
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-nonprod-us-west1-1" {
  project = module.vpc-host-nonprod-kz792-gb530.project_id
  name    = "ca-vpc-host-nonprod-us-west1-1"
  region  = "us-west1"
}

# VPC and Subnets
module "vpc-host-prod" {
    source  = "terraform-google-modules/network/google"
    version = "~> 5.0"

    project_id   = module.vpc-host-prod-kz792-gb530.project_id
    network_name = "vpc-host-prod"

    subnets = [
       
        {
            subnet_name           = "subnet-prod-1"
            subnet_ip             = "10.0.0.0/16"
            subnet_region         = "us-east1"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
        {
            subnet_name           = "subnet-prod-2"
            subnet_ip             = "10.1.0.0/16"
            subnet_region         = "us-west1"
            subnet_private_access = true
            subnet_flow_logs      = true
            subnet_flow_logs_sampling = "0.5"
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
        },
    ]
}
# Firewall Rules
resource "google_compute_firewall" "vpc-host-prod-allow-iap-rdp" {
  name      = "vpc-host-prod-allow-iap-rdp"
  network   = module.vpc-host-prod.network_name
  project   = module.vpc-host-prod-kz792-gb530.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["3389",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-prod-allow-iap-ssh" {
  name      = "vpc-host-prod-allow-iap-ssh"
  network   = module.vpc-host-prod.network_name
  project   = module.vpc-host-prod-kz792-gb530.project_id
  direction = "INGRESS"
  priority  = 10000

  log_config {
      metadata = "INCLUDE_ALL_METADATA"
    }

  allow {
    protocol = "tcp"
    ports    = ["22",]
  }

  source_ranges = [
  "35.235.240.0/20",
  ]
}
resource "google_compute_firewall" "vpc-host-prod-allow-icmp" {
  name      = "vpc-host-prod-allow-icmp"
  network   = module.vpc-host-prod.network_name
  project   = module.vpc-host-prod-kz792-gb530.project_id
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
resource "google_compute_router" "cr-vpc-host-prod-us-east1-router" {
  name    = "cr-vpc-host-prod-us-east1-router"
  project = module.vpc-host-prod-kz792-gb530.project_id
  region  = "us-east1"
  network = module.vpc-host-prod.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-prod-us-east1-egress" {
  name                               = "rn-vpc-host-prod-us-east1-egress"
  project                            = module.vpc-host-prod-kz792-gb530.project_id
  router                             = google_compute_router.cr-vpc-host-prod-us-east1-router.name
  region                             = "us-east1" 
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-prod-us-east1-1.*.self_link 
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config { 
    filter = "TRANSLATIONS_ONLY" 
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-prod-us-east1-1" {
  project = module.vpc-host-prod-kz792-gb530.project_id
  name    = "ca-vpc-host-prod-us-east1-1"
  region  = "us-east1"
}
resource "google_compute_router" "cr-vpc-host-prod-us-west1-router" {
  name    = "cr-vpc-host-prod-us-west1-router"
  project = module.vpc-host-prod-kz792-gb530.project_id
  region  = "us-west1"
  network = module.vpc-host-prod.network_self_link
}

resource "google_compute_router_nat" "rn-vpc-host-prod-us-west1-egress" {
  name                               = "rn-vpc-host-prod-us-west1-egress"
  project                            = module.vpc-host-prod-kz792-gb530.project_id
  router                             = google_compute_router.cr-vpc-host-prod-us-west1-router.name
  region                             = "us-west1" 
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.ca-vpc-host-prod-us-west1-1.*.self_link 
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config { 
    filter = "TRANSLATIONS_ONLY" 
    enable = true
  }
}

resource "google_compute_address" "ca-vpc-host-prod-us-west1-1" {
  project = module.vpc-host-prod-kz792-gb530.project_id
  name    = "ca-vpc-host-prod-us-west1-1"
  region  = "us-west1"
}
