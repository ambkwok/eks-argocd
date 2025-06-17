############# Provider ############
region             = "us-east-1"
availability_zones = ["us-east-1a", "us-east-1b"]
environment  = "dev"


############# ECR ##########
ecr_repo_name = "react-app"
ecr_force_delete = true


############# VPC ############
vpc_cidr = "10.0.0.0/16"
public_subnet_cidr_blocks = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]
private_subnet_cidr_blocks = [
  "10.0.3.0/24",
  "10.0.4.0/24",
]

############# EKS ############
cluster_name="gitops-eks-app"
cluster_version="1.31"
desired_size = 2
instance_type = "t3.medium"
max_size = 5
min_size = 1
aws_load_balancer_controller_chart_version = "1.11.0"

############# ArgoCD ############
argocd_chart_version = "7.8.27"
