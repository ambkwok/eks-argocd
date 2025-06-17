module "ecr" {
  source       = "./modules/ecr"
  name         = var.ecr_repo_name
  force_delete = var.ecr_force_delete
}
