locals {
  ec2_name = "${var.Project_Name}-${var.Environment}"
  database_subnet_id = element(split(",", data.aws_ssm_parameter.database_subnet_id.value), 0) 
  #it will give 1a subnet from 2 subnets list first converts list into string anfd give 1 st element that is 1a region subnet
}