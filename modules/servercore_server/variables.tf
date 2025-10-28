variable "name" {
  description = "Human-readable name to assign to the server."
  type        = string
}

variable "description" {
  description = "Optional description or notes for the server."
  type        = string
  default     = ""
}

variable "project_id" {
  description = "Identifier of the project or tenant that owns the server."
  type        = string
  default     = null
}

variable "location" {
  description = "Region or data center identifier where the server should be provisioned."
  type        = string
}

variable "image_id" {
  description = "Identifier of the operating system image to boot the server from."
  type        = string
  default     = null
}

variable "image_name" {
  description = "Name or slug of the operating system image to boot the server from when the ID is not known."
  type        = string
  default     = null
}

variable "vcpu_count" {
  description = "Number of virtual CPUs to allocate to the server."
  type        = number
  validation {
    condition     = var.vcpu_count > 0
    error_message = "vcpu_count must be greater than zero."
  }
}

variable "ram_mb" {
  description = "Amount of RAM in megabytes to allocate to the server."
  type        = number
  validation {
    condition     = var.ram_mb >= 1024
    error_message = "ram_mb must be at least 1024 MB."
  }
}

variable "root_disk_size_gb" {
  description = "Size in gigabytes of the boot disk."
  type        = number
  validation {
    condition     = var.root_disk_size_gb >= 10
    error_message = "root_disk_size_gb must be at least 10 GB."
  }
}

variable "root_disk_type" {
  description = "Storage class for the boot disk."
  type        = string
  default     = "ssd"
  validation {
    condition     = contains(["ssd", "hdd", "nvme"], lower(var.root_disk_type))
    error_message = "root_disk_type must be one of ssd, hdd, or nvme."
  }
}

variable "data_disks" {
  description = "Additional data disks to attach to the server."
  type = list(object({
    name        = string
    size_gb     = number
    type        = optional(string, "ssd")
    iops        = optional(number)
    throughput  = optional(number)
    auto_delete = optional(bool, true)
  }))
  default = []
}

variable "network_interfaces" {
  description = "Network interfaces to attach to the server."
  type = list(object({
    network_id        = string
    subnet_id         = optional(string)
    assign_public_ip  = optional(bool, true)
    security_group_id = optional(string)
    hostname          = optional(string)
    ipv4_address      = optional(string)
  }))
  validation {
    condition     = length(var.network_interfaces) > 0
    error_message = "At least one network interface must be specified."
  }
}

variable "metadata" {
  description = "Arbitrary key/value metadata to associate with the server."
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels or tags to associate with the server."
  type        = map(string)
  default     = {}
}

variable "billing_model" {
  description = "Billing plan to use for the server."
  type        = string
  default     = "hourly"
  validation {
    condition     = contains(["hourly", "monthly", "reserved"], lower(var.billing_model))
    error_message = "billing_model must be one of hourly, monthly, or reserved."
  }
}

variable "auto_renew" {
  description = "Whether to automatically renew the server when using a subscription-based billing model."
  type        = bool
  default     = true
}

variable "backup_plan" {
  description = "Identifier of the backup plan to apply to the server."
  type        = string
  default     = null
}

variable "power_state" {
  description = "Desired power state for the server after provisioning."
  type        = string
  default     = "running"
  validation {
    condition     = contains(["running", "stopped", "suspended"], lower(var.power_state))
    error_message = "power_state must be one of running, stopped, or suspended."
  }
}

variable "user_data" {
  description = "Cloud-init or other user data to provide to the server on boot."
  type        = string
  default     = null
}

variable "ssh_key_ids" {
  description = "List of SSH key identifiers to inject into the server."
  type        = list(string)
  default     = []
}
