# Creating EC2 Instances:

####################################################################

resource "aws_instance" "server" {
  count           = length(aws_subnet.public_subnet.*.id)
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups = [aws_security_group.sg.id, ]

  tags = {
    Name        = var.instance_name
    Environment = var.environment_type
    CreatedBy   = "Terraform"
  }
}


resource "null_resource" "null" {
  count = length(aws_subnet.public_subnet.*.id)

  connection {
    type = "ssh"
    user = "ec2-user"
    port = "22"
    host = element(aws_instance.server[*].public_ip, count.index)  # Change to aws_instance.server[*].public_ip
  }
}


resource "aws_lb_target_group_attachment" "ec2_target_attachment" {
  count             = length(aws_subnet.public_subnet.*.id)
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.server[count.index].id
}

##################################################################

# Creating 3 Elastic IPs:

####################################################################

resource "aws_eip" "eip" {
  count            = length(aws_instance.server.*.id)
  instance         = element(aws_instance.server.*.id, count.index)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP-${count.index}"
  }
}

####################################################################

# Creating EIP association with EC2 Instances:

####################################################################

resource "aws_eip_association" "eip_association" {
  count         = length(aws_eip.eip)
  instance_id   = element(aws_instance.server.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}

#############################################

#Creating Virtual Private Cloud:

#############################################
resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.custom_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "CustomVPC"
  }
}

#############################################

# Creating Public subnet:

#############################################

resource "aws_subnet" "public_subnet" {
  count             = var.custom_vpc == "10.0.0.0/16" ? 3 : 0
  vpc_id            = aws_vpc.custom_vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  cidr_block        = element(cidrsubnets(var.custom_vpc, 8, 4, 4), count.index)

  tags = {
    "Name" = "Public-Subnet-${count.index}"
  }
}

#############################################

# Creating Internet Gateway:

#############################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    "Name" = "Internet-Gateway"
  }
}

#############################################

# Creating Public Route Table:

#############################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    "Name" = "Public-RouteTable"
  }
}

#############################################

# Creating Public Route:

#############################################

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#############################################

# Creating Public Route Table Association:

#############################################

resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet) == 3 ? 3 : 0
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
}
