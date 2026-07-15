data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.Project_Name}/${var.Environment}/mongodb_sg_id"
}

data "aws_ssm_parameter" "database_subnet_id" {
  name = "/${var.Project_Name}/${var.Environment}/database_subnet_id"
}

data "aws_ami" "redhat-9-ami-id" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"] #if vale randomlyy changes we can give like ["Redhat-9-DevOps-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}