import json
import base64
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--connection_name", help="The connection name in Looker")
args = parser.parse_args()
connection_name=args.connection_name

# Load the base64-encoded key from Terraform output
with open('service_account_key_base64.json', 'r') as file:
    service_account_key_base64_json = file.read().strip()
    service_account_key_json = json.loads(service_account_key_base64_json)
    base64_key = service_account_key_json.get("service_account_key_json").get("value")

# Decode the base64-encoded key
json_key = base64.b64decode(base64_key).decode('utf-8')

# # Parse the JSON key
key_data = json.loads(json_key)

with open("credentials_file.json", "w") as json_file:
    json.dump(key_data, json_file, indent=2)
    json_file.write("\n")

# INIT LOOKER API
import looker_sdk
from looker_sdk import models40 as models
sdk = looker_sdk.init40()
print(f"{sdk.me().get('email')} is authenticated")

with open("credentials_file.json", "rb") as f:
    cert = f.read()

cert = base64.b64encode(cert).decode("utf-8")

body = sdk.connection(connection_name)

body=models.WriteDBConnection(
    name=body.get("name"),
    database=body.get("database"),
    dialect_name="bigquery_standard_sql",
    certificate=cert,
    file_type=".json",
    )

sdk.update_connection(
    connection_name=connection_name,
    body=body
)



# in memory
# json_file_in_memory = io.StringIO()
# json.dump(key_data, json_file_in_memory, indent=2)
# json_file_in_memory.write("\n")
# json_str = json_file_in_memory.getvalue()