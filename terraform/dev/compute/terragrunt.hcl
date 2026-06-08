include "root" {
  path = find_in_parent_folders()
}

locals {
  gcp_project_id = get_env("GOOGLE_PROJECT_ID", "mi-proyecto-local-fallback")
  gcp_region = get_env("GOOGLE_REGION", "us-central1")
  gcp_zone = get_env("GOOGLE_ZONE", "us-central1-a")
  deploy_stack = get_env("TARGET_ENV", "dev")
}

terraform {
  source = "../../modules/compute"
}

dependency "networking" {
  config_path = "../networking"
  mock_outputs = {
    network_id = "mock-vpc"
    subnet_id  = "mock-subnet"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "show"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

inputs = {
  project_id = "${local.gcp_project_id}"
  region   = "${local.gcp_region}"
  zone     = "${local.gcp_zone}"
  
  network_id           = dependency.networking.outputs.network_id
  subnet_id            = dependency.networking.outputs.subnet_id

  master_target_size   = 1
  worker_target_size   = 1
  bastion_target_size  = 1
  
  master_machine_type  = "n2-standard-2"
  worker_machine_type  = "n2-standard-2"
  bastion_machine_type = "e2-micro"

  ssh_user             = "ubuntu"
  ssh_pub_key          = "YOUR_SSH_PUBLIC_KEY" # TODO: Provide your SSH public key here (e.g. ssh-ed25519 AAA...)
}
