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
      # Directly reference the image URI from the environment
      image       = "${var.IMAGE_URI}"  # Use the image URI passed from GitHub Actions
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
          value = "postgresql://medusa-db_owner:xxx@ep-holy-salad-a5nn97r0-pooler.us-east-2.aws.neon.tech/medusa-db?sslmode=require"
        },
        {
          name  = "JWT_SECRET"
          value = "jwtsecret"
        },
        {
          name  = "COOKIE_SECRET"
          value = "cookiesecret"
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
