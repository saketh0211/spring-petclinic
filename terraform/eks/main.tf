# -----------------------------
# DATA SOURCE
# -----------------------------
data "aws_availability_zones" "available" {}

# -----------------------------
# VPC MODULE
# -----------------------------
module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "6.5.0"
  name                = "${var.cluster_name}-vpc"
  cidr                = "10.0.0.0/16"
  azs                 = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway  = true
  single_nat_gateway  = true
}

# -----------------------------
# EKS MODULE
# -----------------------------
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.8.0"

  name                 = var.cluster_name
  kubernetes_version   = "1.29"
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_subnets
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {
    default = {
      name           = "saketh-nodes"
      desired_size   = var.desired_capacity
      min_size       = var.min_size
      max_size       = var.max_size
      instance_types = [var.instance_type]
      capacity_type  = "ON_DEMAND"
    }
  }
  tags = {
    Environment = "dev"
    Project     = "petclinic"
  }
}


