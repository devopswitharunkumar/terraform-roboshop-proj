module "vpn" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = "${local.ec2_name}-vpn"
  ami           = data.aws_ami.redhat-9-ami-id.id
  instance_type = "t3.small"

  create_security_group = false

  vpc_security_group_ids = [
    data.aws_ssm_parameter.vpn_sg_id.value
  ]

  subnet_id = data.aws_subnet.default_subnet_in_default_vpc.id

user_data = file("${path.module}/openvpn.sh")

user_data_replace_on_change = true

  # user_data                   = file("openvpn.sh")

  tags = merge(
    var.common_tags,
    {
      Component = "vpn"
      Name      = "${local.ec2_name}-vpn"
    }
  )
}


# resource "terraform_data" "download_ovpn" {

#   depends_on = [
#     module.vpn
#   ]

#   triggers_replace = {
#     instance_id = module.vpn.id
#   }

#   provisioner "local-exec" {

#     command = <<EOT
# powershell -NoProfile -Command "$$ip='${module.vpn.public_ip}'; $$key='D:/softwares/keygeneration/devops-sshkey.pem'; $$dest='D:/devopsrepo/ovpn_files'; New-Item -ItemType Directory -Force -Path $$dest | Out-Null; for($$i=1; $$i -le 30; $$i++){ Write-Host ('Attempt ' + $$i + ': Checking OVPN file...'); ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 -i $$key ('ec2-user@' + $$ip) 'test -f /home/ec2-user/arunvpn.ovpn'; if($$LASTEXITCODE -eq 0){ scp -o StrictHostKeyChecking=no -o ConnectTimeout=10 -i $$key ('ec2-user@' + $$ip + ':/home/ec2-user/arunvpn.ovpn') ($$dest + '/arunvpn.ovpn'); if($$LASTEXITCODE -eq 0){ Write-Host 'OVPN downloaded successfully'; exit 0 } }; Write-Host 'OVPN not ready. Waiting 20 seconds...'; Start-Sleep -Seconds 20 }; Write-Error 'OVPN file not available after retry period'; exit 1"
# EOT

#   }
# }