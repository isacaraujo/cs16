STACK_NAME ?= counter-strike-16-dedicated-server
TEMPLATE_FILE ?= cloudformation-template.yaml
INSTANCE_TYPE ?= t2.micro
AMI ?= ami-077d5d3682940b34a

launch:
	@test ${KEYPAIR} || { echo KEYPAIR not set; exit 1; }
	@test ${AVAILABILITY_ZONE} || { echo AVAILABILITY_ZONE not set; exit 1; }
	@test ${VPC_ID} || { echo VPC_ID not set; exit 1; }
	@test ${SUBNET_ID} || { echo SUBNET_ID not set; exit 1; }
	@test ${SERVER_NAME} || { echo SERVER_NAME not set; exit 1; }
	@test ${ADMIN_STEAM} || { echo ADMIN_STEAM not set; exit 1; }
	@test ${RCON_PASSWORD} || { echo RCON_PASSWORD not set; exit 1; }
	@test ${SERVER_PASSWORD} || { echo SERVER_PASSWORD not set; exit 1; }

	aws cloudformation create-stack \
		--stack-name $(STACK_NAME) \
		--template-body file://$(TEMPLATE_FILE) \
		--parameters \
			ParameterKey=ServerName,ParameterValue=$(SERVER_NAME) \
			ParameterKey=SteamId,ParameterValue=$(ADMIN_STEAM) \
			ParameterKey=RconPassword,ParameterValue=$(RCON_PASSWORD) \
			ParameterKey=ServerPassword,ParameterValue=$(SERVER_PASSWORD) \
			ParameterKey=InstanceType,ParameterValue=$(INSTANCE_TYPE) \
			ParameterKey=InstanceImage,ParameterValue=$(AMI) \
			ParameterKey=Keypair,ParameterValue=$(KEYPAIR) \
			ParameterKey=AvailabilityZone,ParameterValue=$(AVAILABILITY_ZONE) \
			ParameterKey=SubnetId,ParameterValue=$(SUBNET_ID) \
			ParameterKey=VpcId,ParameterValue=$(VPC_ID) && \
	aws cloudformation wait stack-create-complete --stack-name $(STACK_NAME) && \
	aws cloudformation describe-stacks \
		--stack-name $(STACK_NAME) \
		--query 'Stacks[*].{InstanceId:Outputs[0].OutputValue,PublicIp:Outputs[1].OutputValue,PublicDNS:Outputs[2].OutputValue}' \
		--output table

destroy:
	aws cloudformation delete-stack --stack-name $(STACK_NAME) && \
	aws cloudformation wait stack-delete-complete --stack-name $(STACK_NAME)

.PHONY: launch destroy