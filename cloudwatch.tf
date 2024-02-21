resource "aws_cloudwatch_metric_alarm" "eks_cpu_utilization_alarm" {
  alarm_name          = "eks-cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = 300 
  statistic           = "Average"
  threshold           = 80 
  alarm_description   = "Alarm when EKS CPU utilization exceeds 80%"

  dimensions = {
    ClusterName = local.name
  }
}

resource "aws_cloudwatch_metric_alarm" "eks_memory_utilization_alarm" {
  alarm_name          = "eks-memory-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/EKS"
  period              = 300 
  statistic           = "Average"
  threshold           = 80 
  alarm_description   = "Alarm when EKS memory utilization exceeds 80%"

  dimensions = {
    ClusterName = local.name
  }
}

resource "aws_cloudwatch_metric_alarm" "eks_instance_cost_alarm" {
  alarm_name          = "eks-instance-cost-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 86400 
  statistic           = "Maximum" 
  threshold           = 1000 
  alarm_description   = "Alarm when EKS instance costs exceed threshold"

  dimensions = {
    ServiceName = "Amazon Elastic Compute Cloud - Compute"
  }
}


resource "aws_cloudwatch_metric_alarm" "dynamodb_billing_alarm" {
  alarm_name          = "dynamodb-billing-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsumedWriteCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 3600 
  statistic           = "Sum"
  threshold           = 1000 
  alarm_description   = "Alarm when DynamoDB billing exceeds threshold"
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_autoscaling_alarm" {
  alarm_name          = "dynamodb-autoscaling-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsumedWriteCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 300 
  statistic           = "Sum"
  threshold           = 500 
  alarm_description   = "Alarm when DynamoDB write capacity is less than 500"
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_read_capacity_alarm" {
  alarm_name          = "dynamodb-read-capacity-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ConsumedReadCapacityUnits"
  namespace           = "AWS/DynamoDB"
  period              = 300 
  statistic           = "Maximum" 
  threshold           = 1000 
  alarm_description   = "Alarm when DynamoDB read capacity exceeds threshold"

  dimensions = {
    TableName = "users"
  }
}
