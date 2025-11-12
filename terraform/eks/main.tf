module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.2"

  name = "${var.cluster_name}-vpc"
  cidr = "10.100.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnets = ["10.100.10.0/24", "10.100.11.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

data "aws_availability_zones" "available" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "25.0.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  manage_aws_auth = true

  node_groups = {
    default = {
      desired_capacity = var.desired_capacity
      min_capacity     = var.min_size
      max_capacity     = var.max_size
      instance_types   = [var.instance_type]
    }
  }
}
