variable "sg_name" {
}

variable "vpc_id" {
}

variable "ENV" {
}

module "ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = element(var.sg_name, 0)
  description = "Security group with SSH access."
  vpc_id      = var.vpc_id

  egress_cidr_blocks  = ["0.0.0.0/0"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    "Terraform" = true
    "ENV"       = var.ENV
  }
}
