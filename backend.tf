terraform {
  backend "remote" {
    organization = "dallinw"

    workspaces {
      name = "gcp-root"
    }
  }
}
