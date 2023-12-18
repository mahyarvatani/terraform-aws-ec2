variable "subnet-cidr-block" {}
variable "subnet-availability-zone" {}
variable "ssh-users-ip" {}
variable "http-users-ip" {}
variable "public-key" {}
variable "ec2-location" {
    description = "the region that ec2 place in"
    type = string
    default = "us-east-1"
}
variable "env-name" {
    description = "environment name"
    type = string
    default = "dev"
}
variable "vpc-cider-block" {
    description = "vpc sider"
    default = [ "10.0.0.0/24" ]
}

