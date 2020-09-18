output "az" {
  description = "Availability zones"
  value       = module.db.this_db_instance_availability_zone
}

output "subnet_group_id" {
  value = module.db.this_db_subnet_group_id
}

output "db_instance_name" {
  value = module.db.this_db_instance_name
}

output "id" {
  value = module.db.this_db_instance_id
}

output "parameter_group_id" {
  value = module.db.this_db_parameter_group_id
}
