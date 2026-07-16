#Database related EC2 instance code
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


module "redis" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-redis"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "redis"
    },
    {
        Name = "${local.ec2_name}-redis"
    }
  )
}

module "mysql" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-mysql"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.small"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "mysql"
    },
    {
        Name = "${local.ec2_name}-mysql"
    }
  )
}

module "rabbitmq" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-rabbitmq"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id = local.database_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "rabbitmq"
    },
    {
        Name = "${local.ec2_name}-rabbitmq"
    }
  )
}




#Application related EC2 instance code

module "catalogue" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-catalogue"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
  subnet_id = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "catalogue"
    },
    {
        Name = "${local.ec2_name}-catalogue"
    }
  )
}

module "cart" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-cart"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.cart_sg_id.value]
  subnet_id = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "cart"
    },
    {
        Name = "${local.ec2_name}-cart"
    }
  )
}

module "user" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-user"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.user_sg_id.value]
  subnet_id = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "user"
    },
    {
        Name = "${local.ec2_name}-user"
    }
  )
}

module "shipping" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-shipping"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.small"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.shipping_sg_id.value]
  subnet_id = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "shipping"
    },
    {
        Name = "${local.ec2_name}-shipping"
    }
  )
}

module "payment" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-payment"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.payment_sg_id.value]
  subnet_id = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "payment"
    },
    {
        Name = "${local.ec2_name}-payment"
    }
  )
}


module "web" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-web"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]
  subnet_id = local.public_subnet_id

  tags = merge(
    var.common_tags,
    {
        Component = "web"
    },
    {
        Name = "${local.ec2_name}-web"
    }
  )
}







resource "aws_route53_record" "records" {
  for_each = local.dns_records

  zone_id = data.aws_route53_zone.domain_zone_id.id
  name    = "${each.key}.${var.zone_name}"
  type    = "A"
  ttl     = 1

  records = [each.value]
}







module "ansible" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.ec2_name}-ansible"
  ami = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.micro"
  
  create_security_group = false # this resource creating egress sg extra for that not to create we used this it will not create new sg if false 

  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value] #same port for ansible also so we are using same sg for vpn and ansible
  subnet_id = data.aws_subnet.default_subnet_in_default_vpc.id  #default vpc 1a region subnet

  user_data = file("ec2-provision-ansible-playbooks.sh")
 
  tags = merge(
    var.common_tags,
    {
        Component = "ansible"
    },
    {
        Name = "${local.ec2_name}-ansible"
    }
  )
}


