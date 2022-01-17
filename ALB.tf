
# terraform create application Load Balancer
# THE APPLICATION LOAD BALANCER


resource "aws_lb" "Thelma9_ALB" {
  name               = "Thelma9-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Thelma9-Secgrp.id]

  enable_deletion_protection = false

  subnet_mapping {
    subnet_id = aws_subnet.Thelma9_Pub-Subnet1.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.Thelma9_Pub-Subnet2.id
  }

  tags = {
    name = "Thelma9_ALB"
  }
}

# Target Group #

resource "aws_alb_target_group" "Thelma9_alb-Targetgrp" {
  name        = "thelma9-alb-targetgrp"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.Thelma9-vpc.id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200,300"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# LISTENER ON PORT 80 WITH REDIRECT APPLICATION

resource "aws_lb_listener" "Thelma9-alb-listener" {
  load_balancer_arn = aws_lb.Thelma9_ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.Thelma9_alb-Targetgrp.arn
  }
}



resource  "aws_placement_group" "Thelma9-Placementgrp1" {
  name      ="Thelma9-Placementgrp1"
  strategy  ="partition"
}

# The Autoscalling Launch configuration

resource "aws_launch_configuration" "Thelma9_autoscale-config" {
  name_prefix = "Launch_config"

  image_id = "ami-08e4e35cccc6189f4" # Put your image id
  instance_type = "t2.micro" 
  key_name = "Thelma9"

  security_groups = [aws_security_group.Thelma9-Secgrp.id]
  associate_public_ip_address = true

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

    lifecycle {
    create_before_destroy = true
  }
}