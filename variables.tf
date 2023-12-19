variable "subnet-cidr-block" {
    description = "cidr related to the vpc1"
    default = "10.0.0.0/16"
}
variable "subnet-availability-zone" {
    default ="us-east-1a" 
}
variable "ssh-users-ip" {
    default = ["0.0.0.0/0"]
}
variable "http-users-ip" {
    default = ["0.0.0.0/0"]
}
variable "key_pair" {
    default = "terraform"
}
variable "ec2-location" {
    description = "the region that ec2 place in"
    default = "us-east-1"
}
variable "env-name" {
    description = "environment name"
    default = "dev"
}
variable "vpc-cidr-block" {
    description = "vpc sider"
    default = "10.0.0.0/24" 
}

