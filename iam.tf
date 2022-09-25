module "organization-iam" {
  source  = "terraform-google-modules/iam/google//modules/organizations_iam"
  version = "~> 7.4"

  organizations = ["674869377315"]

  bindings = {
    
    "roles/billing.admin" = [
      "group:gcp-billing-admins@dallinw.com",
    ]
    
    "roles/resourcemanager.organizationAdmin" = [
      "group:gcp-organization-admins@dallinw.com",
    ]
    
  }
}


module "development-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "~> 7.4"

  folders = [google_folder.development.name]

  bindings = {
    
    "roles/compute.instanceAdmin.v1" = [
      "group:gcp-developers@dallinw.com",
    ]
    
    "roles/container.admin" = [
      "group:gcp-developers@dallinw.com",
    ]
    
  }
}


module "staging-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "~> 7.4"

  folders = [google_folder.staging.name]

  bindings = {
    
    "roles/compute.instanceAdmin.v1" = [
      "group:gcp-developers@dallinw.com",
    ]
    
    "roles/container.admin" = [
      "group:gcp-developers@dallinw.com",
    ]
    
  }
}
