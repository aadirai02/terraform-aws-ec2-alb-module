variable "vpc_id" {
  description = "VPC for dev environment"
  type        = string
  default     = "10.0.0.0/16"
}

variable "listener_port" {
  description = "The port on which the load balancer will listen"
  default     = 80
}

variable "security_group_ids" {
  type = list(string)
}

variable "public_subnets_ids" {
  type = list(string)
}
