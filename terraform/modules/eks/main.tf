
module "eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  enable_irsa     = true

  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  eks_managed_node_group_defaults = {
    instance_type = var.instance_type
  }

  eks_managed_node_groups = {
    node_groups =  {
      min_size     =  var.min_size
      max_size     =  var.max_size
      desired_size =  var.desired_size

    }
  }
}

resource "null_resource" "install-cli" {
  depends_on = [
    module.eks
  ]
  provisioner "local-exec" {
    command = <<-EOF
      apk add aws-cli curl jq nano
      case $(uname -m) in x86_64|amd64) export ARCH=amd64 ;; aarch64|arm64) export ARCH=arm64 ;; esac
      KUBECTL_VERSION=v1.31.0
      curl -L https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/$ARCH/kubectl --output /tmp/kubectl
      chmod +x /tmp/kubectl
      mv /tmp/kubectl /usr/local/bin/kubectl
      ARGOCD_VERSION=v2.14.3
      curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$ARGOCD_VERSION/argocd-linux-$ARCH
      chmod 0755 /usr/local/bin/argocd
    EOF
  }
}
