resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.Project_Name}/${var.Environment}/mongodb_sg_id"
  type  = "String"
  value = module.mongodb.sg_id
}

resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.Project_Name}/${var.Environment}/vpn_sg_id"
  type  = "String"
  value = module.vpn.sg_id
}