data "aws_ami" "amazon-linux-2-private" {
  most_recent = true
  owners      = ["amazon"] 

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm*",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

data "template_file" "user_data_file-private" {
    template = file("${var.files_path}/userdata/userdata.sh")
}

resource "aws_key_pair" "ssh_auth-private" {
  key_name   = var.project_name
  public_key = file("${var.files_path}/ssh-keypair/smallcase-cloud.pub")
}

module "asg-private" {
  source  = "../../modules/asg"

  name = "${var.project_name}-${var.environment_name}-private"

  # Launch configuration
  lc_name = "${var.environment_name}-lc-private"

  image_id        = data.aws_ami.amazon-linux-2-private.id
  instance_type   = var.ec2_instance_type
  security_groups = [module.security_groups.sg_ec2]
  user_data        = data.template_file.user_data_file-private.rendered
  key_name = aws_key_pair.ssh_auth-private.key_name
  target_group_arns    = list(element(module.alb.target_group_arns, 0))

  root_block_device = [
    {
      volume_size = "20"
      volume_type = "gp2"
      encrypted = true
    },
  ]

  # Auto scaling group
  asg_name                  = "${var.environment_name}-asg"
  vpc_zone_identifier       = module.vpc.private-subnet-ids
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "var.environment_name"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "var.project_name"
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = "yes"
      propagate_at_launch = true
    }
  ]

  tags_as_map = {
  }
}
