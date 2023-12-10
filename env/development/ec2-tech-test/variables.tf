variable "ami_id" {
  type    = string
  default = "ami-01fea1abf1c1befc0"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_name" {
  type    = string
  default = "infra-app"
}
variable "environment_type" {
  type    = string
  default = "dev"
}
variable "custom_vpc" {
  description = "VPC for testing environment"
  type        = string
  default     = "10.0.0.0/16"
}
variable "listener_port" {
  description = "The port on which the load balancer will listen"
  default     = 80
}

