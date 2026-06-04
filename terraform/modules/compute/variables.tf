variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
}

variable "zone" {
  description = "The zone to deploy resources in"
  type        = string
}

variable "network_id" {
  description = "The ID of the VPC network"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "master_target_size" {
  description = "Number of master nodes in the MIG"
  type        = number
  default     = 1
}

variable "worker_target_size" {
  description = "Number of worker nodes in the MIG"
  type        = number
  default     = 1
}

variable "bastion_target_size" {
  description = "Number of bastion nodes in the MIG"
  type        = number
  default     = 1
}

variable "master_machine_type" {
  description = "Machine type for master nodes"
  type        = string
  default     = "n2-standard-2"
}

variable "worker_machine_type" {
  description = "Machine type for worker nodes"
  type        = string
  default     = "n2-standard-4"
}

variable "bastion_machine_type" {
  description = "Machine type for the bastion host"
  type        = string
  default     = "e2-micro"
}

variable "ssh_user" {
  description = "SSH username for provisioning"
  type        = string
  default     = "ubuntu"
}

variable "ssh_pub_key" {
  description = "SSH public key content"
  type        = string
}
