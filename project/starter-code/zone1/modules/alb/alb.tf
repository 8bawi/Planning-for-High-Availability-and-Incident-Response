resource "aws_lb_target_group" "this" {
  name     = "udacity-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "this" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2.*.id[count.index]
  port             = 80
}

resource "aws_lb" "this" {
  name               = "udacity-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ec2_sg]
  subnets            = var.subnet_id

  enable_deletion_protection = false

}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}