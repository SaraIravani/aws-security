variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-project"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
variable "vpc_id" {
  description = "VPC ID where the security groups will be created"
  type        = string
}

variable "security_groups" {
  description = "Map of security groups to create"
  type = map(object({
    description = string
    vpc_id      = string
    tags        = map(string)
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    }))
    egress      = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    }))
  }))
}

