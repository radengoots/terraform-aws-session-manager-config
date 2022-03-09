data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_role" "s3_delete_allowed_role" {
  name = var.s3_delete_permission_role_name
}

data "aws_iam_policy_document" "session_manager" {
  # This policy is mostly copied from arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM version 8
  # Update the statement to allow cloudwatch logs as logs destination.
  statement {
    sid    = "AllowSSMActions"
    effect = "Allow"

    actions = [
      "ssm:DescribeAssociation",
      "ssm:DescribeDocument",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:GetManifest",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:PutInventory",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowEC2Messages"
    effect = "Allow"

    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowSSMMessages"
    effect = "Allow"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "AllowCloudWatchPutMetrics"
    effect    = "Allow"
    actions   = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }

  statement {
    sid       = "AllowEC2DescribeInstanceStatus"
    effect    = "Allow"
    actions   = ["ec2:DescribeInstanceStatus"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowCWLLogging"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      aws_cloudwatch_log_group.this.arn,
      "${aws_cloudwatch_log_group.this.arn}:log-stream:*"
    ]
  }

  statement {
    sid    = "AllowCWLReadAccess"
    effect = "Allow"

    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}
