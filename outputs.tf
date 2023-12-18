output "ec2_publicip" {
    value = aws_instance.my-server.public_ip
}

output "ec2_publicdns" {
    value = aws_instance.my-server.public_dns
}

output "my_server_image_id" {
  value       = data.aws_ami.my-server-image.id
}
output "my-server-public-ip" {
  value = ["${aws_instance.my-server.public_ip}"]
}