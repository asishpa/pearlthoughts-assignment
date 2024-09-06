resource "aws_lb" "medusa_lb" {
  name               = "medusa-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
}

resource "aws_lb_target_group" "medusa_tg" {
  name        = "medusa-tg"
  port        = 9000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type  = "ip"  # Updated target type
  health_check {
   path                = "/health"  # Ensure your application exposes this endpoint
   interval            = 30         # Time between health checks
   timeout             = 5          # How long the LB waits for a response
   healthy_threshold   = 3          # Number of successful checks to mark as healthy
   unhealthy_threshold = 3          # Number of failed checks to mark as unhealthy
   matcher             = "200"      # Expected response code
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.medusa_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.medusa_tg.arn
  }
}
