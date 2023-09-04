resource "aws_vpc" "cloudtutorial_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "cloudtutorial-vpc"
  }
}

resource "aws_subnet" "cloudtutorial_subnet_1" {
  vpc_id                  = aws_vpc.cloudtutorial_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 0)
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudtutorial-subnet-1"
  }
}

resource "aws_subnet" "cloudtutorial_subnet_2" {
  vpc_id                  = aws_vpc.cloudtutorial_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudtutorial-subnet-2"
  }
}

resource "aws_internet_gateway" "cloudtutorial_igw" {
  vpc_id = aws_vpc.cloudtutorial_vpc.id

  tags = {
    Name = "cloudtutorial-igw"
  }
}

resource "aws_route_table" "cloudtutorial_rt" {
  vpc_id = aws_vpc.cloudtutorial_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudtutorial_igw.id
  }

  tags = {
    Name = "cloudtutorial-rt"
  }
}

resource "aws_route_table_association" "cloudtutorial_subnet_1_association" {
  subnet_id      = aws_subnet.cloudtutorial_subnet_1.id
  route_table_id = aws_route_table.cloudtutorial_rt.id
}

resource "aws_route_table_association" "cloudtutorial_subnet_2_association" {
  subnet_id      = aws_subnet.cloudtutorial_subnet_2.id
  route_table_id = aws_route_table.cloudtutorial_rt.id
}
