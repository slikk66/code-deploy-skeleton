Code Deploy setup skeleton.

More information on lifecycle events and "appspec.yml" file can be found here:
	http://docs.aws.amazon.com/codedeploy/latest/userguide/app-spec-ref.html

================================================

#1 - Copy file assets/pre-push to:
		./.git/hooks/pre-push

#2 - Set executable permission on file after copy: 
		chmod +x ./.git/hooks/pre-push

#3 - Setup AWS CLI on local machine:
		http://docs.aws.amazon.com/cli/latest/userguide/installing.html

#4 - Install code deploy agent on your machine (and run it) and roles on your IAM for code deploy.  This will setup the running agent on your machine to accept and process the code deployments, and also allow the IAM role to communicate with the necessary services to permit the operations securely.
		http://docs.aws.amazon.com/codedeploy/latest/userguide/how-to-set-up-new-instance.html

#5 - Configure default profile access via AWS CLI (this will create profile "default", see step #7)
		$> aws configure

#6 - Configure your code deploy Application and deployment groups
		-Usually there will be one application (i.e. Zingo.com)
		-There will be deployment groups for each environment (i.e. master/production, and dev/qa)

#7 - Set your default global GIT variable options for this deployment:
		$>  git config codedeploy.s3bucket BUCKET_NAME_HERE   (i.e. my-code-deployments where the system will upload the payload to be deployed after each push)
		$>  git config codedeploy.source ./ (path to folder to deploy from this git repo, usually its top level.. assuming also that this skeleton is unzipped into top level)
		$>  git config codedeploy.application-name APPLICATION_NAME (i.e. Zingo.com, name of your application in AWS code deploy)
		$>  git config codedeploy.profile AWSCLI-PROFILE-NAME (i.e. default, which should be the account the CLI should look for in ~/.aws/credentials)

#8 - Set your branch dependent GIT variable options for the branch deployments:
		$>  git config codedeploy.master.active 1   (1 or 0, this turns system on for master branch auto-deployments)
		$>  git config codedeploy.master.deployment-group GROUP_NAME (i.e. production-deployment, name of the group under the application in your AWS code deploy)

		$>  git config codedeploy.qa.active 1   (1 or 0, this turns system on for master branch auto-deployments)
		$>  git config codedeploy.qa.deployment-group GROUP_NAME (i.e. qa-deployment, name of the group under the application in your AWS code deploy)

#9 - After the above is setup, pushing a commit to branch "master" or "qa" (while the system is active, step #8) will result in the source code in your repository being zipped up and uploaded to s3, and then deployed out to your servers.