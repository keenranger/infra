resource "aws_instance" "dev" {
  ami           = "ami-0f3a440bbcff3d043"
  instance_type = "t2.micro"
  tags = {
    Name = "dev-instance"
  }
  availability_zone = "ap-northeast-2a"
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp2"
  }
  key_name = aws_key_pair.dev.key_name
}

resource "aws_key_pair" "dev" {
  key_name   = "dev-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "dev" {
  name        = "dev-sg"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"
  vpc_id      = aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "dev_ssh" {
  security_group_id = aws_security_group.dev.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "dev_http" {
  security_group_id = aws_security_group.dev.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "dev_https" {
  security_group_id = aws_security_group.dev.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

# eip for ec2
resource "aws_eip" "dev" {
  instance   = aws_instance.dev.id
  depends_on = [aws_internet_gateway.default]
}

