 ## Sơ đồ Tổng thể
 ![Architecture Diagram](architecture.png)
 ## Sơ đồ Network
 ![Network Design](network_design.png)
 ## Sơ đồ Security
 ![Security Design](security_design.png)
 ## Sơ đồ Service & Resource
 ![Services & Resources](services_resources.png)
 ## Chính sách tùy chỉnh
 - Hibernation: CPU < 10% trong 30 phút, gọi `ec2.stop_instances(hibernate=True)`.
 - Stop/Start: Stop 18h, start 8h, dùng CloudWatch Events cron.
 - Instance Refresh: AMI > 30 ngày hoặc CPU > 80%, trigger `start_instance_refresh`.
 ## Chi tiết bảo mật
 - **IAM Role (LambdaEC2Role)**: Least privilege (ec2:Start/Stop/Describe, dynamodb:Put/Get/Update, ce:GetCost, autoscaling:Refresh, sns:Publish).
 - **Security Groups**:
   - EC2: Allow Lambda (TCP:22/80), CloudWatch Metrics.
   - Lambda: Outbound to EC2, DynamoDB, SNS, Cost Explorer (HTTPS:443).
 - **VPC Endpoints**: Private access to DynamoDB, SNS, Cost Explorer (optional).
 - **Encryption**: DynamoDB/SNS/EBS encrypted at rest (KMS); in-transit (TLS).
 - **Monitoring**:
   - CloudWatch Metrics: CPUUtilization, StatusCheckFailed from EC2.
   - CloudWatch Alarms: Trigger SNS on SLA < 99.9%, CPU > 80%.
   - CloudWatch Logs: Receives logs from Lambda and EC2, encrypted with KMS.
   - CloudTrail: Records API calls, stored in S3 (KMS-encrypted).
 ## Chi tiết Network
 - **VPC**: 10.0.0.0/16.
 - **Subnets**: Public (10.0.1.0/24, Lambda), Private (10.0.2.0/24, EC2, DynamoDB).
 - **Internet Gateway**: Cho Public Subnet (Cost Explorer, SNS public).
 - **VPC Endpoints**: DynamoDB, SNS.
 - **Security Groups**: EC2 (Inbound: Lambda), Lambda (Outbound: EC2, VPC Endpoints).
 ## Triển khai Ngày 2
 - **IAM Role**: Tạo `LambdaEC2Role` với quyền quản lý EC2, DynamoDB, CloudWatch, Cost Explorer, Auto Scaling, SNS.
 - **DynamoDB**: Tạo bảng `EC2InstanceStates` với partition key `instance_id`.
 - **Script Python**: `state_manager.py` để lưu và lấy trạng thái EC2.
 - **CloudWatch Alarms**: 
   - `HighCPUAlarm`: CPU > 80% trong 60 phút, thông báo qua SNS.
   - `SLAAlarm`: StatusCheckFailed > 0 trong 5 phút, thông báo qua SNS.
 - **Ngày 2 hoàn thành**: 04:53 PM +07, July 04, 2025.