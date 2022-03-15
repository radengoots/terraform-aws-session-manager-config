locals {
  s3_bucket_name    = "default-ssm-logs-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  iam_policy_name   = "EC2PolicyToEnableSSM"
  ssm_document_name = "SSM-SessionManagerRunShell"

  cwl_log_group_name = "/aws/ssm/session-manager"

  s3_logging_bucket = "default-s3-logs-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
}
