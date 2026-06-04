variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "kubespray-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "kubespray-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.10.0.0/24"
}
