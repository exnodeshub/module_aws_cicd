# IAM
variable "iam_role_codedeploy_arn" {
    description = "Role codebuild arn"
    type        = string
}
variable "iam_role_codepipeline_arn" {
    description = "Role codepipeline arn"
    type        = string
}
variable "iam_role_codebuild_arn" {
    description = "Role codebuild arn"
    type        = string
}
variable "repository" {
    description = "Repository of ECR"
    type        = string
}
variable "repository_name" {
    description = "Repository name"
    type        = string
}
variable "env_name" {
  description = "Define environment name"
  type = string
  default = "prod"
}
variable "region" {
  description = "Region"
  type = string
}
variable "region_name" {
  description = "Region name, Ex: Ohio, SGP, etc"
  type = string
}
variable "iam_task_role_arn" {
    description = "Task role arn"
    type        = string
    default = "null"
}
variable "iam_access_account_id" {
  description = "Get IAM access key id from current account"
  type = string
}
variable "s3_cloudwatch_ecs_id" {
    description = "S3 cloudwatch ecs id"
    type = string
}
variable "s3_private_id" {
    description = "s3 private id"
    type = string
}
// lay tu output module s3
variable "s3_object_config_key" {
    description = "s3 object config key"
    type = string
}
variable "iam_access_key_id" {
  description = "Get IAM access key id"
  type = string
}
variable "iam_access_key_secret" {
  description = "Get IAM access key secret"
  type = string
}
variable "task_port" {
  description = "task port"
  type = string
}
variable "s3_cloudwatch_codebuild_name" {
    description = "S3 cloudwatch codebuild name"
    type = string
}
variable "s3_object_buildspec_file_id" {
    description = "s3 object buildspec file id"
    type        = string
}
variable "ecs_service_name" {
    description = "Get ecs service name from ECS module"
    type        = string
}
variable "ecs_alb_https_listener_arn" {
    description = "Target listener for https:443"
    type        = string
}
variable "ecs_alb_target_group_blue_name" {
    description = "Get alb target group blue"
    type        = string
}
variable "ecs_alb_target_group_green_name" {
    description = "Get alb target group green"
    type        = string
}
variable "git_repository" {
  description = "Git repository"
  type = string
}
variable "branch_deploy" {
  description = "Branch deployment"
  type = string
  default = "develop"
}