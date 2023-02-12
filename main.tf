variable "env-name" {}
variable "vpc-cider-block" {}
variable "subnet-cidr-block" {}
variable "subnet-availability-zone" {}
variable "ssh-users-ip" {}
variable "http-users-ip" {}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc-cider-block

  tags = {
    Name: "${var.env-name}-vpc"
  }
}

resource "aws_subnet" "my-first-subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.subnet-cidr-block
  availability_zone = var.subnet-availability-zone

  tags = {
    Name: "${var.env-name}-subnet"
  }
}

resource "aws_internet_gateway" "my-vpc-igw" {

  vpc_id = aws_vpc.my-vpc.id
  tags ={
    Name: "${var.env-name}-igw"
  }
  
}

resource "aws_route_table" "my-vpc-rtb" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-vpc-igw.id
  }
}

resource "aws_route_table_association" "rtb-to-subnet" {

  route_table_id = aws_route_table.my-vpc-rtb.id
  subnet_id = aws_subnet.my-first-subnet.id
  
}

resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.ssh-users-ip]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [var.http-users-ip]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}

