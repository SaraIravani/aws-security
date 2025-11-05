variable "project_name" {
  description = "Project or module name"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "admin_role_arns" {
  description = "List of IAM role ARNs that can fully manage the KMS key"
  type        = list(string)
}

variable "user_role_arns" {
  description = "List of IAM role ARNs that can use (encrypt/decrypt) the KMS key"
  type        = list(string)
}

variable "tags" {
  description = "Optional tags to apply to the KMS key"
  type        = map(string)
  default     = {}
}

