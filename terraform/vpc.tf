data "aws_availability_zones" "azs" {}
module "dev-vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.4.0"
  name            = "dev-vpc"
  cidr            = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks
  azs             = data.aws_availability_zones.azs.names

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/demo-eks-cluster" = "shared"
  }

}