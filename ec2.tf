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


resource "aws_key_pair" "ssh-key" {
  key_name = "my-key"
  public_key = file(var.public-key)
}

resource "aws_instance" "my-server" {
  ami           = data.aws_ami.my-server-image.id
  instance_type = "t2.micro"
  user_data = file("${path.module}/install-ansible.sh")
  availability_zone = var.subnet-availability-zone
  key_name = aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = [aws_security_group.my-server-sg.id]
  subnet_id = aws_subnet.my-first-subnet.id
  associate_public_ip_address = true

  tags = {
    Name: "my-server"
  }
}