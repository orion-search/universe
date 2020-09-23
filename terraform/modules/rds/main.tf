variable "ENV" {
}

variable "db_username" {
}

variable "db_password" {
}

variable "sg" {
  description = "Security group."
}

variable "database_subnets" {
}

variable "backup_retention_period" {
}

variable "db_name" {
}

variable "db_family" {
}

variable "major_engine_version" {
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb-postgres"

  engine            = "postgres"
  engine_version    = "11.5"
  instance_class    = "db.t2.micro"
  allocated_storage = 10
  storage_encrypted = false

  name     = var.db_name
  username = var.db_username
  password = var.db_password
  port     = "5432"

  # Security group
  vpc_security_group_ids = [var.sg]

  # Subnets
  subnet_ids = var.database_subnets

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = var.backup_retention_period

  # DB parameter group
  family = var.db_family

  # DB option group
  major_engine_version = var.major_engine_version

  # Database Deletion Protection
  deletion_protection = false

  publicly_accessible = true

  tags = {
    "Terraform" = true
    "Owner"     = "Orion"
    "ENV"       = var.ENV
  }

}
