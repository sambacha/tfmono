### public-load-balancer.tf

resource "aws_security_group" "main" {
  description = "load balancer for ${var.name}"
  vpc_id      = "${data.aws_subnet.selected.vpc_id}"
}

resource "aws_security_group_rule" "ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.main.id}"
}

resource "aws_security_group_rule" "ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.main.id}"
}

resource "aws_lb" "alb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.main.id}"]
  subnets            = ["${var.subnets}"]
}

resource "aws_lb_target_group" "default" {
  vpc_id   = "${data.aws_subnet.selected.vpc_id}"
  port     = 80
  protocol = "HTTP"

  health_check {
    ## Health Check Stuff
  }
}
