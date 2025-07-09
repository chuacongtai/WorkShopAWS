# Tài liệu bàn giao - Advanced EC2 Instance Lifecycle Management

## Tổng quan
- Dự án triển khai quản lý vòng đời EC2 với tự động hóa và tối ưu hóa.
- Hoàn thành từ Ngày 1 đến Ngày 7.

## Cấu hình hệ thống
- EC2: Quản lý qua ASG "EC2LifecycleASG".
- Lambda: Hàm "StopStartEC2" với State Machine "EC2LifecycleWorkflow".
- Giám sát: CloudWatch Alarms ("HighCPUAlarm", "BudgetExceedAlarm").
- Chi phí: Sử dụng Reserved Instances/Savings Plans.

## Hướng dẫn vận hành
- Kiểm tra trạng thái qua AWS Console (EC2, CloudWatch, Step Functions).
- Theo dõi cảnh báo qua email từ SNS "EC2AlertTopic".

## Liên hệ hỗ trợ
- Người phụ trách: Ngô Thành Tài
- Email: ngothanhtai12345a@gmail.com