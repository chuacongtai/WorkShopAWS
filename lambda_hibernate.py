import boto3
from decimal import Decimal
from datetime import datetime, timezone

ec2 = boto3.client('ec2')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('EC2InstanceStates')

def lambda_handler(event, context):
    instances = ec2.describe_instances()['Reservations']
    for reservation in instances:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            if instance['State']['Name'] == 'running' and float(instance['CpuOptions']['CoreCount']) < 1:  # Giả định điều kiện hibernate
                ec2.stop_instances(InstanceIds=[instance_id], Hibernate=True)
                table.put_item(Item={
                    'instance_id': instance_id,
                    'state': 'hibernated',
                    'last_updated': datetime.now(timezone.utc).isoformat(),
                    'cost': Decimal('0.0')
                })
    return{
          'statusCode': 200,
          'body': 'Hibernate check completed'
        }