
# RDS-MYSQL

#The MYSQL

resource "aws_db_instance" "my_rds1" {
  allocated_storage    = 12
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "my_rds1"
  username             = "selina"
  password             = "thanks12"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = "true"
  db_subnet_group_name = aws_db_subnet_group.Project-subnetgroup.id
  count = "2"
  
  
  
}


# DB SUBNET GROUP

resource "aws_db_subnet_group" "Project-subnetgroup" {
  name     = "project-subnetgroup"
  
  subnet_ids = [aws_subnet.Thelma9_Pri-Subnet1.id, aws_subnet.Thelma9_Pri-Subnet2.id]

  tags = {
    Name = "Project-selina"
  }
}










