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

module "development" {
  source  = "terraform-google-modules/project-factory/google"
  version = ">= 13"

  name       = "development"
  project_id = "development-${var.project_suffix}"
  org_id     = var.org_id
  folder_id  = google_folder.common.name

  billing_account = var.billing_account
}