resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = var.argocd_chart_version
  create_namespace = true
  values = [
    file("${path.module}/modules/argocd/helm-values.yaml")
  ]

  depends_on = [
    module.eks-cluster
  ]
}
