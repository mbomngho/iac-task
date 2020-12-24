# Labels

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. `app` or `jenkins`"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}



# VPC

variable "enabled" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "instance-tenancy" {
  default = "default"
}
variable "enable-dns-support" {
  default = "true"
}

variable "enable-dns-hostnames" {
  default = "true"
}

# VPC Location

variable "vpc-location" {
  default = ""
}


# Internet Gateways Tags

variable "internet-gateway-name" {
  description = "Additional tags for the internet gateway"
  default     = "igw"
}

# Public Subnet Tags

variable "map_public_ip_on_launch" {
  default = "true"
}
variable "public-subnets-name" {
  default = "public-subnets"
}
variable "public-subnet-routes-name" {
  default = "public-routes"
}

# Nat Gate Ways

variable "total-nat-gateway-required" {
  default = "1"
}

# Elastic IP Tags

variable "eip-for-nat-gateway-name" {
  default = "eip-nat-gateway"
}

# Nat Gate Way Tags

variable "nat-gateway-name" {
  default = "nat-gateway"
}


# Private Route Cidr

variable "private-route-cidr" {
  default = "0.0.0.0/0"
}

# Private Route Tags

variable "private-route-name" {
  default = "private-routes"
}



# VPC Cidr Block

variable "vpc-cidr" {
  default = ""
}

# VPC Public Subnets Cidr Block List

variable "vpc-public-subnet-cidr" {
  type = list
}

# VPC Private Subnets Cidr Block List

variable "vpc-private-subnet-cidr" {
  type = list
}

# Private Subnets Tags

variable "private-subnet-name" {
  default = "private-subnets"
}

# FETCH AZS From Region

data "aws_availability_zones" "azs" {}




variable "enable_flow_log" {
  description = "Whether or not to enable VPC Flow Logs"
  type        = bool
  default     = false
}


variable "flow_log_traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL."
  type        = string
  default     = "ALL"
}

variable "flow_log_destination_type" {
  description = "Type of flow log destination. Can be s3 or cloud-watch-logs."
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_log_format" {
  description = "The fields to include in the flow log record, in the order in which they should appear."
  type        = string
  default     = null
}

variable "flow_log_destination_arn" {
  description = "The ARN of the CloudWatch log group or S3 bucket where VPC Flow Logs will be pushed. If this ARN is a S3 bucket the appropriate permissions need to be set on that bucket's policy. When create_flow_log_cloudwatch_log_group is set to false this argument must be provided."
  type        = string
  default     = ""
}

variable "flow_log_max_aggregation_interval" {
  description = "The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds."
  type        = number
  default     = 600
}

variable "vpc_flow_log_tags" {
  description = "Additional tags for the VPC Flow Logs"
  type        = map(string)
  default     = {}
}