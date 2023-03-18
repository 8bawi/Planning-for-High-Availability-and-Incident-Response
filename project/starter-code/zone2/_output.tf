output "account_id" {
   value = data.aws_caller_identity.current.account_id
 }

 output "caller_arn" {
   value = data.aws_caller_identity.current.arn
 }

 output "caller_user" {
   value = data.aws_caller_identity.current.user_id
 }
  output "vpc_west" {
   value = data.terraform_remote_state.vpc.outputs.vpc_id
 }
  output "subnet_west" {
   value = data.terraform_remote_state.vpc.outputs.public_subnet_ids
 }