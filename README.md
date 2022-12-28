# README with report and screenshots

Author : KARDOUS Kilan / LETOQUART Pierre-Louis

## 1. Web Application

- CRUD Application

The application allows reading, modifying, adding and deleting users through a route and controllers.

In the main folder we have the source code to launch the server and the application. And in the second folder, there are the files to run all tests, to check if the application works correctly. 

In addition, the applicatin uses a redis database than can store all the added elements of the application.

You have to install redis-server :

```bash
$ sudo apt update
$ sudo apt install redis-server
```

Install all the ressoucres of the application :

```bash
$ cd userapi
$ npm install
```

For running the app and the test :

```bash
# run the application
$ npm start
# run the tests
$ npm test
```

By using : "npm start", we have the app on the web :

![npmstart](/images/npmstart.png)

By using : "npm test", we have all the tests :

![npmtest](/images/npmtest.jpeg)


## 2. CI/CD

We have set up a continuous integration and continuous deployment (CI/CD) pipeline using Github Actions and Heroku. When we make a pull or push to certain branches, the pipeline will automatically run tests on Github in the Actions tab. 

For using Git, you can use this command :

```bash
$ sudo apt-get install git # install git
$ git add .
$ git commit -m "commit with github actions"
$ git push
```

You can view the results of the tests in the Actions tab. To see the code that runs the tests, you can go to the .github/workflows folder in the project.

The CI/CD pipeline for the application follows these steps:

1. Containers are initialized, which provide isolated environments for running the application and its dependencies.
2. Necessary tools, such as Node.js, are installed.
3. Tests are run to ensure that everything is functioning properly.
4. If the tests pass, a "check" is given to indicate that everything is working as expected.

On github we can that all the tests work :

![githubtest](/images/githubtest.jpeg)

After the tests have been successfully completed, the application can be deployed to the Heroku platform. 

In order to securely connect the Github repository to the Heroku account and enable automatic deployment, we added a Heroku key to the repository's access keys. This establishes a secure connection between the two platforms and links the Heroku account to the Github repository.

The results of the automatic deployment to Heroku can then be viewed :

![heroku](/images/heroku.jpeg)

## 4. Docker Image

To make the application run on different environments, we are using Docker to containerize it. We created a Dockerfile that includes the following steps:

1. Installing packages by copying the package.json file.
2. Copying only the userapi folder and running npm start to start the application within the container.
3. Exposing the container on a specific port so that it can be accessed on our local machine.

We also created a .dockerignore file to exclude certain files and folders within the userapi folder from being included in the container.

To build and run the container, we followed these steps:

```bash
# build the container
$ docker build -t ece-devops-image .
# run the container
$ docker run -p 8080:9000 ece-devops-image
```
To ensure that the application runs correctly, we need to orchestrate it with a redis container. This involves connecting the two containers and setting them up to work together.

![dockerbuild](/images/dockerbuild.png)

![dockerrun](/images/dockerrun.jpeg)

```bash
# tag container
$ docker tag ece-devops-image pierrolobogo/ece-devops-image
# login with docker
$ docker login
# push the image on docker hub
$ docker push pierrolobogo/ece-devops-image
```

![dockerpush](/images/dockerpush.jpeg)

Here we can see that the push on docker hub works :

![dockerhub](/images/dockerhub.jpeg)

## 5. Docker Compose

The docker compose file allows us to connect multiple containers in a single network and create connections between them. 

In this case, we have two services: one for running redis and one for our application. The redis service is based on a redis image pulled from the docker hub, and we have added a volume for storing data and a health check to ensure that the service is running properly. 

The application service is based on an image we have created and also has a volume for storing data. We have also added environment variables to allow the application to communicate with the redis service, even if it is deployed in an external environment. 

These environment variables are necessary because the two services are running in different containers.

To run the docker compose file, use the following command in the docker-compose.yaml directory :

```bash
$ docker-compose up
```

You can also add the -d option to run the file in the background.

To stop the docker compose, use the following command :

```bash
$ docker-compose down
```

For our app, we have this docker compose, and it works correctly :

![dockercompose](/images/dockercompose.jpeg)

Here you can see that the redis and the app container work, with the docker image "ece-webapp-letoquart-kardous", and with all volumes and network :

![dockercommand](/images/dockercommand.jpeg)

With the following command, we can see that all services are working together, and the bridge docker network exists :

![dockernetwork](/images/dockernetwork.jpeg)

## 6. Kubernetes

To run our app using Kubernetes, we have created two services and their corresponding deployments. 

The first deployment is for redis and includes one pod with a container that runs the redis image. 

We have also added a volume to persist redis data, and we have defined a service linked to this deployment. 

The second deployment is for our application and includes a container that runs our docker image. We have also added environment variables to allow external services to access the deployment, and we have created a service for it. To store redis data, we are using persistent volumes, which are stored in the Minikube cluster. 

We have created a persistent volume claim file to link the persistent volume to our application (in this case, redis). This way, if the pod crashes or is otherwise lost, the data will still be stored and can be restored once the pod is regenerated. 

To run the kubernetes configuration files, you can use the following commands :

```bash
# go to the k8s folder
$ cd k8s
# create the persistent volume
$ kubectl apply -f persist.yaml
# create the persistent volume claim
$ kubectl apply -f persist-claim.yaml
# create the redis service
$ kubectl apply -f redis.yaml
# create the api service
$ kubectl apply -f service.yaml
```

If you want to access to all pods, use this command : 

```bash
# display all pods
$ kubectl get pods
```

![k8spersist](/images/k8spersist.jpeg)

![k8spersist2](/images/k8spersist2.jpeg)

In this screen we can see that the Persistent volume and the Persistent volume claim are linked :

![k8sgetpv](/images/k8sgetpv.jpeg)



