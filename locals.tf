locals {
  tags = "${map("Environment", "${var.environment}",
                "GithubRepo", "tf-aws-alb",
                "GithubOrg", "terraform-aws-modules",
                "Workspace", "${terraform.workspace}",
  )}"

  log_bucket_name = "${var.app_name}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  https_listeners_count = 1

  https_listeners = "${list(
                        map(
                            "certificate_arn", "${data.aws_acm_certificate.domain.arn}",
                            "port", 443,
                        ),
  )}"

  target_groups_count = 1

  target_groups = "${list(
                        map("name", "${var.app_name}-backend",
                            "backend_protocol", "HTTP",
                            "backend_port", "${var.container_port}",
                            "target_type", "ip",
                        ),
  )}"

  # helpful for debugging
  #   https_listeners_count    = 0
  #   https_listeners          = "${list()}"
  #   http_tcp_listeners_count = 0
  #   http_tcp_listeners       = "${list()}"
  #   target_groups_count      = 0
  #   target_groups            = "${list()}"
  #   extra_ssl_certs_count    = 0
  #   extra_ssl_certs          = "${list()}"
}
