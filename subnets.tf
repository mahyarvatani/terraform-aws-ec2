resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.subnet-cidr-block
  availability_zone = var.subnet-availability-zone

  tags = {
    Name: "${var.env-name}-subnet"
  }
}
resource "aws_route_table_association" "rtb-to-subnet" {

  route_table_id = aws_route_table.vpc1_rtb.id
  subnet_id = aws_subnet.public_subnet.id
  
}
