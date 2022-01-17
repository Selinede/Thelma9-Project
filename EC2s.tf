

# Webserver EC2 -1

# Website EC2 -1
resource "aws_instance" "webserver1_project12" {

  ami             = var.ami-ec2
  instance_type   = "t2.micro"
  key_name        = "Thelma9"
  subnet_id       = aws_subnet.Thelma9_Pub-Subnet1.id
 
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.Thelma9-Secgrp.id]


  user_data = <<EOF
  #!/bin/bash
# get admin privileges
sudo su
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  
  EOF

  tags = {
  
    
    Name = "webserver1_projects1"
  } 
}

# Website EC2 -2

resource "aws_instance" "webserver2_project123" {

  ami             = var.ami1-ec2
  instance_type   = "t2.micro"
  key_name        = "Thelma9"
  subnet_id       = aws_subnet.Thelma9_Pub-Subnet2.id
 
  availability_zone = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.Thelma9-Secgrp.id]


  user_data = <<EOF
   #!/bin/bash
# get admin privileges
sudo su
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  
  EOF

  tags = {
  
    
    Name = "webserver2_projects2"
  } 
}


