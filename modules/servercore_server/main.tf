resource "servercore_server" "this" {
  name        = var.name
  description = var.description

  project_id = var.project_id
  location   = var.location

  image_id   = var.image_id
  image_name = var.image_name

  flavor {
    vcpu_count = var.vcpu_count
    ram_mb     = var.ram_mb
  }

  storage_profile {
    root_disk_size_gb = var.root_disk_size_gb
    root_disk_type    = var.root_disk_type

    dynamic "data_disks" {
      for_each = var.data_disks
      content {
        name        = data_disks.value.name
        size_gb     = data_disks.value.size_gb
        type        = data_disks.value.type
        iops        = data_disks.value.iops
        throughput  = data_disks.value.throughput
        auto_delete = data_disks.value.auto_delete
      }
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interfaces
    content {
      network_id        = network_interface.value.network_id
      subnet_id         = network_interface.value.subnet_id
      assign_public_ip  = network_interface.value.assign_public_ip
      security_group_id = network_interface.value.security_group_id
      hostname          = network_interface.value.hostname
      ipv4_address      = network_interface.value.ipv4_address
    }
  }

  metadata = var.metadata
  labels   = var.labels

  billing {
    model       = var.billing_model
    auto_renew  = var.auto_renew
    backup_plan = var.backup_plan
  }

  power_state = var.power_state
  user_data   = var.user_data
  ssh_key_ids = var.ssh_key_ids
}
