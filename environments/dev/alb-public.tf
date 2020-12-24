module "alb" {
  source = "../../modules/alb"

  load_balancer_name = "${var.environment_name}-alb-public"
  security_groups    = [module.security_groups.sg_alb_public]
  logging_enabled    = "false"
  subnets            = module.vpc.public-subnet-ids
  vpc_id             = module.vpc.vpc-id
  http_tcp_listeners = [
    {
      "port"     = "80"
      "protocol" = "HTTP"
    },
  ]
  http_tcp_listeners_count = "1"

  target_groups = [
    {
      "name"             = "web-app"
      "backend_protocol" = "HTTP"
      "backend_port"     = "80"
      "health_check_path" = "/"
      "health_check_port" = "80"
      "matcher"           = "200"
    },
  ]
  target_groups_count = "1"

  tags = {
    Terraform   = "true"
    Environment = var.environment_name
    Project     = var.project_name
  }
}
