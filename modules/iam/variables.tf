variable "project_name" {
  description = "Project or module name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "admin_roles" {
  description = "List of admin roles to create"
  type        = list(string)
  default     = ["terraform-admin"]
}

variable "admin_role_arns" {
  description = "Map of admin role names to their ARNs"
  type        = map(string)
  default     = {
    "terraform-admin" = "arn:aws:iam::111111111111:role/terraform-admin"
  }
}

variable "service_roles" {
  description = "List of service roles to create"
  type        = list(string)
  default     = ["ec2-service-role", "lambda-service-role"]
}

variable "kms_key_arn" {
  description = "ARN of KMS key to attach usage permissions"
  type        = string
}
variable "version" {
  description = "Module version"
  type        = string
  default     = "1.0.0"
}
variable "iam_policy_version" {
  description = "IAM policy JSON version"
  type        = string
  default     = "2012-10-17"
}

variable "admin_policy_effect" {
  description = "Effect for admin IAM policy statements"
  type        = string
  default     = "Allow"
}

variable "admin_policy_actions" {
  description = "List of actions for admin IAM policy statements"
  type        = list(string)
  default     = ["*"]
}

variable "service_policy_effect" {
  description = "Effect for service IAM policy statements"
  type        = string
  default     = "Allow"
}

variable "service_policy_actions" {
  description = "List of actions for service IAM policy statements"
  type        = list(string)
  default     = [
    "kms:Encrypt",
    "kms:Decrypt",
    "kms:GenerateDataKey*"
  ]
variable "admin_policy_resources" {
  description = "Resources for admin IAM policy statements"
  type        = list(string)
  default     = ["*"]
}
variable "service_policy_resources" {
  description = "Resources for service IAM policy statements"
  type        = list(string)
  default     = ["*"] 
}
