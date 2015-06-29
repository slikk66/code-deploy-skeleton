#!/bin/bash

sleep 60

service nginx restart
service php-fpm restart

if [ "$DEPLOYMENT_GROUP_NAME" == "Prod" ]
then
	aws elb register-instances-with-load-balancer --load-balancer-name PRODUCTION-LB-NAME --instances $(curl http://169.254.169.254/latest/meta-data/instance-id) --region=us-west-2
fi

