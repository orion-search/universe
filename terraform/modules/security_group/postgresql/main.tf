variable "sg_name" {
}

variable "vpc_id" {
}

variable "ENV" {
}

module "postgresql_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/postgresql"

  name                     = element(var.sg_name, 1)
  description              = "Security group with PostgreSQL access."
  vpc_id                   = var.vpc_id
  egress_cidr_blocks       = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks  = ["::/0"]
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_ipv6_cidr_blocks = ["::/0"]
  ingress_rules            = ["ssh-tcp", "postgresql-tcp", "all-all"]
  egress_rules             = ["all-all", "postgresql-tcp"]

  tags = {
    "Terraform" = true
    "ENV"       = var.ENV
  }

}
