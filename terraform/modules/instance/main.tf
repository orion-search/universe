variable "ENV" {
}

variable "instance_name" {
}

variable "instance_type" {
}

variable "instance_count" {
}

variable "path_to_public_key" {
  default = "my_aws_key.pub"
}

variable "public_subnets" {
}

variable "vpc_id" {
}

variable "sg_id" {
}

# Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

module "ec2" {
  source         = "terraform-aws-modules/ec2-instance/aws"
  ami            = data.aws_ami.amazon-linux-2.id
  name           = "${var.instance_name}-${var.ENV}"
  instance_type  = var.instance_type
  instance_count = var.instance_count
  # VPC subnet
  subnet_id = element(var.public_subnets, 0)
  # Security group ID
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true
  tags = {
    "Terraform" = true
    "ENV"       = var.ENV
  }

}
