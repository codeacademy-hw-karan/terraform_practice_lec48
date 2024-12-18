# outputs.tf
output "public_ips" {
  description = "The public IP addresses of the created virtual machines"
  value       = azurerm_public_ip.pip[*].ip_address
}
