module "logging" {
  source  = "terraform-google-modules/project-factory/google"
  version = ">= 13"

  name       = "logging"
  project_id = "logging-${var.project_suffix}"
  org_id     = var.org_id
  folder_id  = google_folder.common.name

  billing_account = var.billing_account
}

module "monitoring" {
  source  = "terraform-google-modules/project-factory/google"
  version = ">= 13"

  name       = "monitoring-dev"
  project_id = "monitoring-dev-${var.project_suffix}"
  org_id     = var.org_id
  folder_id  = google_folder.common.name

  billing_account = var.billing_account
}

#module "monitoring-nonprod" {
#  source  = "terraform-google-modules/project-factory/google"
#version = ">= 13"
#
#  name       = "monitoring-nonprod"
#  project_id = "monitoring-nonprod-${var.project_suffix}"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}

#module "monitoring-prod" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = "~> 12.0"
#
#  name       = "monitoring-prod"
#  project_id = "monitoring-prod-glu5550"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}

module "vpc-host-dev" {
  source  = "terraform-google-modules/project-factory/google"
  version = ">= 13"

  name       = "vpc-host-dev"
  project_id = "vpc-host-dev-${var.project_suffix}"
  org_id     = var.org_id
  folder_id  = google_folder.common.name

  billing_account = var.billing_account
}

#module "vpc-host-nonprod" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = ">= 13.0.0"
#
#  name       = "vpc-host-nonprod"
#  project_id = "vpc-host-nonprod-glu5550"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
#
#module "vpc-host-prod" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = ">= 13.0.0"
#
#  name       = "vpc-host-prod"
#  project_id = "vpc-host-prod-glu5550"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
