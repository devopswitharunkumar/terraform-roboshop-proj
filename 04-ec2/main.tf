module "mongodb" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-mongodb"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.small"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "mongodb"
    },
    {
        Name = "${local.ec2_name}-mongodb"
    }
  )
}