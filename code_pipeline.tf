################################################
# Code pipeline
################################################
resource "aws_codepipeline" "general-codepipeline" {
    name     = "${var.env_name}-${var.region_name}-${var.repository_name}"
    role_arn = var.iam_role_codepipeline_arn

    artifact_store {
        location = var.s3_private_id
        type     = "S3"
    }

    stage {
        name = "Source"
        action {
            name             = "Source"
            category         = "Source"
            owner            = "AWS"
            provider         = "CodeCommit"
            version          = "1"
            output_artifacts = ["SourceArti"]
            configuration = {
                RepositoryName = var.git_repository
                BranchName     = var.branch_deploy
            }
        }
    }

    stage {
        name = "Build"
        action {
        name             = "Build"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["SourceArti"]
        output_artifacts = ["BuildArti"]
        version          = "1"
        configuration = {
                ProjectName = "${var.env_name}-${var.region}-${var.repository_name}"
            }
        }
    }

    stage {
        name = "Deploy"
        action {
            name            = "Deploy"
            category        = "Deploy"
            owner           = "AWS"
            provider        = "CodeDeployToECS"
            input_artifacts = ["BuildArti"]
            version         = "1"
            configuration = {
                AppSpecTemplateArtifact        = "BuildArti"
                AppSpecTemplatePath            = "appspec.yaml"
                ApplicationName                = "${var.env_name}-${var.repository_name}"
                DeploymentGroupName            = aws_codedeploy_deployment_group.general-codedeploy-deployment-group.deployment_group_name
                TaskDefinitionTemplateArtifact = "BuildArti"
                TaskDefinitionTemplatePath     = "taskdef.json"
            }
        }
    }
    lifecycle {
        ignore_changes = [
        stage
        ]
    }

    tags = {
        Name = "${var.env_name}-${var.repository_name} CodePipeline"
    }
}
