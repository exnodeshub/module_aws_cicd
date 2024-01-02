output "codebuild_project" {
  description = "Get code build project"
  value = aws_codebuild_project.general-codebuild
}
output "codedeploy_project" {
  description = "Get code deploy project"
  value = aws_codedeploy_app.general-codedeploy
}
output "codedeploy_project_group" {
  description = "Get code deploy group"
  value = aws_codedeploy_deployment_group.general-codedeploy-deployment-group
}
output "codepipeline_project" {
  description = "Get code pipeline project"
  value = aws_codepipeline.general-codepipeline
}