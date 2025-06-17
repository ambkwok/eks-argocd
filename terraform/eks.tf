module "eks-cluster" {
  source = "./modules/eks"
  cluster_name       = local.cluster_name
  cluster_version    = var.cluster_version
  desired_size       = var.desired_size
  instance_type      = var.instance_type
  max_size           = var.max_size
  min_size           = var.min_size
  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id

  depends_on = [
    module.vpc
  ]
}
