output "ami_id" {
  description = "image id of server1"
  value = aws_ami.server1_ami.id
}

output "ec2_publicip" {
    value = aws_instance.my-server.public_ip
}

output "ec2_publicdns" {
    value = aws_instance.my-server.public_dns
}

