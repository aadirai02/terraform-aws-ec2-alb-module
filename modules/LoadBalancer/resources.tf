resource "aws_lb" "my_load_balancer" {
  name                             = "my-load-balancer"
  internal                         = false
  load_balancer_type               = "application"
  enable_deletion_protection       = false
  security_groups                  = var.security_group_ids
  subnets                          = var.public_subnets_ids
  enable_http2                     = true
  idle_timeout                     = 60
  enable_cross_zone_load_balancing = false

  # Add other necessary configurations

  tags = {
    "Name" = "MyLoadBalancer"
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = var.listener_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}

resource "aws_lb_listener_rule" "my_listener_rule" {
  listener_arn = aws_lb_listener.my_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}
