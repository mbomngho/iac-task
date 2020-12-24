resource "aws_security_group_rule" "ingress_80_alb" {
    type = "ingress"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    security_group_id = aws_security_group.alb-public.id
    cidr_blocks = formatlist("%s/32", concat(var.whitelsit_ips))
    description = "IP of whitlelisted members"
}

resource "aws_security_group_rule" "egress_all_public_alb" {
    type = "egress"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    security_group_id = aws_security_group.alb-public.id
    cidr_blocks = ["0.0.0.0/0"]
}