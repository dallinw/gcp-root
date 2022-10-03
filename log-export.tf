module "logsink-organization-logbucketsink" {
  source  = "terraform-google-modules/log-export/google"
  version = "~> 7.3.0"

  destination_uri      = module.dallinw-logging-destination.destination_uri
  log_sink_name        = "${var.org_id}-logbucketsink"
  parent_resource_id   = var.org_id
  parent_resource_type = "organization"
  include_children     = true
}

module "dallinw-logging-destination" {
  source  = "terraform-google-modules/log-export/google//modules/logbucket"
  version = "~> 7.4.1"

  project_id               = module.logging.project_id
  name                     = "dallinw-logging"
  location                 = "global"
  retention_days           = 365
  log_sink_writer_identity = module.logsink-organization-logbucketsink.writer_identity
}
