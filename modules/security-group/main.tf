####################################################
# Security Groups
####################################################
#################***Single VPC*****#################
resource "aws_security_group" "this" {
  for_each   = var.security_groups
  name       = "${var.project_name}-${each.key}-${var.environment}"
  description = each.value.description
  vpc_id     = var.vpc_id

  tags = merge(each.value.tags, {
    Name        = "${var.project_name}-${each.key}-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = var.project_name
  })
}
##################**Multi-VPC**####################
#resource "aws_security_group" "this" {
#  for_each = var.security_groups 
#
#  name        = "${var.project_name}-${each.key}-${var.environment}"
#  description = each.value.description
#  vpc_id      = each.value.vpc_id
#
#  tags = merge(each.value.tags, {
#    Name        = "${var.project_name}-${each.key}-${var.environment}"
#    Environment = var.environment
#    ManagedBy   = "Terraform"
#    Project     = var.project_name
#  })
#}
#########***Single VPC AND Multi-VPC***############
##resource "aws_security_group" "this" {
#  for_each = var.multi_vpc ? var.security_groups : {
#    "default" = var.security_groups["default"]  
#}
#
#  name        = "${var.project_name}-${each.key}-${var.environment}"
#  description = each.value.description
#  vpc_id      = each.value.vpc_id
#
#  tags = merge(each.value.tags, {
#    Name        = "${var.project_name}-${each.key}-${var.environment}"
#    Environment = var.environment
#    ManagedBy   = "Terraform"
#  })
#}


####################################################
# Flattened Ingress Rules
####################################################
locals {
  ingress_rules = flatten([
    for sg_name, sg in var.security_groups : [
      for r in sg.ingress :
           merge(r, { sg_name = sg_name })
    ]
  ])

  egress_rules = flatten([
    for sg_name, sg in var.security_groups : [
      for r in sg.egress : 
          merge(r, { sg_name = sg_name })
    ]
  ])
}

####################################################
# Ingress Rules
####################################################
resource "aws_security_group_rule" "ingress" {
  for_each = {
  for rule in local.ingress_rules :
           "${rule.sg_name}-${rule.from_port}-${rule.to_port}-${rule.protocol}-${replace(join("-", tolist(rule.cidr_blocks)), "/", "_")}" => rule
  }
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.this[each.value.sg_name].id
  description       = lookup(each.value, "description", "Ingress rule for ${each.value.sg_name}")
}

####################################################
# Egress Rules
####################################################
resource "aws_security_group_rule" "egress" {
  for_each = {
    for rule in local.egress_rules :
               "${rule.sg_name}-${rule.from_port}-${rule.to_port}-${rule.protocol}-${replace(join("-", tolist(rule.cidr_blocks)), "/", "_")}" => rule
  }

  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.this[each.value.sg_name].id
  description       = lookup(each.value, "description", "Egress rule for ${each.value.sg_name}")
}

