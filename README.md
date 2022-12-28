# DevOpsECE2022

## Introduction
This is the GitHub repository of Etienne Coutenceau and Alexandre Nguyen for the DevOps Introduction Class of the ECE 2022 for ING4 Apprentis.

This repository is composed of 2 parts:
   - the Labs,
   - the Project. 

In the Labs part, you will be able to find the labs 3,5,6,7 and 8 as well as the completed part of the exercises files. 

In the project part you will be able to find :
   - The userapi which contain a web application, a Dockerfile and the deployement and service files for kubernetes deployement,
   - The iac which contain the Vagrant installation and deployement of the userapi,
   - The workflows that allow the CI of the application,
   - The docker compose who contain the parameters for a docker-compose deployement.
## Labs
In this class we learned about different aspect of DevOps using different labs. You can find the original [here](https://github.com/adaltas/ece-devops-2022-fall).

You will find in this repository, the finished labs that needed the completed files.
## Project
The project is about integrating the labs on a web application. You can find the instructions [here](https://github.com/adaltas/ece-devops-2022-fall/blob/main/project/instructions.md).

We applied the labs in their orders. We will describe the different building methods and CI we used in this document.
### Web application

### CI/CD

### Provisionning a virtual environnement

In this section, we will use Vagrant and Ansible to create and provision a Virtual Machine running on CentOS 7.

Download Vagrant and Virtualbox

To use the Synced folders you have to use the plugin vagrant-vbguest version 0.21
```bash
vagrant plugin uninstall vagrant-vbguest
vagrant plugin install vagrant-vbguest --version 0.21
```
Go to the directory `/Project/userapi` and execute the `vagrant up` command. It will start to creat the VM with the config in the Vagrantfile in the folder

You can execute `curl localhost:3000` and see the response `Hello World!` showing that the web app is correctly exposed and configured.

Executing the following command will create a user on the hosted web app:
```bash
curl --header "Content-Type: application/json" --request POST --data '{"username":"sergkudinov","firstname":"sergei","lastname":"kudinov"}' http://localhost:3000/user
```
The response should be this is everything is correctly configured:
```bash
{"status":"success","msg":"OK"}
```

### Container image
In order to manage the container images for the deployment of the web application, you need to install Docker Desktop.
Follow the installation instructions for Windows installation here : https://docs.docker.com/desktop/install/windows-install/
Or the installation instructions for Linux here : https://docs.docker.com/desktop/install/linux-install/

Once you have installed Docker locate yourself in the project directory.
From here, you need to build the web application :
```bash
docker build -t userapi userapi
```
You can check if the image have been created on the UI of Docker Desktop or using this command :
```bash
docker images
```
![docker images](/images/docker.png "docker image")

If the image exist, you now need to run the container :
```bash
docker run -p 5000:3000 -d userapi
```
You can check if the container has been run successfully by doing a curl request on the port 5000 :
```bash
curl localhost:5000
```
You will get this result :`Hello World!`

Next, we are going to make our container available online. First, you need to create an account on [Docker Hub](https://hub.docker.com/).
Then you need to tag the container :
```
   docker tag userapi <DOCKER_ACCOUNT_NAME>/<CUSTOM_IMAGE_NAME>
```
where `DOCKER_ACCOUNT_NAME` - is your account on Docker Hub, `CUSTOM_IMAGE_NAME` - the custom name of the image (we initialised it as "userapi").

Then log into Docker Hub from the terminal : 
   ```
   docker login
   ```
And push the docker image :
   ```
   docker push <DOCKER_ACCOUNT_NAME>/<CUSTOM_IMAGE_NAME>
   ```
If everything went right, you will be able to see the image in your [docker hub repositories](https://hub.docker.com/repositories)
![docker hub images](/images/dockerHub.png "docker hub")

When you are finished, stop de container with the following commands :
`docker ps` in order to get the id of the countainer.
`docker stop <CONTAINER_ID>` to stop the container.

### Container Orchestration
In this part, we will show you how to orchestrate multiple docker using Docker Compose or Kubernetes
#### Docker Compose
If you already have installed Docker, Docker Compose should be installed as well.
From the project directory run 
```docker-compose up```
If no error appears, you should see `Hello World!` when you visit `localhost:5000` as well as seeing the image with `docker images`

![docker compose images](/images/dockerCompose.png "docker compose")

#### Kubernetes
In order to do a kubernetes orchestration, you need to install [Minikube] (https://minikube.sigs.k8s.io/docs/start/)
Once installed, start it: 
```minikube start --driver=docker```
And verify that it's status is OK:
```minikube status```
![minikube status](/images/minikubeStatus.png "minikube status")
Now you need to apply the deployment file and the service file :
```
kubectl apply -f userapi\deployment.yaml
kubectl apply -f userapi\service.yaml
```
**Note! The deployment.yaml file is linked to etiennectc dockerhub account. If you want to change the origin of the image you have to change the reference in the yaml file.**

You should see 3 pods :

![3 pods id](/images/3pods.png "3 Pods")

And you should be able to connect to `localhost:3000` and see `Hello Worl!`.
### Service mesh

### Monitoring


