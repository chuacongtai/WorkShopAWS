$jsonContent = '[{"Id":"1","Arn":"arn:aws:lambda:ap-southeast-1:572498579257:function:StopStartEC2"}]'
# Tạo file targets cho StopStartRule
$stopStartJson = '[{\"Id\":\"1\",\"Arn\":\"arn:aws:lambda:ap-southeast-1:572498579257:function:StopStartEC2\"}]'
[System.IO.File]::WriteAllLines("stop_start_targets.json", $stopStartJson, (New-Object System.Text.UTF8Encoding($False)))

# Tạo Rule StopStartRule
aws events put-rule --name StopStartRule --schedule-expression "cron(0 10 * * ? *)" --state ENABLED

# Thêm Target cho StopStartRule
aws events put-targets --rule StopStartRule --targets file://C:\Users\Admin\Desktop\WS\stop_start_targets.json

# Thêm Permission cho Lambda
aws lambda add-permission --function-name StopStartEC2 --statement-id StopStartPermission --action lambda:InvokeFunction --principal events.amazonaws.com --source-arn arn:aws:events:ap-southeast-1:572498579257:rule/StopStartRule

# Tạo file targets cho HibernateRule

$hibernateJson = '[{\"Id\":\"1\",\"Arn\":\"arn:aws:lambda:ap-southeast-1:572498579257:function:HibernateEC2\"}]'
[System.IO.File]::WriteAllLines("hibernate_targets.json", $hibernateJson, (New-Object System.Text.UTF8Encoding($False)))

# Tạo Rule HibernateRule
aws events put-rule --name HibernateRule --schedule-expression "cron(0 9 * * ? *)" --state ENABLED

# Thêm Target cho HibernateRule
aws events put-targets --rule HibernateRule --targets file://C:\Users\Admin\Desktop\WS\hibernate_targets.json

# Thêm Permission cho Lambda
aws lambda add-permission --function-name HibernateEC2 --statement-id HibernatePermission --action lambda:InvokeFunction --principal events.amazonaws.com --source-arn arn:aws:events:ap-southeast-1:572498579257:rule/HibernateRule

# Tạo file targets cho RefreshRule
$refreshJson = '[{\"Id\":\"1\",\"Arn\":\"arn:aws:lambda:ap-southeast-1:572498579257:function:RefreshEC2\"}]'
[System.IO.File]::WriteAllLines("refresh_targets.json", $refreshJson, (New-Object System.Text.UTF8Encoding($False)))

# Tạo Rule RefreshRule
aws events put-rule --name RefreshRule --schedule-expression "cron(0 0 ? * SUN *)" --state ENABLED

# Thêm Target cho RefreshRule
aws events put-targets --rule RefreshRule --targets file://C:\Users\Admin\Desktop\WS\refresh_targets.json

# Thêm Permission cho Lambda
aws lambda add-permission --function-name RefreshEC2 --statement-id RefreshPermission --action lambda:InvokeFunction --principal events.amazonaws.com --source-arn arn:aws:events:ap-southeast-1:572498579257:rule/RefreshRule

# Tạo file targets cho CostTrackerRule
$costTrackerJson = '[{\"Id\":\"1\",\"Arn\":\"arn:aws:lambda:ap-southeast-1:572498579257:function:CostTrackerEC2\"}]'
[System.IO.File]::WriteAllLines("cost_tracker_targets.json", $costTrackerJson, (New-Object System.Text.UTF8Encoding($False)))

# Tạo Rule CostTrackerRule
aws events put-rule --name CostTrackerRule --schedule-expression "cron(0 8 * * ? *)" --state ENABLED

# Thêm Target cho CostTrackerRule
aws events put-targets --rule CostTrackerRule --targets file://C:\Users\Admin\Desktop\WS\cost_tracker_targets.json

# Thêm Permission cho Lambda
aws lambda add-permission --function-name CostTrackerEC2 --statement-id CostTrackerPermission --action lambda:InvokeFunction --principal events.amazonaws.com --source-arn arn:aws:events:ap-southeast-1:572498579257:rule/CostTrackerRule