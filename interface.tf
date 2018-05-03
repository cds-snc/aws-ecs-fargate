variable "container_port" {
  description = "Port that the container listens on"
}

variable "container_name" {
  description = "Name of container"
}

variable "cpu" {
  default = "256"
}

variable "memory" {
  default = "512"
}

variable "network_mode" {
  default = "awsvpc"
}

variable "task_name" {
  description = "Name of the task"
}

variable "docker_image" {
  description = "Location of docker image"
  default     = "docker.io/cdssnc/ircc-rescheduler:latest"
}

variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "The environment name, i.e. staging, production, test"
}

variable "ssl_domain" {
  description = "Name of the domain, i.e. *.cds.com or cds.com"
  default     = "*.cdssandbox.xyz"
}

variable "log_location_prefix" {
  default = "alb-logs"
}

variable "app_name" {
  description = "Name of app"
}

variable "desired_count" {
  default = "2"
}

variable "vpc_id" {
  default     = "vpc-8c4f22f7"
  description = "ID of VPC"
}

variable "public_subnets" {
  default = ["subnet-beece3e3", "subnet-3f10f658"]
  type    = "list"
}
