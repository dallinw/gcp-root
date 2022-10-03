variable "billing_account" {
  description = "The ID of the billing account to associate projects with"
  type        = string
  default     = "01D882-5C61E8-0A7B97"
}

variable "org_id" {
  description = "The organization id for the associated resources"
  type        = string
  default     = "674869377315"
}

variable "project_suffix" {
  description = "GCP project names must be globally unique, so choose a unique suffix to append to project names"
  type        = string
  default     = "blue52"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-east"
}