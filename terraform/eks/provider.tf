terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }

  backend "s3" {
    bucket = "infrapipelinejenkins"
    key    = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.aws_region
}
