resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  
  container_definitions = jsonencode([
    {
      name        = "medusa-container"
      image       = "${var.docker_hub_username}/medusa-backend:latest"  # Placeholder or default value
      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "DATABASE_URL"
          value = var.database_url
        },
        {
          name  = "JWT_SECRET"
          value = var.jwt_secret
        },
        {
          name  = "COOKIE_SECRET"
          value = var.cookie_secret
        },
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          name = "DATABASE_TYPE"
          value = "postgres"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/medusa-task"
          awslogs-region        = "us-east-1"  # Your AWS region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
