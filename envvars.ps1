## Environment Variables

#Profile Environment
$DevProfile='vol-opt-developer'


## Network Parameters

# Network Transit Gateway Accepter
# $TGWNetAccount=''
# $TGWID=''
# $TGRegion='us-east-1'

$devAdmRoleCred = (aws sts assume-role --role-arn "arn:aws:iam::108160666657:role/rm/opt/usr-role/opt.CloudMngAccess" --role-session-name "AWSCLI-Session-LGCC-admin" --profile $DevProfile | ConvertFrom-Json).Credentials
$env:AWS_ACCESS_KEY_ID=$devAdmRoleCred.AccessKeyId
$env:AWS_SECRET_ACCESS_KEY=$devAdmRoleCred.SecretAccessKey
$env:AWS_DEFAULT_REGION="us-east-1"
$env:AWS_SESSION_TOKEN=$devAdmRoleCred.SessionToken

aws cloudformation create-stack --stack-name "opt-dev-security" --template-body file://opt-security-stack.yml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation update-stack --stack-name "opt-dev-security" --template-body file://opt-security-stack.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation update-stack --stack-name "opt-dev-network-vpnhub" --template-body file://opt-network-vpnhub-stack.yml --capabilities CAPABILITY_NAMED_IAM


aws cloudformation validate-template --template-body file://opt-network-stack.yml
aws cloudformation create-stack --stack-name "vol-com-opt-devopsconn-dev" --template-body file://vol-com-opt-devopsconn.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation update-stack --stack-name "vol-com-opt-devopsconn-dev" --template-body file://vol-com-opt-devopsconn.yml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation delete-stack --stack-name "vol-com-opt-devopsconn-dev"
