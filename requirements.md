Chức năng:
    -Quản lý trạng thái EC2 (running, stopped, hibernated) trong DynamoDB.
    -Hibernation khi CPU < 10% trong 30 phút.
    -Stop instances lúc 18h, start lúc 8h.
    -Instance refresh nếu AMI lỗi thời (>30 ngày) hoặc CPU > 80% trong 1 giờ.
    -Theo dõi chi phí EC2 qua Cost Explorer.
    -Giám sát hiệu suất (CPU, disk, memory) qua CloudWatch.
    -Đảm bảo SLA uptime 99.9% với thông báo SNS.
    -Kiểm thử tự động cho Lambda functions và pipeline.
Phi chức năng: Uptime 99.9%, lưu trữ bền vững, bảo mật với IAM.