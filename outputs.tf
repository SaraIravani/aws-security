output "kms_key_arn" {
  description = "ARN of KMS key"
  value       = module.kms.kms_key_arn
}

output "kms_alias_name" {
  description = "Alias of KMS key"
  value       = module.kms.kms_alias_name
}

output "admin_role_arns" {
  description = "Created admin role ARNs"
  value       = module.iam.admin_role_arns
}

output "service_role_arns" {
  description = "Created service role ARNs"
  value       = module.iam.service_role_arns
}

output "security_group_ids" {
  description = "IDs of all created security groups"
  value       = module.security_group.security_group_ids
}

output "security_group_names" {
  description = "Names of all created security groups"
  value       = module.security_group.security_group_names
}

