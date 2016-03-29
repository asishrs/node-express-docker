# node-express-docker
This is a smaple application to demonstrate the ability to Run NodeJs applications on Docker Container.

### Prerequisites
* **NodeJS** - This applicaion is tested with node v5.0.0 and npm v3.4.0. You can follow instructions https://nodejs.org/en/ to install node and npm on your machine.
* **Docker** - This application is tested with docker v1.9.0. You can follow instructions https://docs.docker.com/engine/installation/ to install Docker on your machine.

### How to Run/Test?
Make sure that, you have installed Docker on your machine before proceeding.
* Build the Image
Navigate to the project folder and execute below command
```
docker build -t <your username>/node-express-docker .
```
* Start your Docker image. 
```
docker run -p 49160:3000 -d <your username>/node-express-docker
```
* Verfiy that your image started. You should see your image in runnig mode there.
```
docker ps
```
* Find the ip-address of the Docker container.
```
docker-machine ip  <your username>/node-express-docker
```
* Test Node web application on Docker Image
Gran the IP address of your container using above command before proceed.
Open your favorite browser and type the url http://{ip-address}:49160

**Ti-ta** - Your sample application is now runnnig from Docker container.

If you are not seeing the appication running successfully, please read the details below.
***
### Steps In buidling the application and Docker Image

* **Create a sample application using express generator**
First lets create a sample node web applicationa and test that locally. Run below to install **express** and **expres-generator** node packages.
```
npm install -g express-generator
npm install -g express
```
Once we have express and express-genarator installed, we can create our sample application. Move to the directory where you want to create the application and run below command.
```
express <application-name>
```
In my case, I ran **express node-express-docker**
* **Run & test** application - To run the application navigate to the application directory and run below commands.
```
npm install
npm start
```
Now, open your favorite browser and type the url http://localhost:3000

**Note:** If you are getting an issue, go back to the console where we started the application and check the logs.

* **Create a Docker container based on Ubuntu and install node on that**
Now that we have the application up and runnig, we can start Docker work. Make sure you have installed docker before stating this. Verify that you have Docker by running below command.
```
docker version
```
**Optional:** In case you are getting a message 'Cannot connect to the Docker daemon. Is the docker daemon running on this host?', you need to set the environment varaibles for Docker by running below. In the comamnd default is the name of environment. You have to change that if you are using a different environment.
```
eval "$(docker-machine env default)"
```
In this case, we are going to use latest version on Ubuntu to create an image of our application. Docker needs a file called Dockerfile to build an image.
Open the Dockerfile that I have in the project and copy the contents to your Docker file. This file contains instruction to get the latest ubuntu image and install node and npm.
After this, we have to copy our code to the container and tell Docker to expose the application port. Finally we need to tell Docker the command that it needs to run when we strat this image.
You can read more about the Dockerfile creation here - http://docs.docker.com/engine/reference/builder/

Once you have the Docker file ready, we need to build the image. Run below comamnd to build the image.
```
docker build -t <your username>/node-express-docker .
```
Verify that the image is ready by running below command. You'll see you image listed there.
```
docker images
```
Start your Docker image. We are asking to run the image and expose the port 3000 on the container to 49160 on host.
Running your image with -d runs the container in detached mode, leaving the container running in the background. The -p flag redirects a public port to a private port in the container.
```
docker run -p 49160:3000 -d <your username>/node-express-docker
```
Verfiy that your image started. You should see your image in runnig mode there.
```
docker ps
```
**Optional:** If you cannot see your image in the list, you may need to run the application in regualr mode by removing the -d option. This will help you to check for any errors.
```
docker run -p 49160:3000 <your username>/node-express-docker
```
Find the ip-address of the Docker container.
```
docker-machine ip  <your username>/node-express-docker
```
Now we are all set to run the application. Open your favorite browser and type the url http://host-ip-address:49160

***
#### If you want to monitor the application you can follow below steps.
* Find the conatiner id by running
```
docker ps
```
* Get the status by passing container id to below command.
```
docker stats <container-id>
```
* To stop the container, you can run below command
```
docker stop <container-id>
```

***
#### If you want to ssh onto the container please follow beloe steps.
* Find the conatiner id by running
```
docker ps
```
* Log into the container via bash (Warning this is for docker v>1.3).
```
docker exec -it <container_id> bash
```

