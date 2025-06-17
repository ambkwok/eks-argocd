variable "region" {
  type        = string
  description = "The AWS region where resources will be deployed."
}
variable "environment" {
  description = ""
}


############# ECR ##########
variable "ecr_repo_name" {
  description = "Name of the ECR repository"
}

variable "ecr_force_delete" {
  description = "allow force delete of repository even if it contains images"
}


############# VPC ############
variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}


############# EKS ############
variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cluster_version" {
  description = "Kubernetes <major>.<minor> version to use for the EKS cluster"
}

variable "instance_type" {
  description = "The instance type for the EKS worker nodes."
}

variable "desired_size" {
  description = "Desired number of worker nodes"
}

variable "max_size" {
  description = "Maximum number of worker nodes"
}

variable "min_size" {
  description = "Minimum number of worker nodes"
}

variable "aws_load_balancer_controller_chart_version" {
  description = "aws load balancer controller chart version"
}

############# ArgoCD ############
variable "argocd_chart_version" {
  type        = string
  description = "ArgoCD Helm chart version"
}
