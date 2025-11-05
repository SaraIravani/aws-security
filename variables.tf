####################################################
# Project & Environment
####################################################
variable "project_name" {
  description = "Project name for all resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ca-central-1"
}

####################################################
# IAM & KMS
####################################################
variable "admin_role_arns" {
  description = "List of IAM role ARNs that can fully manage the KMS key"
  type        = list(string)
}

variable "user_role_arns" {
  description = "List of IAM role ARNs that can use (encrypt/decrypt) the KMS key"
  type        = list(string)
}

variable "kms_key_id" {
  description = "The KMS Key ARN used for encrypting Terraform state (optional, can use module output)"
  type        = string
  default     = "arn:aws:kms:ca-central-1:111111111111:key/example"
}

variable "assume_role_arn" {
  description = "IAM role ARN for Terraform to assume"
  type        = string
  default     = "arn:aws:iam::111111111111:role/terraform-deployer"
}

####################################################
# Security Groups
####################################################
variable "security_groups" {
  description = "Map of security groups to create"
  type = map(object({
    vpc_id      = string
    description = string
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    }))
    tags = optional(map(string), {})
  }))
}

