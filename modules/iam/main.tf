# Example: Create IAM roles
resource "aws_iam_role" "admin_roles" {
  for_each = var.admin_role_arns
  name     = "${each.key}-${var.environment}"

  assume_role_policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [{
      Effect   = var.admin_policy_effect
      Principal = {
        AWS = each.value
      }
      Action = "sts:AssumeRole"
    }]
  })

  permissions_boundary = aws_iam_policy.admin_boundary.arn
}

resource "aws_iam_role" "service_roles" {
  for_each = var.service_role_principals
  name     = "${each.key}-${var.environment}"

  assume_role_policy = jsonencode({
    Version = var.iam_policy_version
    Statement = [{
      Effect = var.service_policy_effect
      Principal = {
        Service = each.value  # Adjust for each service
      }
      Action = "sts:AssumeRole"
    }]
  })

  permissions_boundary = aws_iam_policy.service_boundary.arn
}

# Example: Policy for admin boundary
resource "aws_iam_policy" "admin_boundary" {
  name        = "admin-boundary-${var.environment}"
  description = "Permissions boundary for admin roles"
  policy      = jsonencode({
    Version = var.iam_policy_version
    Statement = [{
      Effect   = var.admin_policy_effect
      Action   = var.admin_policy_actions
      Resource = var.admin_policy_resources
    }]
  })
}

# Example: Policy for service boundary (least privilege)
resource "aws_iam_policy" "service_boundary" {
  name        = "service-boundary-${var.environment}"
  description = "Permissions boundary for service roles"
  policy      = jsonencode({
    Version = var.iam_policy_version
    Statement = [
      {
        Effect = var.service_policy_effect
        Action = var.service_policy_actions
        Resource = var.service_policy_resources
      }
    ]
  })
}

