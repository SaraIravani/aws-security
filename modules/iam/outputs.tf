# modules/iam/outputs.tf

output "admin_role_arns" {
  description = "ARNs of created admin roles"
  value       = { for k, r in aws_iam_role.admin_roles : k => r.arn }
}

output "service_role_arns" {
  description = "ARNs of created service roles"
  value       = { for k, r in aws_iam_role.service_roles : k => r.arn }
}

output "admin_policy_arn" {
  description = "ARN of admin permissions boundary policy"
  value       = aws_iam_policy.admin_boundary.arn
}

output "service_policy_arn" {
  description = "ARN of service permissions boundary policy"
  value       = aws_iam_policy.service_boundary.arn
}

