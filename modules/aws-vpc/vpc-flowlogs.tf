locals {
  # Only create flow log if user selected to create a VPC as well
  enable_flow_log = var.enabled && var.enable_flow_log
}

###################
# Flow Log
###################
resource "aws_flow_log" "this" {
  count = local.enable_flow_log ? 1 : 0

  log_destination_type     = var.flow_log_destination_type
  traffic_type             = var.flow_log_traffic_type
  vpc_id                   = aws_vpc.vpc[0].id
  log_destination = var.flow_log_destination_arn
  max_aggregation_interval = var.flow_log_max_aggregation_interval

  tags = merge(var.tags, var.vpc_flow_log_tags)
}

