output "server_id" {
  description = "Identifier of the provisioned server."
  value       = servercore_server.this.id
}

output "public_ipv4" {
  description = "Public IPv4 address assigned to the server, if any."
  value       = servercore_server.this.public_ipv4
}

output "private_ipv4" {
  description = "Primary private IPv4 address of the server."
  value       = servercore_server.this.private_ipv4
}

output "admin_username" {
  description = "Administrative username that can be used to access the server."
  value       = servercore_server.this.admin_username
}

output "admin_password" {
  description = "Administrative password generated for the server, when applicable."
  sensitive   = true
  value       = servercore_server.this.admin_password
}
