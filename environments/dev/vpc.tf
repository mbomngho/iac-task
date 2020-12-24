module "vpc" {
  source = "../../modules/aws-vpc"
  vpc-location                        = "N. Virginia"
  namespace                           = "united"
  name                                = "vpc"
  stage                               = "dev"
  map_public_ip_on_launch             = "true"
  total-nat-gateway-required          = "1"
  vpc-cidr                            = "10.11.0.0/16"
  vpc-public-subnet-cidr              = ["10.11.1.0/24","10.11.3.0/24"]
  vpc-private-subnet-cidr             = ["10.11.5.0/24","10.11.7.0/24"]
  enable_flow_log           = true
  flow_log_destination_type = "s3"
  flow_log_destination_arn  = module.s3_bucket.this_s3_bucket_arn
  vpc_flow_log_tags = {
    Name = "vpc-flow-logs-s3-bucket"
  }
}

############
# S3 bucket
############
module "s3_bucket" {
  source  = "../../modules/aws-s3"

  bucket        = local.s3_bucket_name
  policy        = data.aws_iam_policy_document.flow_log_s3.json
  force_destroy = true

  tags = {
    Name = "vpc-flow-logs-s3-bucket"
  }
}

data "aws_iam_policy_document" "flow_log_s3" {
  statement {
    sid = "AWSLogDeliveryWrite"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = ["arn:aws:s3:::${local.s3_bucket_name}/AWSLogs/*"]
  }

  statement {
    sid = "AWSLogDeliveryAclCheck"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    effect = "Allow"

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = ["arn:aws:s3:::${local.s3_bucket_name}"]
  }
}

locals {
  s3_bucket_name            = "vpc-flow-logs-to-s3-${random_pet.this.id}"
}

resource "random_pet" "this" {
  length = 2
}
