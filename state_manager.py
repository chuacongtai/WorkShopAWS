import boto3
from boto3.dynamodb.conditions import Key, Attr
from decimal import Decimal
from datetime import datetime, timezone
dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('EC2InstanceStates')

def save_state(instance_id, state):
         table.put_item(Item={
             'instance_id': instance_id,
             'state': state,
             'last_updated': datetime.now(timezone.utc).isoformat(),
             'cost': Decimal('0.0')
         })

def get_state(instance_id):
         response = table.get_item(Key={'instance_id': instance_id})
         return response.get('Item')

if __name__ == "__main__":
         # Ví dụ kiểm tra
         save_state("i-1234567890abcdef0", "running")
         state = get_state("i-1234567890abcdef0")
         print(f"State of instance i-1234567890abcdef0: {state}")