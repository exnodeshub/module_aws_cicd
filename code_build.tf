################################################
# Code build
################################################
resource "aws_codebuild_project" "general-codebuild" {
    name         = "${var.env_name}-${var.region_name}-${var.repository_name}"
    service_role = var.iam_role_codebuild_arn
    artifacts {
        type = "CODEPIPELINE"
    }
    environment {
        compute_type                = "BUILD_GENERAL1_SMALL"
        image                       = "aws/codebuild/amazonlinux2-x86_64-standard:2.0"
        privileged_mode             = "true"
        type                        = "LINUX_CONTAINER"
        image_pull_credentials_type = "CODEBUILD"
        environment_variable {
            name  = "EXECUTION_ROLE_ARN"
            value = var.iam_role_codebuild_arn
        }
        environment_variable {
            name  = "TASK_ROLE_ARN"
            value = var.iam_task_role_arn == "null" ? "" : var.iam_task_role_arn
        }
        environment_variable {
            name  = "TASK_DEFINITION_FAMILY"
            value = var.repository_name
        }
        environment_variable {
            name  = "AWS_ACCOUNT_ID"
            value = var.iam_access_account_id
        }
        environment_variable {
            name  = "LOGS_GROUP"
            value = var.s3_cloudwatch_ecs_id
        }
        environment_variable {
            name  = "AWS_REGION"
            value = var.region
        }
        environment_variable {
            name  = "ENV_ARN"
            value = "arn:aws:s3:::${var.s3_private_id}/${var.s3_object_config_key}"
        }
        environment_variable {
            name  = "AWS_ACCESS_KEY_ID"
            value = var.iam_access_key_id
        }

        environment_variable {
            name  = "AWS_SECRET_ACCESS_KEY"
            value = var.iam_access_key_secret
        }
        environment_variable {
            name  = "REPOSITORY_NAME"
            value = var.repository
        }
        environment_variable {
            name  = "env_name"
            value = var.env_name
        }
        environment_variable {
            name  = "PORT"
            value = var.task_port
        }
    }
    logs_config {
        cloudwatch_logs {
            group_name = "${var.s3_cloudwatch_codebuild_name}"
        }
    }
    source {
        type      = "CODEPIPELINE"
        buildspec = "arn:aws:s3:::${var.s3_private_id}/${var.s3_object_buildspec_file_id}"
    }
    tags = {
        Name = "${var.region} ${var.repository_name} CodeBuild"
    }
}