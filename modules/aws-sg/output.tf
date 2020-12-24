output "sg_ec2" {
  value       = aws_security_group.ec2.id
}

output "sg_alb_public" {
  value       = aws_security_group.alb-public.id
}
