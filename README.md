# eks-argocd

## Overview

This repository demonstrate a dockerized application automated deployment with the combination of below DevOps tools:

- **GitHub Actions** for CI/CD pipelines
- **Terraform** for infrastructure management
- **Amazon EKS** for running scalable Kubernetes applications
- **ArgoCD** for application deployment and synchronization

## Steps

1. Provision AWS resources (VPC, EKS, ALB, and ArgoCD) with Terraform
2. Prepare the Dockerized application for deployment
3. Setup GitHub Actions for CI - build the Docker image and push to ECR
4. Configure ArgoCD for CD - application deployment and synchronization
5. Push changes to GitHub - trigger CI/CD pipelines

## Contents in this repository

- **Terraform** for setting up AWS resources and deploy ArgoCD with IaC
- **Kubernetes manifests** for deploying and configuring the application
- **GitHub Actions workflow** for setting up CI/CD pipeline
- **Application Source Code** for building web application

## Quick started

```bash
docker compose run -it --rm aws configure
docker compose run -it --rm aws s3api create-bucket --bucket terraform-bucket --region us-east-1
docker compose run -it --rm aws s3api create-bucket --bucket gitops-terraform-bucket --region us-east-1

docker compose run -it --rm terraform sh
terraform init
terraform plan
terraform apply -auto-approve
aws eks update-kubeconfig --name gitops-eks-app --region us-east-1
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get -n argocd svc


pkill -f "kubectl port-forward svc/argocd-server" || true
kubectl port-forward svc/argocd-server -n argocd 8080:80 2>&1 >/dev/null &
sleep 5
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd login --username admin --password ${ARGOCD_PASSWORD} --grpc-web --plaintext 127.0.0.1:8080
kubectl config set-context --current --namespace=argocd

source .env && curl -s ${BOOTSTRAP_SCRIPT_URL} | sh

kubectl get -A svc
kubectl get -A ingress

argocd app delete all-apps
terraform destroy -auto-approve
```

## Create Secrets in Github

```text
AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, ECR_REPOSITORY
```
