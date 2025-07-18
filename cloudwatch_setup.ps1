aws sns create-topic --name SLAAlerts
aws sns subscribe --topic-arn arn:aws:sns:ap-southeast-1:572498579257:SLAAlerts --protocol email --notification-endpoint ngothanhtai12345a@gmail.com
aws cloudwatch put-metric-alarm --alarm-name HighCPUAlarm --metric-name CPUUtilization --namespace AWS/EC2 --threshold 80 --comparison-operator GreaterThanThreshold --evaluation-periods 12 --period 300 --statistic Average --alarm-actions arn:aws:sns:ap-southeast-1:572498579257:SLAAlerts
aws cloudwatch put-metric-alarm --alarm-name SLAAlarm --metric-name StatusCheckFailed --namespace AWS/EC2 --threshold 0 --comparison-operator GreaterThanThreshold --evaluation-periods 1 --period 300 --statistic Maximum --alarm-actions arn:aws:sns:ap-southeast-1:572498579257:SLAAlerts
