output "ami_id" {
  description = "image id of server1"
  value = data.aws_ami.server1_ami.id
}

output "ec2_publicip" {
    value = aws_instance.server1.public_ip
}

output "ec2_publicdns" {
    value = aws_instance.server1.public_dns
}

