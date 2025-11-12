provider "aws" {
  region = var.aws_region
}
terraform {
  backend "s3" {
    bucket         = "infrapipelinejenkins"   # Replace with your S3 bucket name
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
