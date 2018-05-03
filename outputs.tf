output "alb_id" {
  value = "${module.alb.load_balancer_id}"
}

output "dns_name" {
  value = "${module.alb.dns_name}"
}

#output "zone_id" {
#  value = "${module.alb.zone_id}"
#}

output "cert_id" {
  value = "${data.aws_acm_certificate.domain.arn}"
}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "http_tcp_listener_arns" {
  value = "${module.alb.http_tcp_listener_arns}"
}

output "https_listener_arns" {
  value = "${module.alb.https_listener_arns}"
}

output "region" {
  value = "${var.region}"
}

output "sg_id" {
  value = "${module.ecs_sg.this_security_group_id}"
}

output "target_group_arns" {
  value = "${module.alb.target_group_arns}"
}

#output "vpc_id" {
#  value = "${module.vpc.vpc_id}"
#}

output "this_security_group_id" {
  description = "The ID of the security group"
  value       = "${module.ecs_sg.this_security_group_id}"
}

output "this_security_group_vpc_id" {
  description = "The VPC ID"
  value       = "${module.ecs_sg.this_security_group_vpc_id}"
}

output "this_security_group_owner_id" {
  description = "The owner ID"
  value       = "${module.ecs_sg.this_security_group_owner_id}"
}

output "this_security_group_name" {
  description = "The name of the security group"
  value       = "${module.ecs_sg.this_security_group_name}"
}

output "this_security_group_description" {
  description = "The description of the security group"
  value       = "${module.ecs_sg.this_security_group_description}"
}

output "alb_sg_id" {
  value = "${module.alb_sg.this_security_group_id}"
}
