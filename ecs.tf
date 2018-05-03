resource "aws_ecs_cluster" "cluster" {
  name = "${var.environment}-ecs-cluster"
}

/*
ECS task definitions
*/

/* the task definition for the web service */
data "template_file" "web_task" {
  template = "${file("${path.module}/tasks/webapp.json")}"

  vars {
    image          = "${var.docker_image}"
    container_name = "${var.container_name}"
    container_port = "${var.container_port}"
    app_name       = "${var.app_name}"

    #log_group       = "${aws_cloudwatch_log_group.openjobs.name}"
  }
}

resource "aws_ecs_task_definition" "current_task" {
  family                   = "${var.app_name}-${var.environment}"
  container_definitions    = "${data.template_file.web_task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "${var.cpu}"
  memory                   = "${var.memory}"
  execution_role_arn       = "${aws_iam_role.ecs_execution_role.arn}"
  task_role_arn            = "${aws_iam_role.ecs_execution_role.arn}"
}

data "aws_ecs_task_definition" "current_task" {
  task_definition = "${aws_ecs_task_definition.current_task.family}"
  depends_on      = ["aws_ecs_task_definition.current_task"]
}

resource "aws_ecs_service" "current_task" {
  name            = "${var.environment}-${var.app_name}"
  task_definition = "${aws_ecs_task_definition.current_task.family}:${max("${aws_ecs_task_definition.current_task.revision}", "${data.aws_ecs_task_definition.current_task.revision}")}"
  desired_count   = "${var.desired_count}"
  launch_type     = "FARGATE"
  cluster         = "${aws_ecs_cluster.cluster.id}"
  depends_on      = ["aws_iam_role_policy.ecs_service_role_policy"]

  network_configuration {
    security_groups = ["${module.ecs_sg.this_security_group_id}"]

    #subnets          = ["${module.vpc.public_subnets}"]
    subnets          = ["${var.public_subnets}"]
    assign_public_ip = "true"
  }

  load_balancer {
    #target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    target_group_arn = "${module.alb.target_group_arns[0]}"

    #target_group_arn  = "${module.alb.target_group_sg_arns}"
    container_name = "${var.container_name}"
    container_port = "${var.container_port}"
  }

  #depends_on = ["aws_alb_target_group.alb_target_group"]
}
