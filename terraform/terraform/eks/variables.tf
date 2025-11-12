variable "aws_region" { type = string, default = "ap-south-1" }
variable "cluster_name" { type = string, default = "saketh-eks-cluster" }
variable "node_group_name" { type = string, default = "saketh-eks-nodes" }
variable "desired_capacity" { type = number, default = 2 }
variable "min_size" { type = number, default = 1 }
variable "max_size" { type = number, default = 3 }
variable "instance_type" { type = string, default = "t3.medium" }
