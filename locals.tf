locals {
  iam_policy_name    = "EC2PolicyToEnableSSM"
  ssm_document_name  = "SSM-SessionManagerRunShell"
  cwl_log_group_name = "/aws/ssm/session-manager"
}
