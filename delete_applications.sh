#!/bin/bash

# HowTo
#
# 0. Check it for your account first just in case
# 1. Make the script executable: `chmod +x delete_applications.sh`
# 2. Change API_KEY="api_key"
# 3. Populate the list.csv
# 4. Cross your fingers
# 5. Run it './delete_applications.sh list.csv'
# 6. Now they're gone. Pray that you deleted the correct applications

API_ENDPOINT="https://api.pushwoosh.com/json/1.3/deleteApplication"
API_KEY="api_key"

# Check if the file path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# Read each line from the file
while IFS=, read -r application_id; do
    # Construct JSON payload with the extracted application ID
    json_payload="{\"request\": {\"auth\": \"$API_KEY\", \"application\": \"$application_id\"}}"

    # Send POST request to the API endpoint
    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_payload" "$API_ENDPOINT")

    # Print the response
    echo "Response for application $application_id:"
    echo "$response"
    echo "--------------------------------------"
done < "$1"
