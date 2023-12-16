#!/usr/bin/env python3
import os
import logging
import subprocess
import json

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s.%(msecs)03d %(levelname)s %(name)s - %(funcName)s:%(lineno)d: %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
FRONTEND_DIR = f"{SCRIPT_DIR}/../frontend"
LAMBDA_DIRS = f"{SCRIPT_DIR}/../lambda"

def main():
    # switch to terraform directory
    os.chdir(f"{SCRIPT_DIR}/../terraform")
    # generate json output
    out = subprocess.run(["terraform", "output", "-json"], capture_output = True, text = True).stdout
    results = json.loads(out)
    logging.debug(f"terraform outputs: {results}")
    # creating the config file for the frontend
    config = {}
    config["API_URL"] = results["api_endpoint"]["value"]
    # config["ClientId"] = results["cognito_user_pool_client_id"]["value"]
    # config["UserPoolId"] = results["cognito_user_pool_id"]["value"]
    config["MethodPath"] = results["ressource_endpoint"]["value"]
    logging.debug(f"config: {config}")
    # write the config file
    relpath = os.path.relpath(FRONTEND_DIR, os.getcwd())
    with open(f"{relpath}/src/config.json", "w") as outfile:
        logging.debug(f"writing {relpath}/src/config.json: {config}")
        outfile.write(json.dumps(config, indent=4))
    return
    # creating the config file for lambda functions
    config = {}
    config["TableName"] = results["dynamodb_table_name"]["value"]
    # write the lambda config files
    for (root, dirs, _) in os.walk(LAMBDA_DIRS):
        for dir in dirs:
            relpath = os.path.relpath(root + "/" + dir, os.getcwd())
            with open(f"{relpath}/config.json", "w") as outfile:
                logging.debug(f"writing {relpath}/config.json: {config}")
                outfile.write(json.dumps(config, indent=4))
    
    

if __name__ == "__main__":
    main()

