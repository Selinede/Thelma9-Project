

# REFERENCE FILE
# REGION

variable "region" {
    type         = string
    description  = "US"
    default      ="us-east-1"
}

# VPC CIDR cidr_block

variable "vpc-cidr-thelma9" {
  type         = string
  default      = "10.0.0.0/16"
  description  = "myvpc-cidr"
    
}


variable "tag-post" {
  type         = string
  default      = "Thelma9-vpc"
  description  = "tag name"
    
}

# PUBLIC SUBNET1 variable

variable "pub-subnet1-cidr"{
    type          = string
    description   = "Thelma9_Pub-Subnet1"
    default       = "10.0.1.0/24"
}

# PUBLIC SUBNET2 variable

variable "pub-subnet2-cidr"{
    type          = string
    description   = "Thelma9_Pub-Subnet2"
    default       = "10.0.2.0/24"
}

# PRIVATE SUBNET1 variable

variable "pri-subnet1-cidr"{
    type          = string
    description   = "Thelma9_Pri-Subnet1"
    default       = "10.0.3.0/24"
}

# PRIVATE SUBNET2 variable

variable "pri-subnet2-cidr"{
    type          = string
    description   = "Thelma9_Pri-Subnet2"
    default       = "10.0.4.0/24"
    
}


#First EC2 Instance AMI

variable "ami-ec2"{
    type          = string
    description   = "webserver1"
    default       = "ami-083602cee93914c0c"
}

# Second EC2 Instance AMI

variable "ami1-ec2"{
    type          = string
    description   = "webserver2"
    default       = "ami-08e4e35cccc6189f4"
    
}