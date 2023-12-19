resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc-cidr-block

  tags = {
    Name: "${var.env-name}-vpc"
  }
}
resource "aws_internet_gateway" "igw1" {

  vpc_id = aws_vpc.vpc1.id
  tags ={
    Name: "${var.env-name}-igw"
  }
  
}
resource "aws_route_table" "vpc1_rtb" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }
}
resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ssh-users-ip
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = var.http-users-ip
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}