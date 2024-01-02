# module_aws_vpc  
My module vpc aws

## Getting started  
config git credentical for private repo   
href: https://gitlab.com/exnodes-new/terraform-core/-/tree/master/modules/module_aws_cicd?ref_type=heads

add module    
example:       
```JavaScript

module "ohio_service_cms_cicd" {
    source = "./modules/module_aws_cicd"
    # S3
    s3_object_buildspec_file_id = "your s3 object buildspec file id"
    s3_private_id = "your s3 bucket private id"
    s3_object_config_key = "your s3 object config key"
    s3_cloudwatch_codebuild_name = "your cloudwatch codebuild name"
    s3_cloudwatch_ecs_id = "your cloudwatch ecs id"
    # IAM role
    iam_role_codedeploy_arn = "your codedeploy role arn"
    iam_role_codepipeline_arn = "your cide pipeline role arn"
    iam_role_codebuild_arn = "your codebuild role arn"
    iam_access_key_secret = "your access key secret"
    iam_access_key_id = "your access key id"
    iam_access_account_id = "your access account id"
    # ECS
    ecs_service_name = "your ecs service name"
    rrepository = "your repository, Ex: `service.api`"
    region = "your region, Ex: `us-east-1`"
    ecs_alb_https_listener_arn = "your ecs alb https listener arn"
    ecs_alb_target_group_blue_name = "your ecs alb target group blue name"
    ecs_alb_target_group_green_name = "your ecs alb target group green name"
    branch_deploy = "your codecommit deploy branch"
    git_repository = "your git repository, Ex: `service-api`"
    region_name = "your region name. Ex: `tokyo`"
    repository_name = "your repository name, Ex: `service-api`"
    task_port = "your task port, Ex: 8000"
}
```

# Input 
```JavaScript
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

```

# Output 
```JavaScript
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
```