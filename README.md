"# github-3.5-soon-node-docker-ecr" 

# This repository contains the step-by-step instructions to publish Docker images to Elastic Container Registry.

## Step 1

We reused the Node application which we tested previously at repository https://github.com/sunnymoon1314/github-3.4-soon-node-docker. The same Node application (index.js) is also found in the current folder at https://github.com/sunnymoon1314/github-3.5-soon-node-docker-ecr.

As the first step, we test build the Docker image based on this Node application using the command:

``` Command Prompt
docker build -t github-3.5-soon-node-docker-ecr:1.0 .
```
![alt text](images/docker_build.png)

We are able to build the image and this shows we are ready to register the same Docker image to the Elastic Container Registry.

## Step 2

### Step 2.1

Next, login to the AWS Management Console, and at the Services search textbox, enter ecr. Then select the __Elastic Container Registry__ that appeared as the first item from the Services list.

![alt text](images/aws_console_services.png)

### Step 2.2

Select __Public registry/Repositories__ from the left navigation panel, and click the __Create repository__ button.

![alt text](images/ecr_public_repository_create.png)

### Step 2.3

Enter/Specify the following values in the __Create repository__ page:

- General settings: Public
- Detail: public.ecr.aws/u2q1a2y8/soon-node-docker-ecr-20240422
- Short description: Docker image to be saved to the Elastic Container Registry.
- Operating systems: Windows

Then click the __Create repository__ button.

![alt text](images/ecr_create_repository_1_of_2.png)

![alt text](images/ecr_create_repository_2_of_2.png)

## Step 3

Back to the __Public repositories__ page, select the newly created repository (soon-node-docker-ecr-20240422) and click the __View push commands__ button.

![alt text](images/ecr_public_repository_view_push_commands.png)

## Step 4

Following the steps in the __Push commands...__ page to register the Docker image to the Elastic Container Registry:

![alt text](images/ecr_push_commands.png)

### Step 4.1

Retrieve an authentication token and authenticate your Docker client to your registry using the AWS CLI:

``` Command Prompt
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/u2q1a2y8
```

![alt text](images/aws_cli_error.png)
The command did not work for the first run. We need to go to the docker config file at  C:\Users\your_username\\.docker\config.json. And delete "credsStore": "desktop"

![alt text](images/docker_config_to_delete_credsstore.png)

Run the preceding command again after updating the config.json file. The command works this time.

![alt text](images/aws_cli_ok.png)

### Step 4.2

Build your Docker image using the following command.

``` Command Prompt
docker build -t soon-node-docker-ecr-20240422 .
```

![alt text](images/docker_build_2.png)

### Step 4.3

After the build completes, tag your image so you can push the image to this repository:

``` Command Prompt
docker tag soon-node-docker-ecr-20240422:latest public.ecr.aws/u2q1a2y8/soon-node-docker-ecr-20240422:latest
```

![alt text](images/docker_tag.png)
### Step 4.4

Run the following command to push this image to your newly created AWS repository:

``` Command Prompt
docker push public.ecr.aws/u2q1a2y8/soon-node-docker-ecr-20240422:latest
```

![alt text](images/docker_push.png)

## Step 5

The same Docker image (github-3.5-soon-node-docker-ecr:1.0) can now be accessed from the Elastic Container Registry using the URI:
public.ecr.aws/u2q1a2y8/soon-node-docker-ecr-20240422:latest

Lets see whether there are any Docker images found in the local Docker repository of my second laptop:

![alt text](images/docker_images.png)

The screenshot shows there is only one image and it is the image created previously for Module 3.4 assignment.

Run the below command to pull the ECR image from AWS and use it to spin up a container.

``` Command Prompt
docker run -dp 8080:3000 --name soon-node-docker-ecr-20240422 public.ecr.aws/u2q1a2y8/soon-node-docker-ecr-20240422:latest
```

![alt text](images/docker_run_test.png)

The above screenshot shows that we are able to spin off a container using the Docker image that we registered at the Elastic Container Registry.

List the local images again and see what we have:

![alt text](images/docker_images_2.png)

We can see there are now 2 Docker images found in the local Docker repository of my second laptop.

# End Of Document
"# soon-node-docker-ecr-module-3.14" 
