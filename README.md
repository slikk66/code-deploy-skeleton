# Code Deploy setup skeleton.

More information on lifecycle events and "appspec.yml" file can be found here:
<http://docs.aws.amazon.com/codedeploy/latest/userguide/app-spec-ref.html>

# Set up

## Set up AWS

### 1 - Create an S3 bucket for deployments.

This can be done through the AWS console.

### 2 - Install code deploy agent on your instance(s) (and run it) and roles on your IAM for code deploy

This will setup the running agent on your machine to accept and process the
code deployments, and also allow the IAM role to communicate with the necessary
services to permit the operations securely.

<http://docs.aws.amazon.com/codedeploy/latest/userguide/how-to-set-up-new-instance.html>

## Set up local system

### 1 - In your local git repository, copy file `assets/pre-push` to the git hooks directory

    $ cp assets/pre-push .git/hooks/pre-push

### 2 - Set executable permission on file after copy

    $ chmod +x ./.git/hooks/pre-push

### 3 - Setup AWS CLI on local machine

<http://docs.aws.amazon.com/cli/latest/userguide/installing.html>

### 4 - Configure default profile access via AWS CLI (this will create profile "default", see step #6)

    $ aws configure

### 5 - Configure your code deploy Application and deployment groups

Usually there will be one application (i.e. Zingo.com).   There will be
deployment groups for each environment.  Name your deployment groups "Prod" and
"QA".

### 6 - Set your default global GIT variable options for this deployment:

Set the S3 bucket name (i.e. my-code-deployments where the system will upload
the payload to be deployed after each push)

    $ git config codedeploy.s3bucket BUCKET_NAME_HERE

Set the deployment path in your repo, usually its top level.  This is the path
in the repo that should be deployed (should include the appspec.yml and scripts
folders).

    $ git config codedeploy.source ./

Set the application name (i.e. Zingo.com, name of your application in AWS code
deploy):

    $ git config codedeploy.application-name APPLICATION_NAME

Set command line profile to use (i.e. "default", which should be the account
the CLI should look for in ~/.aws/credentials):

    $ git config codedeploy.profile AWSCLI-PROFILE-NAME

### 7 - Set your branch dependent GIT variable options for the branch deployments:

    $ git config codedeploy.master.active 1   (1 or 0, this turns system on for master branch auto-deployments)
    $ git config codedeploy.master.deployment-group Prod

    $ git config codedeploy.qa.active 1   (1 or 0, this turns system on for master branch auto-deployments)
    $ git config codedeploy.qa.deployment-group QA

### 8 - Test out a deployment

After the above is setup, pushing a commit to branch "master" or "qa" (while
the system is active, step #7) will result in the source code in your
repository being zipped up and uploaded to s3, and then deployed out to your
servers.
