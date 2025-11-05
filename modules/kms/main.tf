####################################################
# KMS Key
####################################################
resource "aws_kms_key" "main" {
  description             = "Main encryption key for ${var.project_name} in ${var.environment}"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_key_policy.json

  tags = merge(var.tags, {
    Name        = local.key_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = var.project_name
  })
}

####################################################
# KMS Alias
####################################################
resource "aws_kms_alias" "main" {
  name          = "alias/${local.key_name}"
  target_key_id = aws_kms_key.main.key_id
}

