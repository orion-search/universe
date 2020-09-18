output "id" {
  value = module.ec2.id
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = module.ec2.public_dns
}

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = module.ec2.public_ip
}
