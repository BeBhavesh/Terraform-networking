# create VPC

resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr

}
# Igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.name.id

}
resource "aws_eip" "nat_eip" {
  
}

# NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)

}

# Create Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)    
    vpc_id            = aws_vpc.name.id
    cidr_block        = element(var.public_subnets, count.index)    
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)       
    vpc_id            = aws_vpc.name.id
    cidr_block        = element(var.private_subnets, count.index)    
    availability_zone = element(var.availability_zones, count.index)
}

# Create Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.name.id
}

# Create Route to Internet Gateway in Public Route Table        
resource "aws_route" "public_rt_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id  

  }

# Create Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.name.id
}

  resource "aws_route" "private_rt_route" {
    route_table_id         = aws_route_table.private_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat_gw.id
  }

