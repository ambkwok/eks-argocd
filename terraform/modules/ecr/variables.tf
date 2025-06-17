variable "name" {
    description = "Name of the ECR repository"
}

variable "force_delete" {
    description = "allow force delete of repository even if it contains images"
    default = false
}
