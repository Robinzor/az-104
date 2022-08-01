# create variables
export RESOURCE_GROUP=learn-bf81cb3a-e54d-4539-9cd1-8aec43877798
export AZURE_REGION=centralus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM

# list resourcegroups in table
az group list --output table

# create free serice plan
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE

#  list serviceplan
az appservice plan list --output table