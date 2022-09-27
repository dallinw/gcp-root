#module "logging-kz792-gb530" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = ">= 13"
#
#  name       = "logging"
#  project_id = "logging-kz792-ca530"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
##
#module "monitoring-dev-kz792-gb530" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = ">= 13"
#
#  name       = "monitoring-dev"
#  project_id = "monitoring-dev-kz792-ca530"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
#
#module "monitoring-nonprod-kz792-gb530" {
#  source  = "terraform-google-modules/project-factory/google"
#version = ">= 13"
#
#  name       = "monitoring-nonprod"
#  project_id = "monitoring-nonprod-kz792-ca530"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}

#module "monitoring-prod-kz792-gb530" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = "~> 12.0"
#
#  name       = "monitoring-prod"
#  project_id = "monitoring-prod-kz792-gb5300"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
#
#module "vpc-host-dev-kz792-gb530" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = ">= 13.0.0"
#
#  name       = "vpc-host-dev"
#  project_id = "vpc-host-dev-kz792-gb5300"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
#
#module "vpc-host-nonprod-kz792-gb530" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = ">= 13.0.0"
#
#  name       = "vpc-host-nonprod"
#  project_id = "vpc-host-nonprod-kz792-gb5300"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
#
#module "vpc-host-prod-kz792-gb530" {
#  source  = "terraform-google-modules/project-factory/google"
#  version = ">= 13.0.0"
#
#  name       = "vpc-host-prod"
#  project_id = "vpc-host-prod-kz792-gb5300"
#  org_id     = var.org_id
#  folder_id  = google_folder.common.name
#
#  billing_account = var.billing_account
#}
