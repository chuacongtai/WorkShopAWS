import boto3
from decimal import Decimal
from datetime import datetime, timezone

costexplorer = boto3.client('ce')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('EC2InstanceStates')

def lambda_handler(event, context):
    response = costexplorer.get_cost_and_usage(
        TimePeriod={'Start': '2025-07-01', 'End': '2025-07-05'},
        Granularity='DAILY',
        Metrics=['UnblendedCost']
    )
    for instance in table.scan()['Items']:
        instance_id = instance['instance_id']
        cost = response['ResultsByTime'][0]['Total']['UnblendedCost']['Amount']
        table.update_item(
            Key={'instance_id': instance_id},
            UpdateExpression='SET cost = :c',
            ExpressionAttributeValues={':c': Decimal(cost)}
        )
    return{
        'statusCode': 200,
        'body': 'Cost tracked and updated'
        }