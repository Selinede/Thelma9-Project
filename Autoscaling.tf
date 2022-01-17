
# aws_autoscaling_group

resource "aws_autoscaling_group" "Thelma9_Autoscaling-Grp" {
  name                      = "Thelma9_ASG"
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "EC2"
  desired_capacity          = 1
 
  force_delete              = true
  placement_group           = aws_placement_group.Thelma9-Placementgrp1.id
 
  launch_configuration      = aws_launch_configuration.Thelma9_autoscale-config.name
  vpc_zone_identifier       = [aws_subnet.Thelma9_Pub-Subnet1.id, aws_subnet.Thelma9_Pub-Subnet2.id]
  target_group_arns         = [aws_alb_target_group.Thelma9_alb-Targetgrp.arn]

  lifecycle {
      create_before_destroy = true
  }

  tag {
    key                 = "name"
    value               = "Thelma9_ASG"
    propagate_at_launch = true
  }

}

# Autoscalling Policy Project 9_up

resource "aws_autoscaling_policy" "Thelma9_cpu_up" {
  name = "Thelma9_cpu_policy_up"
  scaling_adjustment = "1"
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = aws_autoscaling_group.Thelma9_Autoscaling-Grp.name
  
}

# Autoscalling Policy Project 9_down

resource "aws_autoscaling_policy" "Thelma9_cpu_down" {
  name = "Thelma9_cpu_policy_down"
  scaling_adjustment = "-1"
  adjustment_type = "ChangeInCapacity"
  cooldown = 10
  autoscaling_group_name = aws_autoscaling_group.Thelma9_Autoscaling-Grp.name
}

# UP_Cloud Watch Monitoring For Autoscale

resource "aws_cloudwatch_metric_alarm" "Thelma9_cpu_alarm_up" {
  alarm_name = "Thelma9_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "20"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Thelma9_Autoscaling-Grp.name
  }

  alarm_description = "This metric monitor EC2 CPU utilization when up"
  alarm_actions = [aws_autoscaling_policy.Thelma9_cpu_up.arn]
}

# Down_Cloud Watch Monitoring For Autoscale

resource "aws_cloudwatch_metric_alarm" "Thelma9_cpu_alarm_down" {
  alarm_name = "Thelma9_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Thelma9_Autoscaling-Grp.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization when down"
  alarm_actions = [aws_autoscaling_policy.Thelma9_cpu_down.arn]

}