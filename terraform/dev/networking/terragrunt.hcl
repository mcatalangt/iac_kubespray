include "root" {
  path = find_in_parent_folders()
}

locals {
  gcp_project_id = get_env("GOOGLE_PROJECT_ID", "mi-proyecto-local-fallback")
  gcp_region = get_env("GOOGLE_REGION", "us-central1")
  deploy_stack = get_env("TARGET_ENV", "dev")
}

terraform {
  source = "../../modules/networking"
}

inputs = {
  project_id = "${local.gcp_project_id}"
  region   = "${local.gcp_region}"
  network_name = "kubespray-vpc"
  subnet_name  = "kubespray-subnet"
  subnet_cidr  = "10.10.0.0/24"
}




