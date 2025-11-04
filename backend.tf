terraform {
  backend "s3" {
    bucket         = "ops-terraform-state-myorg"
    key            = "aws-security/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "ops-terraform-locks"
    encrypt        = true
    kms_key_id     = var.kms_key_id
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "ops-terraform-state-myorg"
    key            = "network/terraform.tfstate" 
    region         = var.aws_region
    dynamodb_table = "ops-terraform-locks"
    encrypt        = true
    kms_key_id     = var.kms_key_id
  }
}

module "security_group" {
  source          = "../modules/security-group"
  project_name    = var.project_name
  environment     = var.environment
  security_groups = var.security_groups
  vpc_id          = data.terraform_remote_state.network.outputs.vpc_id
}

