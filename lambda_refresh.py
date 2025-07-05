import boto3
from decimal import Decimal
from datetime import datetime, timezone

autoscaling = boto3.client('autoscaling')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('EC2InstanceStates')

def lambda_handler(event, context):
    groups = autoscaling.describe_auto_scaling_groups()['AutoScalingGroups']
    for group in groups:
        autoscaling.start_instance_refresh(AutoScalingGroupName=group['AutoScalingGroupName'])
        for instance in group['Instances']:
            instance_id = instance['InstanceId']
            table.put_item(Item={
                'instance_id': instance_id,
                'state': 'refreshing',
                'last_updated': datetime.now(timezone.utc).isoformat(),
                'cost': Decimal('0.0')
            })
    return{
        'statusCode': 200,
        'body': 'Instance refresh triggered'
        }