# variable "name" {

# }

# variable "ENV" {
# }

# variable "AWS_REGION" {
# }

# variable "cidr" {
# }

# variable "availability_zones" {
# }

# variable "private_subnets" {
# }

# variable "public_subnets" {
# }

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "vpc-${var.ENV}"
#   cidr = var.cidr

#   azs = [for sub_region in var.availability_zones : "${var.AWS_REGION}${sub_region}"]

#   private_subnets = var.private_subnets
#   public_subnets  = var.public_subnets

#   enable_nat_gateway = false
#   enable_vpn_gateway = false

#   tags = {
#     Terraform   = "true"
#     Environment = var.ENV
#   }

# }

# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = module.aws-vpc.vpc_id
# }

# output "private_subnets" {
#   description = "List of IDs of private subnets"
#   value       = module.aws-vpc.private_subnets
# }

# output "public_subnets" {
#   description = "List of IDs of public subnets"
#   value       = module.aws-vpc.public_subnets
# }
