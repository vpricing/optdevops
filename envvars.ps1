## Environment Variables

#Profile Environment
$DevAccount=''
$DevProfile='vol-opt-developer'
$UatAccount=''
$UatProfile=''
$ProdAccount=''
$ProdProfile=''
$DevOpsAccount=''
$DevOpsProfile=''

## Network Parameters
# CIDR
$DevNavPrivateCIDR="10.111.0.0/16"
$DevNavPublicCIDR='10.112.0.0/16'
$DevOptProjectCIDR="10.106.0.0/16"
$UatNavPrivateCIDR="10.113.0.0/16"
$UatNavPublicCIDR="10.114.0.0/16"
$UatOptProjectCIDR="10.115.0.0/16"
$ProdNavPrivateCIDR="10.116.0.0/16"
$ProdNavPublicCIDR="10.117.0.0/16"
$ProdOptProjectCIDR="10.118.0.0/16"

# Transit Gateway Accepter
$TGWNetAccount=''
$TGWID=''
$TGRegion='us-east-1'

$devAdmRoleCred = (aws sts assume-role --role-arn "arn:aws:iam::108160666657:role/rm/opt/usr-role/opt.CloudMngAccess" --role-session-name "AWSCLI-Session-LGCC-admin" --profile $DevProfile | ConvertFrom-Json).Credentials
$env:AWS_ACCESS_KEY_ID=$devAdmRoleCred.AccessKeyId
$env:AWS_SECRET_ACCESS_KEY=$devAdmRoleCred.SecretAccessKey
$env:AWS_DEFAULT_REGION="us-east-2"
$env:AWS_SESSION_TOKEN=$devAdmRoleCred.SessionToken

aws cloudformation create-stack --stack-name "opt-dev-security" --template-body file://opt-security-stack.yml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation update-stack --stack-name "opt-dev-security" --template-body file://opt-security-stack.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation validate-template --template-body file://opt-network-stack.yml
aws cloudformation create-stack --stack-name "opt-dev-network" --template-body file://opt-network-stack.yml --capabilities CAPABILITY_NAMED_IAM --parameter ParameterKey=TGRegion,ParameterValue=us-east-2 ParameterKey=TGatewayId,ParameterValue=tgw-08ef88e69dcd07c7a ParameterKey=TGAccountId,ParameterValue=072515348649 ParameterKey=NavPrivCIDR,ParameterValue="10.111.0.0/16" ParameterKey=NavPubCIDR,ParameterValue="10.112.0.0/16" ParameterKey=ProjectCIDR,ParameterValue='10.106.0.0/16'

aws cloudformation update-stack --stack-name "opt-dev-network" --template-body file://opt-network-stack.yml --capabilities CAPABILITY_NAMED_IAM --parameter ParameterKey=TGRegion,ParameterValue=us-east-2 ParameterKey=TGatewayId,ParameterValue=tgw-08ef88e69dcd07c7a ParameterKey=TGAccountId,ParameterValue=072515348649 ParameterKey=NavPrivCIDR,ParameterValue="10.111.0.0/16" ParameterKey=NavPubCIDR,ParameterValue="10.112.0.0/16" ParameterKey=ProjectCIDR,ParameterValue='10.106.0.0/16'
aws cloudformation delete-stack --stack-name "opt-dev-network"

aws cloudformation create-stack --stack-name "opt-dev-network-vpnhub" --template-body file://opt-network-vpnhub-stack.yml --capabilities CAPABILITY_NAMED_IAM