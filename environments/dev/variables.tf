variable "region" {
  default = "eu-central-1"
}

variable "environment_name" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "devops"
}

variable "files_path" {
  type    = string
  default = "../../files/dev"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}
