
resource "aws_ecr_repository" "ecr" {
  name         = var.name
  force_delete = var.force_delete
}