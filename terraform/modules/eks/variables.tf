variable "cluster_name" {
  description = "Name of the EKS cluster"
}
variable "cluster_version" {
  description = "Kubernetes <major>.<minor> version to use for the EKS cluster"
}
variable "subnet_ids" {
  description = "A list of subnet IDs where the nodes/node groups will be provisioned"
}
variable "vpc_id" {
  description = "ID of the VPC where the cluster security group will be provisioned"
}
variable "instance_type" {
  description = "Instance type to use for the instances in the EKS cluster"
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
