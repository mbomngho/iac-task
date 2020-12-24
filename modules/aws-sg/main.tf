resource "aws_security_group" "ec2" {
    name = "${var.name}-ec2"
    description = "EC2 Security Group"
    vpc_id = var.vpc_id

  tags = {
    Terraform = "true"
    Environment = var.environment
    Project = var.name
   }
}

resource "aws_security_group" "alb-public" {
    name = "${var.name}-alb-public"
    description = "ALB Internet Facing Security Group"
    vpc_id = var.vpc_id

  tags = {
    Terraform = "true"
    Environment = var.environment
    Project = var.name
   }

}