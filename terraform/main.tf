# Create a VPC
module "vpc" {
  source          = "./modules/vpc"
  ENV             = var.ENV
  cidr            = var.cidr
  AWS_REGION      = var.AWS_REGION
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Create security groups
module "ssh_sg" {
  source  = "./modules/security_group/ssh"
  sg_name = var.sg_name
  vpc_id  = module.vpc.vpc_id
  ENV     = var.ENV
}

module "postgres_sg" {
  source  = "./modules/security_group/postgresql"
  sg_name = var.sg_name
  vpc_id  = module.vpc.vpc_id
  ENV     = var.ENV
}

# Create a postgresql db
module "db" {
  source                  = "./modules/rds"
  ENV                     = var.ENV
  db_username             = var.db_username
  db_password             = var.db_password
  database_subnets        = module.vpc.database_subnets
  sg                      = module.postgres_sg.sg_id
  backup_retention_period = var.backup_retention_period
  db_family               = var.db_family
  major_engine_version    = var.major_engine_version
  db_name                 = var.db_name

}

# Provision an EC2 instance associated with a VPC
module "ec2" {
  source         = "./modules/instance/"
  ENV            = var.ENV
  instance_name  = var.instance_name
  instance_type  = var.instance_type
  instance_count = var.instance_count
  public_subnets = module.vpc.public_subnets
  vpc_id         = module.vpc.vpc_id
  sg_id          = module.ssh_sg.sg_id

}

# Create an ElasticIP within VPC and allocate it to the EC2 instance
resource "aws_eip" "lb" {
  instance = element(module.ec2.id, 0)
  vpc      = true
  tags = {
    "name" = "test-eip"
  }
}

# Root module outputs
output "ssh_sg" {
  value = module.ssh_sg
}

output "vpc" {
  value = module.vpc
}

output "ec2" {
  value = module.ec2
}

output "postgres_sg" {
  value = module.postgres_sg
}

output "db" {
  value = module.db
}
