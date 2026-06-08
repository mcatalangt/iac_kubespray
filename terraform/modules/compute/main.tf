data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

# ------------------------------------------------------------------------------
# Bastion Host
# ------------------------------------------------------------------------------
resource "google_compute_instance_template" "bastion" {
  name_prefix  = "bastion-template-"
  project      = var.project_id
  machine_type = var.bastion_machine_type
  region       = var.region

  disk {
    source_image = data.google_compute_image.ubuntu.self_link
    auto_delete  = true
    boot         = true
    disk_size_gb = 20
    disk_type    = "pd-standard"
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_id

    # Ephemeral public IP for the bastion
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_pub_key}"
  }

  tags = ["bastion"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "bastion" {
  name               = "bastion-mig"
  project            = var.project_id
  zone               = var.zone
  base_instance_name = "bastion"
  target_size        = var.bastion_target_size

  version {
    instance_template = google_compute_instance_template.bastion.id
    name              = "primary"
  }
}

# ------------------------------------------------------------------------------
# Master Nodes (Control Plane)
# ------------------------------------------------------------------------------
resource "google_compute_instance_template" "master" {
  name_prefix  = "master-template-"
  project      = var.project_id
  machine_type = var.master_machine_type
  region       = var.region

  disk {
    source_image = data.google_compute_image.ubuntu.self_link
    auto_delete  = true
    boot         = true
    disk_size_gb = 20
    disk_type    = "pd-standard"
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_id
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_pub_key}"
  }

  labels = {
    cluster = "kubespray"
    role    = "control-plane"
  }

  tags = ["kubernetes", "master"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "master" {
  name               = "master-mig"
  project            = var.project_id
  zone               = var.zone
  base_instance_name = "master"
  target_size        = var.master_target_size

  version {
    instance_template = google_compute_instance_template.master.id
    name              = "primary"
  }
}

# ------------------------------------------------------------------------------
# Worker Nodes
# ------------------------------------------------------------------------------
resource "google_compute_instance_template" "worker" {
  name_prefix  = "worker-template-"
  project      = var.project_id
  machine_type = var.worker_machine_type
  region       = var.region

  disk {
    source_image = data.google_compute_image.ubuntu.self_link
    auto_delete  = true
    boot         = true
    disk_size_gb = 20
    disk_type    = "pd-standard"
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_id
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_pub_key}"
  }

  labels = {
    cluster = "kubespray"
    role    = "worker"
  }

  tags = ["kubernetes", "worker"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "worker" {
  name               = "worker-mig"
  project            = var.project_id
  zone               = var.zone
  base_instance_name = "worker"
  target_size        = var.worker_target_size

  version {
    instance_template = google_compute_instance_template.worker.id
    name              = "primary"
  }
}
