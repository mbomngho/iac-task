module "security_groups" {
  source      = "../../modules/aws-sg"
  name        = "${var.project_name}-${var.environment_name}"
  environment = var.environment_name
  vpc_id      = module.vpc.vpc-id
  whitelsit_ips = ["55.55.55.55"]
}
