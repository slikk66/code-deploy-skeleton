#!/bin/bash
if [ "$DEPLOYMENT_GROUP_NAME" == "Prod" ]
then
	aws elb deregister-instances-from-load-balancer --load-balancer-name PRODUCTION-LB-NAME --instances $(curl http://169.254.169.254/latest/meta-data/instance-id) --region=us-west-2 
fi

sleep 30 

service nginx stop
service php-fpm stop

