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

