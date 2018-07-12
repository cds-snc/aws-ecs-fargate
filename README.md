## This Terraform module will deploy an ECS cluster


## Usage

```
module "ecs" {
  source         = "https://github.com/cds-snc/aws-ecs-fargate"
  environment    = "${var.environment}"
  task_name      = "${var.task_name}"
  container_name = "vac"
  container_port = "${var.container_port}"
  docker_image   = "docker.io/example/example:latest"
  app_name       = "my-app"
  region         = "us-east-1"
 # vpc_id         = "${data.terraform_remote_state.web.vpc_id}"
  vpc_id         = "${var.vpc_id}"
  public_subnets = ["subet1", "subetn2"]

  providers = {
    random = "random.default"
  }
}
```
