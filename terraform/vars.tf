variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "ENV" {
  type        = string
  description = "Work environment (prod or dev)."
  default     = "dev"
}

# VPC, subnets and security groups variables
variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones in the region."
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets in a VPC."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets in a VPC."
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "sg_name" {
  type        = list(string)
  description = "Security group names."
  default     = ["ssh-sg", "psql-sg"]
}

# EC2 instance variables
variable "instance_type" {
  type        = string
  description = "EC2 instance type."
  default     = "t2.micro"
}

variable "instance_name" {
  type        = string
  description = "Name of EC2 instance."
  default     = "my-instance"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances."
  default     = 1
}

# DB variables
variable "db_username" {
}

variable "db_password" {
}

variable "backup_retention_period" {
  type        = string
  description = "Days keeping DB backups."
  default     = 0
}

variable "db_name" {
}

variable "db_family" {
  type    = string
  default = "postgres11"
}

variable "major_engine_version" {
  type        = string
  description = "DB Version"
  default     = "11"
}
