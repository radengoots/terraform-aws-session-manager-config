output "iam_policy_name" {
  value       = local.iam_policy_name
  description = "the name of iam policy for allowing session manager access"
}

output "iam_policy_arn" {
  value       = aws_iam_policy.this.arn
  description = "the arn of iam policy for allowing session manager access"
}

output "ssm_document_name" {
  value       = local.ssm_document_name
  description = "the name of ssm document for session manager preferences"
}
