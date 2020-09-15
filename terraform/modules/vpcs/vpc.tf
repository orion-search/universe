variable "ENV" {
}

variable "AWS_REGION" {
}

variable "CIDR" {
}

variable "AZ" {
}

variable "PRIVATE_SUBNETS" {
}

variable "PUBLIC_SUBNETS" {
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.ENV}"
  cidr = var.CIDR

  azs             = [for az in var.AZ : "${var.AWS_REGION}${az}"]
  private_subnets = var.PRIVATE_SUBNETS
  public_subnets  = var.PUBLIC_SUBNETS

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.ENV
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}
