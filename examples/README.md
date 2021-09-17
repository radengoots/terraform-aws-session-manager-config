# Example

## Usage
```sh
terraform init
terraform plan
terraform apply
```

if you get the error "Conflicting conditional operations are currently in progress against this resource" from Amazon S3 when you try this module, 
you can solve this problem by running 'terraform apply' again.
https://aws.amazon.com/premiumsupport/knowledge-center/s3-conflicting-conditional-operation/
