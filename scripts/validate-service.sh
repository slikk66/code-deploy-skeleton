#!/bin/bash
if [ "$DEPLOYMENT_GROUP_NAME" == "Prod" ]
then

	while /bin/true; do

		aws elb describe-instance-health --load-balancer-name lb-cm-prod-loadbalancer --instances $(curl http://169.254.169.254/latest/meta-data/instance-id) --region=us-west-2 | grep -q '"InService"'

        if [[ $? == 0 ]]; then
            exit 0;
        fi

		sleep 30

    done;

fi
