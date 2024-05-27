#!/bin/bash
# Define your Azure App Service details
RESOURCE_GROUP="your_resource_group"
APP_SERVICE_NAME="your_app_service_name"

# Read the variables from the file
while IFS='=' read -r key value; do
    # Remove spaces around the key and value
    key=$(echo $key | xargs)
    value=$(echo $value | xargs)
    
    # Remove the inverted commas from the value
    value=$(echo $value | tr -d '"')
    
    # Set the environment variable in the Azure App Service
    az webapp config appsettings set --resource-group $RESOURCE_GROUP --name $APP_SERVICE_NAME --settings $key=$value
done < variables.txt
