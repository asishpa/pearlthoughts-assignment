resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  load_balancer {
    target_group_arn = aws_lb_target_group.medusa_tg.arn
    container_name   = "medusa-container"  # Ensure this matches the name defined in your task definition
    container_port   = 9000
  }

  network_configuration {
    subnets          = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  # Ensure dependencies are managed
  depends_on = [
    aws_lb_listener.http_listener
  ]
}
