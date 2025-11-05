####################################################
# Provider
####################################################
provider "aws" {
  region = var.region
}

####################################################
# KMS Module
####################################################
module "kms" {
  source         = "./modules/kms"
  project_name   = var.project_name
  environment    = var.environment
  admin_role_arns = var.admin_role_arns
  user_role_arns  = var.user_role_arns
  tags           = {
    ManagedBy = "Terraform"
  }
}

####################################################
# IAM Module
####################################################
module "iam" {
  source        = "./modules/iam"
  project_name  = var.project_name
  environment   = var.environment
  kms_key_arn   = module.kms.kms_key_arn
}

####################################################
# Security Group Module
####################################################
module "security_group" {
  source        = "./modules/security-group"
  project_name  = var.project_name
  environment   = var.environment
  security_groups = var.security_groups
}

