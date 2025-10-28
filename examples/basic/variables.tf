variable "api_endpoint" {
  description = "API endpoint for the ServerCore provider."
  type        = string
}

variable "api_token" {
  description = "API token used to authenticate with ServerCore."
  type        = string
  sensitive   = true
}

variable "name" {
  description = "Server name."
  type        = string
  default     = "example"
}

variable "project_id" {
  description = "Project identifier for the server."
  type        = string
  default     = null
}

variable "location" {
  description = "Location where the server will be created."
  type        = string
  default     = "us-east"
}

variable "vcpu_count" {
  description = "Number of vCPUs to allocate."
  type        = number
  default     = 2
}

variable "ram_mb" {
  description = "Amount of RAM in MB."
  type        = number
  default     = 4096
}

variable "root_disk_size_gb" {
  description = "Boot disk size in GB."
  type        = number
  default     = 60
}

variable "root_disk_type" {
  description = "Boot disk storage type."
  type        = string
  default     = "ssd"
}

variable "data_disks" {
  description = "Additional disks for the server."
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
  description = "Network interface definitions."
  type = list(object({
    network_id        = string
    subnet_id         = optional(string)
    assign_public_ip  = optional(bool, true)
    security_group_id = optional(string)
    hostname          = optional(string)
    ipv4_address      = optional(string)
  }))
  default = [
    {
      network_id       = ""
      assign_public_ip = true
    }
  ]
}

variable "metadata" {
  description = "Metadata to attach to the server."
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels to assign to the server."
  type        = map(string)
  default     = {}
}

variable "billing_model" {
  description = "Billing model for the server."
  type        = string
  default     = "hourly"
}

variable "auto_renew" {
  description = "Whether to auto renew the server."
  type        = bool
  default     = false
}

variable "backup_plan" {
  description = "Backup plan identifier."
  type        = string
  default     = null
}

variable "power_state" {
  description = "Desired power state after provisioning."
  type        = string
  default     = "running"
}

variable "user_data" {
  description = "User data script to run on boot."
  type        = string
  default     = null
}

variable "ssh_key_ids" {
  description = "SSH key identifiers to authorize on the server."
  type        = list(string)
  default     = []
}
