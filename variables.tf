variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ca-central-1"
}

variable "kms_key_id" {
  description = "The KMS Key ARN used for encrypting the Terraform state."
  type        = string
  default     = "arn:aws:kms:ca-central-1:111111111111:key/example"
}

variable "assume_role_arn" {
  description = "IAM role ARN for Terraform to assume"
  type        = string
  default     = "arn:aws:iam::111111111111:role/terraform-deployer"
}

