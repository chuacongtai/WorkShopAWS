import boto3
from datetime import datetime, timezone

ec2 = boto3.client('ec2')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('EC2InstanceStates')

def lambda_handler(event, context):
    instances = ec2.describe_instances()['Reservations']
    for reservation in instances:
        for instance in reservation['Instances']:
              instance_id = instance['InstanceId']
              state = 'stopped' if datetime.now(timezone.utc).hour == 18 else 'running'
              ec2.stop_instances(InstanceIds=[instance_id]) if state == 'stopped' else ec2.start_instances(InstanceIds=[instance_id])
              table.put_item(Item={
                  'instance_id': instance_id,
                  'state': state,
                  'last_updated': datetime.now(timezone.utc).isoformat(),
                  'cost': Decimal('0.0')
              })
    return {
          'statusCode': 200,
          'body': f'State updated to {state} for all instances'
      }