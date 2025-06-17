variable "environment" {
  description = ""
}
variable "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
}
variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
}

variable "cluster_name" {
  description = "The name of EKS cluster"
}

variable "aws_load_balancer_controller_version" {
  description = "aws load balancer controller version"
}
