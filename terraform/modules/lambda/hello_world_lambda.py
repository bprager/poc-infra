import json

def lambda_handler(event, context):
    body = json.loads(event.get('body', '{}'))
    message = body.get('message')
    responseMsg = {
        'statusCode': 200,  # Use an integer for status code
        'body': json.dumps({'message': f'Hi, your message was: {message}'}),  # JSON encode the body
        'headers': {
            'Access-Control-Allow-Origin': '*',  # Allow all origins
            'Content-Type': 'application/json'  # Set the Content-Type header
        }
    }
    return responseMsg
