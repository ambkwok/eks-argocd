variable "vpc_name" {
  description = "Name of the VPC"
  type = string
}

variable "environment" {
  type = string
  description = "Environment either staging or Prod"
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type = string
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type = list(string)
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type = list(string)
}


variable "cluster_name" {
  description = "The name of EKS cluster"
}
