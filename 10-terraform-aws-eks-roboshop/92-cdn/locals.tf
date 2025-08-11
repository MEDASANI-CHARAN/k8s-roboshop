locals {
  common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = "true"
  }
  acm_certificate_arn = data.aws_ssm_parameter.acm_certificate_arn.value
  cache_policy_id_enable = data.aws_cloudfront_cache_policy.cacheEnable.id
  cache_policy_id_disable = data.aws_cloudfront_cache_policy.cacheDisable.id
}