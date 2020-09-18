variable "ENV" {
}

variable "AWS_REGION" {
}

variable "cidr" {
}

variable "azs" {
}

variable "private_subnets" {
}

variable "public_subnets" {
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.ENV}"

  cidr             = var.cidr
  azs              = [for az in var.azs : "${var.AWS_REGION}${az}"]
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = ["10.0.107.0/24", "10.0.106.0/24", "10.0.105.0/24"]
  # Enable DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  create_database_subnet_route_table = true
  create_database_subnet_group       = true

  tags = {
    Terraform   = "true"
    Environment = var.ENV
  }
}
