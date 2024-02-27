resource "aws_vpc" "default" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "default"
  }
}

resource "aws_subnet" "public_2a" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = "ap-northeast-2a"
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}
