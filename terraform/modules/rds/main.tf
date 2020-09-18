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

# variable "db_name" {
# }

# data "aws_subnet_ids" "all" {
#   vpc_id = data.aws_vpc.default.id
# }

# data "aws_security_group" "default" {
#   vpc_id = data.aws_vpc.default.id
#   name   = "default"
# }

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb-postgres"

  engine            = "postgres"
  engine_version    = "11.5"
  instance_class    = "db.t2.micro"
  allocated_storage = 10
  storage_encrypted = false

  name     = "demodb"
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
  backup_retention_period = 0

  # DB parameter group
  family = "postgres11"

  # DB option group
  major_engine_version = "11"

  # Database Deletion Protection
  deletion_protection = false

  tags = {
    "Terraform" = true
    "Owner"     = "Orion"
    "ENV"       = var.ENV
  }

}
