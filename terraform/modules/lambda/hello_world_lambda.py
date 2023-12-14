import json

def lambda_handler(event, context):
    body = json.loads(event.get('body', '{}'))
    message = body.get('message')
    responseMsg = {
        'statusCode' : '200',
        'body': f'Hi, your message was: {message} ',
        'headers' : {
            'Access-Control-Allow-Origin' : '*'
        }
    }
    return responseMsg
