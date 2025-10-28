terraform {
  required_version = "~> 1.6.0"

  required_providers {
    servercore = {
      source  = "servercore/servercore"
      version = "~> 0.3.0"
    }
  }
}

provider "servercore" {
  endpoint = var.api_endpoint
  token    = var.api_token
}

data "servercore_image" "ubuntu" {
  slug = "ubuntu-22-04-lts"
}

data "servercore_network" "default" {
  name     = "default"
  location = var.location
}

module "server" {
  source = "../../modules/servercore_server"

  name        = var.name
  project_id  = var.project_id
  location    = data.servercore_network.default.location
  image_id    = data.servercore_image.ubuntu.id
  vcpu_count  = var.vcpu_count
  ram_mb      = var.ram_mb

  root_disk_size_gb = var.root_disk_size_gb
  root_disk_type    = var.root_disk_type

  data_disks = var.data_disks

  network_interfaces = [for ni in var.network_interfaces : merge(ni, {
    network_id = ni.network_id != "" ? ni.network_id : data.servercore_network.default.id
  })]

  metadata      = var.metadata
  labels        = var.labels
  billing_model = var.billing_model
  auto_renew    = var.auto_renew
  backup_plan   = var.backup_plan
  power_state   = var.power_state
  user_data     = var.user_data
  ssh_key_ids   = var.ssh_key_ids
}

output "server_id" {
  value = module.server.server_id
}

output "public_ipv4" {
  value = module.server.public_ipv4
}

output "admin_username" {
  value = module.server.admin_username
}
