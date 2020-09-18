output "sg_name" {
  description = "Security group name."
  value       = module.postgresql_security_group.this_security_group_name
}

output "sg_id" {
  description = "Security group id."
  value       = module.postgresql_security_group.this_security_group_id
}
