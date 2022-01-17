

# The ProjectThelma9 VPC 
resource "aws_vpc" "Thelma9-vpc" {
  cidr_block            = var.vpc-cidr-thelma9
  instance_tenancy      = "default"

  enable_dns_hostnames  =  true
  enable_dns_support = true

  tags = {
   Name = "Thelma9-vpc"
  }
}


# ProjectThelma9 Public Subnet_1

resource "aws_subnet" "Thelma9_Pub-Subnet1" {
  vpc_id            = aws_vpc.Thelma9-vpc.id
  cidr_block        = var.pub-subnet1-cidr
  map_public_ip_on_launch = "true"

  availability_zone = "us-east-1a"

  tags = {
    Name            = "Thelma9_Pub-Subnet1"
  }
}


# ProjectThelma9 Public Subnet_2

resource "aws_subnet" "Thelma9_Pub-Subnet2" {
  vpc_id            = aws_vpc.Thelma9-vpc.id
  cidr_block        = var.pub-subnet2-cidr
  map_public_ip_on_launch = "true"

  availability_zone = "us-east-1b"

  tags = {
    Name            = "Thelma9_Pub-Subnet2"
  }
}


#  ProjectThelma9 Private Subnet 1

resource "aws_subnet" "Thelma9_Pri-Subnet1" {
  vpc_id     = aws_vpc.Thelma9-vpc.id
  cidr_block = var.pri-subnet1-cidr
  map_public_ip_on_launch = "false"

  availability_zone = "us-east-1c"

  tags = {
    Name = "Thelma9_Pri-Subnet1"
  }
}

# ProjectThelma9 Private Subnet 2
resource "aws_subnet" "Thelma9_Pri-Subnet2" {
  vpc_id     = aws_vpc.Thelma9-vpc.id
  cidr_block = var.pri-subnet2-cidr
  map_public_ip_on_launch = "false"
  
  availability_zone = "us-east-1d"

  tags = {
    Name = "Thelma9_Pri-Subnet2"
  }
}




# ProjectThelma9 Public Web-Route Table

resource "aws_route_table" "Pub-Routetable" {
  vpc_id = aws_vpc.Thelma9-vpc.id



  tags = {
    Name = "Pub-Routetable"
  }
}


# ProjectThelma9 Private Route Table

resource "aws_route_table" "Pri-Routetable" {
  vpc_id = aws_vpc.Thelma9-vpc.id



  tags = {
    Name = "Pri-Routetable"
  }
}




# Project Thelma9 Public Route Association with Public Subnet-1

resource "aws_route_table_association" "Pub-RT-Association1" {
  subnet_id      = aws_subnet.Thelma9_Pub-Subnet1.id
  route_table_id = aws_route_table.Pub-Routetable.id
}


# Project Thelma9 Public Route Association with Public Subnet-2

resource "aws_route_table_association" "Pub-RT-Association2" {
  subnet_id      = aws_subnet.Thelma9_Pub-Subnet2.id
  route_table_id = aws_route_table.Pub-Routetable.id
}



#Project Thelma9 Private Route Association with Private subnet-1

resource "aws_route_table_association" "Pri-RT-Association1" {
  subnet_id      = aws_subnet.Thelma9_Pri-Subnet1.id
  route_table_id = aws_route_table.Pri-Routetable.id
}

# Project Thelma9 Private Route Association with Private subnet-2


resource "aws_route_table_association" "Pri-RT-Association2" {
  subnet_id      = aws_subnet.Thelma9_Pri-Subnet2.id
  route_table_id = aws_route_table.Pri-Routetable.id
}


# The_Internet Gateway 


resource "aws_internet_gateway" "Thelma9-IGW" {
  vpc_id       = aws_vpc.Thelma9-vpc.id

  tags = {
    Name = "Thelma9-IGW"
  }
}


# Connection of Routable and Internet Gate Way

# Conection of the Internet GateWay And Pub-Route table


resource "aws_route" "Ass-pubRT-IGW" {
  route_table_id            = aws_route_table.Pub-Routetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.Thelma9-IGW.id   
              
} 

#2

# Security_groups for VPC

resource "aws_security_group" "Thelma9-Secgrp" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = aws_vpc.Thelma9-vpc.id



  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }




  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Thelma9-Secgrp"
  }
}

