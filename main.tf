variable "env-name" {}
variable "vpc-cider-block" {}
variable "subnet-cidr-block" {}
variable "subnet-availability-zone" {}
variable "ssh-users-ip" {}
variable "http-users-ip" {}
variable "public-key" {}

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

resource "aws_security_group" "my-server-sg" {
  name        = "my-server-sg"
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
    Name = "my-server-sg"
  }
}

data "aws_ami" "my-server-image" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "description"
    values = ["Amazon Linux 2*"]
  }

  filter {
    name   = "description"
    values = ["Amazon Linux 2 Kernel*x86_64 HVM gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "my_server_image_id" {
  value       = data.aws_ami.my-server-image.id
}

resource "aws_key_pair" "ssh-key" {
  key_name = "my-key"
  public_key = file(var.public-key)
}

resource "aws_instance" "my-server" {
  ami           = data.aws_ami.my-server-image.id
  instance_type = "t2.micro"
  availability_zone = var.subnet-availability-zone
  key_name = aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = [aws_security_group.my-server-sg.id]
  subnet_id = aws_subnet.my-first-subnet.id
  associate_public_ip_address = true

  tags = {
    Name: "my-server"
  }
}

output "my-server-public-ip" {
  value = ["${aws_instance.my-server.public_ip}"]
}