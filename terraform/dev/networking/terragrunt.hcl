include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/networking"
}

inputs = {
  project_id   = "YOUR_PROJECT_ID" # TODO: Update with your GCP Project ID
  region       = "us-central1"
  network_name = "kubespray-vpc"
  subnet_name  = "kubespray-subnet"
  subnet_cidr  = "10.10.0.0/24"
}
