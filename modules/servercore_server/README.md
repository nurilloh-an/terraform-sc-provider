# ServerCore Server Module

This module provisions a compute instance using the [ServerCore Terraform provider](https://registry.terraform.io/providers/servercore/servercore/latest/docs) and exposes commonly used inputs and outputs for managing the lifecycle of a single virtual machine.

## Usage

```hcl
terraform {
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
  location = "us-east"
}

module "server" {
  source = "../modules/servercore_server"

  name        = "example"
  project_id  = "project-123"
  location    = data.servercore_network.default.location
  image_id    = data.servercore_image.ubuntu.id
  vcpu_count  = 4
  ram_mb      = 8192

  root_disk_size_gb = 80
  root_disk_type    = "ssd"

  data_disks = [
    {
      name        = "data"
      size_gb     = 200
      type        = "ssd"
      auto_delete = true
    }
  ]

  network_interfaces = [
    {
      network_id       = data.servercore_network.default.id
      assign_public_ip = true
    }
  ]

  billing_model = "hourly"
  auto_renew    = false
  power_state   = "running"

  metadata = {
    "owner" = "devops"
  }

  labels = {
    environment = "dev"
  }
}
```

Refer to [examples/basic](../../examples/basic) for a complete configuration that you can adapt to your environment.

## Inputs

See [`variables.tf`](./variables.tf) for the full list of supported inputs.

## Outputs

See [`outputs.tf`](./outputs.tf) for the attributes exported by the module.

## Testing

Run the following commands from the repository root to ensure the configuration is formatted and validates successfully:

```bash
terraform -chdir=examples/basic fmt
terraform -chdir=examples/basic validate
```
