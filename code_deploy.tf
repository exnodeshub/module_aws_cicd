################################################
# Code deploy
################################################
resource "aws_codedeploy_app" "general-codedeploy" {
    compute_platform = "ECS"
    name             = "${var.env_name}-${var.repository_name}"
}

resource "aws_codedeploy_deployment_config" "general-codedeploy-deployment-config" {
    deployment_config_name = "${var.env_name}-${var.region}-${var.repository_name}-deployment-config"
    compute_platform       = "ECS"

    traffic_routing_config {
        type = "TimeBasedCanary"
        time_based_canary {
            interval   = 1
            percentage = 50
        }
    }
}

resource "aws_codedeploy_deployment_group" "general-codedeploy-deployment-group" {
    app_name               = aws_codedeploy_app.general-codedeploy.name
    deployment_config_name = aws_codedeploy_deployment_config.general-codedeploy-deployment-config.id
    deployment_group_name  = "${var.env_name}-${var.repository_name}"
    service_role_arn       = var.iam_role_codedeploy_arn

    auto_rollback_configuration {
        enabled = true
        events  = ["DEPLOYMENT_FAILURE"]
    }

    blue_green_deployment_config {
        deployment_ready_option {
            action_on_timeout = "CONTINUE_DEPLOYMENT"
        }
        terminate_blue_instances_on_deployment_success {
            action                           = "TERMINATE"
            termination_wait_time_in_minutes = 0
        }
    }

    deployment_style {
        deployment_option = "WITH_TRAFFIC_CONTROL"
        deployment_type   = "BLUE_GREEN"
    }

    ecs_service {
        cluster_name = "${var.env_name}-cluster"
        service_name = var.ecs_service_name
    }

    load_balancer_info {
        target_group_pair_info {
            prod_traffic_route {
                listener_arns = [var.ecs_alb_https_listener_arn]
            }
            target_group {
                name = var.ecs_alb_target_group_blue_name
            }
            target_group {
                name = var.ecs_alb_target_group_green_name
            }
        }
    }
}