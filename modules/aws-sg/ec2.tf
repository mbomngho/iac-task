resource "aws_security_group_rule" "ingress" {
    type = "ingress"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    security_group_id = aws_security_group.ec2.id
    source_security_group_id = aws_security_group.alb-public.id
    description = "Allow ALB Internet Facing Security Group"
    
}

resource "aws_security_group_rule" "egress_all_ec2_servers" {
    type = "egress"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    security_group_id = aws_security_group.ec2.id
    cidr_blocks = ["0.0.0.0/0"]
}
