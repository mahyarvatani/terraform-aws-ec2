variable "env-name" {}
variable "vpc-cider-block" {}
variable "subnet-cidr-block" {}
variable "subnet-availability-zone" {}

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



