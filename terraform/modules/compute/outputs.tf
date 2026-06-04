output "bastion_mig_self_link" {
  description = "The self-link of the Bastion Managed Instance Group"
  value       = google_compute_instance_group_manager.bastion.self_link
}

output "master_mig_self_link" {
  description = "The self-link of the Master Managed Instance Group"
  value       = google_compute_instance_group_manager.master.self_link
}

output "worker_mig_self_link" {
  description = "The self-link of the Worker Managed Instance Group"
  value       = google_compute_instance_group_manager.worker.self_link
}

# Note: IPs are no longer exported directly as they are managed asynchronously
# by the Instance Groups. Ansible Dynamic Inventory will handle discovering them.
