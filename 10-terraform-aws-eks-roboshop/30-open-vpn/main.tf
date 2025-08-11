resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  # public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxB0ftRMKCos9caK/gKOAd9tfHQQR4tEvMp+xwz3Bqq Pc@DESKTOP-IVHRL9V"
  # public_key = file("C:\\Users\\Pc\\.ssh\\openvpn.pub") # windows path
  public_key = file("~/.ssh/openvpn.pub") # linux path

}

resource "aws_instance" "vpn" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id = local.public_subnet_id
  key_name = aws_key_pair.openvpn.key_name
  user_data = file("openvpn.sh")

  tags = merge(
    local.common_tags,
    {
    Name = "${var.project}-${var.environment}-vpn"
    }
  )
}

# resource "aws_eip" "vpn" {
#   instance = aws_instance.vpn.id
#   # vpc      = true
#   domain = "vpc"
# }

resource "aws_route53_record" "vpn" {
  zone_id = var.zone_id
  name    = "vpn-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.vpn.public_ip]
  allow_overwrite = true
}