include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/compute"
}

dependency "networking" {
  config_path = "../networking"
  mock_outputs = {
    network_id = "mock-vpc"
    subnet_id  = "mock-subnet"
  }
}

inputs = {
  project_id           = "YOUR_PROJECT_ID" # TODO: Update with your GCP Project ID
  region               = "us-central1"
  zone                 = "us-central1-a"
  
  network_id           = dependency.networking.outputs.network_id
  subnet_id            = dependency.networking.outputs.subnet_id

  master_target_size   = 1
  worker_target_size   = 1
  bastion_target_size  = 1
  
  master_machine_type  = "n2-standard-2"
  worker_machine_type  = "n2-standard-4"
  bastion_machine_type = "e2-micro"

  ssh_user             = "ubuntu"
  ssh_pub_key          = "YOUR_SSH_PUBLIC_KEY" # TODO: Provide your SSH public key here (e.g. ssh-ed25519 AAA...)
}
