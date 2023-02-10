resource "aws_instance" "web" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name      = "mhv"
  tags = {
    Name = "web"
    Created_by = "terraform"
  }
}