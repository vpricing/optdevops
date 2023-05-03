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
$DevNavPrivateCIDR='/16'
$DevNavPublicCIDR='/16'
$DevOptProjectCIDR='/16'
$UatNavPrivateCIDR='/16'
$UatNavPublicCIDR='/16'
$UatOptProjectCIDR='/16'
$ProdNavPrivateCIDR='/16'
$ProdNavPublicCIDR='/16'
$ProdOptProjectCIDR='/16'

# Transit Gateway Accepter
$TGWNetAccount=''
$TGWID=''
$TGRegion='us-east-1'

$devAdmRoleCred = aws sts assume-role --role-arn "arn:aws:iam::108160666657:role/rm/opt/usr-role/opt.CloudMngAccess" --role-session-name "CloudMngAccessCLI" --profile $DevProfile