#!/bin/bash
set -e

echo "Deploying infrastructure with Terragrunt..."
cd terraform/environments/dev

# Apply networking
cd networking
terragrunt apply -auto-approve
cd ..

# Apply compute
cd compute
terragrunt apply -auto-approve
cd ../../..

echo "Infrastructure deployed. Waiting 30s for SSH to be fully available..."
sleep 30

echo "Deploying Kubernetes with Kubespray..."
# Note: You should have cloned the kubespray repo into a 'kubespray_repo' directory
# and installed its requirements.txt before running this.
# Example: git clone https://github.com/kubernetes-sigs/kubespray.git kubespray_repo

if [ ! -d "kubespray_repo" ]; then
    echo "Warning: kubespray_repo directory not found. Please clone the official kubespray repository:"
    echo "git clone https://github.com/kubernetes-sigs/kubespray.git kubespray_repo"
    exit 1
fi

export ANSIBLE_HOST_KEY_CHECKING=False

# If using a bastion host, you need to configure SSH proxy command
# export ANSIBLE_SSH_ARGS="-o ProxyCommand='ssh -W %h:%p -q ubuntu@<BASTION_IP>'"

ansible-playbook -i kubespray/inventory/inventory.gcp.yml \
                 kubespray_repo/cluster.yml \
                 -b -v \
                 --private-key ~/.ssh/id_rsa # Update with path to your private key
