module "alb" {
  source = "./modules/alb"

  cluster_name            = local.cluster_name
  environment             = var.environment
  oidc_provider_arn       = module.eks-cluster.oidc_provider_arn
  cluster_oidc_issuer_url = module.eks-cluster.cluster_oidc_issuer_url
  aws_load_balancer_controller_version = var.aws_load_balancer_controller_chart_version

  depends_on   = [
    module.eks-cluster
  ]
}
