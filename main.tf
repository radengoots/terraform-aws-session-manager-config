resource "aws_cloudwatch_log_group" "this" {
  name              = local.cwl_log_group_name
  retention_in_days = var.cwl_logs_retention_days

  tags = {
    ProductDomain = var.product_domain
    Environment   = var.environment
    Name          = local.cwl_log_group_name
    Description   = "Log group that store session manager logs"
  }
}

resource "aws_ssm_document" "this" {
  name            = var.session_manager_document_name
  document_type   = "Session"
  document_format = "JSON"

  tags = {
    Name          = local.ssm_document_name
    ProductDomain = var.product_domain
    Description   = var.ssm_document_description
    Environment   = var.environment
    ManagedBy     = "terraform"
  }

  content = <<DOC
{
    "schemaVersion": "1.0",
    "description": "${var.ssm_document_description}",
    "sessionType": "Standard_Stream",
    "inputs": {
        "cloudWatchLogGroupName": "${local.cwl_log_group_name}",
        "cloudWatchEncryptionEnabled": false,
        "cloudWatchStreamingEnabled": true,
        "shellProfile":{
          "linux":"bash"
        }
    }
}
DOC
}

resource "aws_iam_policy" "this" {
  name   = local.iam_policy_name
  policy = data.aws_iam_policy_document.session_manager.json
}
