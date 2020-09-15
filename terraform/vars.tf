variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "CIDR" {
  type        = string
  description = "(optional) describe your variable"
  default     = "10.0.0.0/16"
}

variable "AZ" {
  type        = list(string)
  description = "Availability zones."
  default     = ["a", "b", "c"]
}

variable "ENV" {
  type        = string
  description = "Work environment (prod or dev)."
  default     = "dev"
}

variable "PRIVATE_SUBNETS" {
  type        = list(string)
  description = ""
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "PUBLIC_SUBNETS" {
  type        = list(string)
  description = ""
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "INSTANCE_TYPE" {
  type        = string
  description = "Type of the EC2 instance."
  default     = "t2.micro"
}
