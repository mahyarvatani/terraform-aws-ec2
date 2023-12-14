variable "env-name" {
    description = "environment name"
    type = string
    default = "dev"
}
variable "vpc-cider-block" {
    description = "vpc sider"
    type = list(string)
    default = [ "10.0.0.0/24" ]
}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc-cider-block

  tags = {
    Name: "${var.env-name}-vpc"
  }
}