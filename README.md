# DevOpsECE2022

## Introduction

## Labs

## Project

### Web application

### CI/CD

### Provisionning a virtual environnement

Utiliser le plugin vagrant-vbguest version 0.21
vagrant plugin uninstall vagrant-vbguest
vagrant plugin install vagrant-vbguest --version 0.21

### Container image
In order to manage the container images for the deployement of the web application you need to install Docker Desktop.
Follow the installation instructions for Windows installation here : https://docs.docker.com/desktop/install/windows-install/
Or the installation instructions for Linux here : https://docs.docker.com/desktop/install/linux-install/

Once you have installed Docker locate yourself in the project directory.
From here you need to build the web application :
```bash
docker build -t userapi userapi
```
You can check if the image have been created on the UI of Docker Desktop or using this command :
```bash
docker images
```
If the image exist you now need to run the container :
```bash
docker run -p 5000:3000 -d userapi
```
You can check if the container have been run successfully by doing a curl request on the port 5000 :
```bash
curl localhost:5000
```
You will get this result :`Hello World!`

Next we are going to make our container available online. First you need to create an account on [Docker Hub](https://hub.docker.com/).
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
If everything went right you will be able to see the image in your [docker hub repositories](https://hub.docker.com/repositories)

When you are finished stop de container with the following commands :
`docker ps` in order to get the id of the countainer.
`docker stop <CONTAINER_ID>` to stop the container.

### Container Orchestration
In this part we will show you how to orchestrate multiple docker using Docker Compose or Kubernetes
#### Docker Compose
If you already have installed Docker, Docker Compose should be installed as well.
From the project directory run ```docker-compose up```
If no error appears you should see `Hello World!` when you visit `localhost:5000`
#### Kubernetes
In order to do a kubernetes orchestration you need to install [Minikube] (https://minikube.sigs.k8s.io/docs/start/)
Once installed start it: 
```minikube start --driver=docker
```
And verify that it's status is OK:
```minikube status
```
Now you need to apply the deployement file and the service file :
```
kubectl apply -f userapi\deployment.yaml
kubectl apply -f userapi\service.yaml
```
You should see 3 pods :
""insert screen pods""
And you should be able to connect to `localhost:3000` and see `Hello Worl!`.
### Service mesh

### Monitoring


