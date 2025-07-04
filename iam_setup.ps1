# aws iam create-role --role-name LambdaEC2Role --assume-role-policy-document file://C:\Users\Admin\Desktop\WS\trust-policy.json
aws iam attach-role-policy --role-name LambdaEC2Role --policy-arn arn:aws:iam::572498579257:policy/LambdaBasicLoggingPolicy
aws iam put-role-policy --role-name LambdaEC2Role --policy-name EC2Policy --policy-document file://C:\Users\Admin\Desktop\WS\ec2-policy.json