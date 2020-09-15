module "vpc" {
  source          = "./modules/vpcs/"
  ENV             = var.ENV
  AWS_REGION      = var.AWS_REGION
  CIDR            = var.CIDR
  AZ              = var.AZ
  PUBLIC_SUBNETS  = var.PUBLIC_SUBNETS
  PRIVATE_SUBNETS = var.PRIVATE_SUBNETS
}

module "instances" {
  source         = "./modules/instances/"
  ENV            = var.ENV
  INSTANCE_TYPE  = var.INSTANCE_TYPE
  VPC_ID         = module.vpc.vpc_id
  PUBLIC_SUBNETS = module.vpc.public_subnets
}

resource "aws_eip" "lb" {
  instance = module.instances.instance_id
  vpc      = true
  tags = {
    "name" = "test-eip"
  }
}
