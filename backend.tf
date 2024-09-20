terraform {
  required_version = "~> 1.3.7"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65.0"
    }
  }

  # Local backend configuration to store the state locally
  backend "local" {
    path = "./terraform.tfstate"
  }
}
