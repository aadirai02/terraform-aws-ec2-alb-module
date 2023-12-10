module "load_balancer" {
  source             = "../../../modules/LoadBalancer"
  listener_port      = var.listener_port
  vpc_id             = module.ec2_instance.vpc_id
  security_group_ids  = module.ec2_instance.security_group_ids
  public_subnets_ids = module.ec2_instance.public_subnets_ids
}

module "ec2_instance" {
  source           = "../../../modules/VirtualMachine/"
  instance_type    = var.instance_type
  ami_id           = var.ami_id
  instance_name    = var.instance_name
  environment_type = var.environment_type
  custom_vpc       = var.custom_vpc
  target_group_arn = module.load_balancer.lb_target_group_arn
}
