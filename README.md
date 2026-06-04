# IaC Kubespray - GCP Infrastructure

This project provides the Terraform (Terragrunt) configuration to provision Google Cloud Platform (GCP) infrastructure for a Kubernetes cluster, which is then configured using [Kubespray](https://kubespray.io/).

## Prerequisites

1.  **GCP Account:** A project ID and credentials configured (`gcloud auth application-default login`).
2.  **Tools installed:**
    *   `terraform` (>= 1.5.0)
    *   `terragrunt`
    *   `ansible`
    *   `google-auth` (for Ansible GCP dynamic inventory plugin: `pip install requests google-auth`)
3.  **Kubespray:** You need to clone the official Kubespray repository.

## Setup Instructions

1.  **Clone Kubespray:**
    ```bash
    git clone https://github.com/kubernetes-sigs/kubespray.git kubespray_repo
    cd kubespray_repo
    pip install -r requirements.txt
    cd ..
    ```

2.  **Configure Variables:**
    Update the `YOUR_PROJECT_ID` placeholders in:
    *   `terraform/environments/dev/networking/terragrunt.hcl`
    *   `terraform/environments/dev/compute/terragrunt.hcl`
    *   `kubespray/inventory/inventory.gcp.yml`

    Update `YOUR_SSH_PUBLIC_KEY` in `terraform/environments/dev/compute/terragrunt.hcl` with the contents of your public key (e.g., `cat ~/.ssh/id_rsa.pub`).

3.  **Deploy Infrastructure (Terraform):**
    You can use the provided script or run commands manually:
    ```bash
    ./scripts/deploy.sh
    ```

4.  **Install Kubernetes (Ansible/Kubespray):**
    The deployment script also contains the ansible command. To run it manually:
    ```bash
    export ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -i kubespray/inventory/inventory.gcp.yml \
                     kubespray_repo/cluster.yml \
                     -b -v \
                     --private-key ~/.ssh/id_rsa
    ```

## Architecture

*   **Networking:** A dedicated VPC, private subnet, and Cloud NAT. Firewalls configured for internal communication and SSH access via IAP or Bastion.
*   **Compute:**
    *   1x Control Plane Node (`n2-standard-2`)
    *   2x Worker Nodes (`n2-standard-4`)
    *   1x Bastion Host (`e2-micro`)
*   **Inventory:** Ansible uses the `google.cloud.gcp_compute` dynamic inventory plugin to find nodes labeled `cluster=kubespray`.
