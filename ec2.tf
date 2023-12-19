data "aws_ami" "server1_ami" {
  most_recent = true
  filter {
    name   = "description"
    values = ["Amazon Linux 2023 AMI * x86_64 HVM kernel-6.1"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "server1" {
  ami           = data.aws_ami.server1_ami.id
  instance_type = "t2.micro"
  user_data = file("${path.module}/install-ansible.sh")
  availability_zone = var.subnet-availability-zone
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  tags = {
    Name: "server1"
  }
}