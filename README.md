# docker-base

Docker image for running R analyses used by the Waller lab. The Dockerfile contains all the instructions to build this image, using `rocker/geospatial` as a base template.

Includes TMB, INLA, STAN, and JAGS related R packages, as well as some spatial statistics software not already in `rocker/geospatial`.

## Installing Docker

Instructions for installing Docker can be found [here](https://docs.docker.com/get-docker/).

## How to run the container on local machine

The following command tells docker to pull the image from DockerHub and launches a RStudio-Server Session. The session can then be accessed in your browser as `http://localhost:8787`. 

```bash
docker run --rm -d -p 8787:8787 -e USER=username -e PASSWORD=password labwaller/base
```
When you access the RStudio Server for the first time in your browser, you will be prompted to login with the username and password you specified in your `docker run` command. Original passwords are especially important when working on remote servers.

## Updating the image

The current automated image build workflow is inspired by the [IHME Demographics team setup](https://github.com/ihmeuw-demographics/docker-base). A build is initiated when i) a pull request to the master branch is opened ii) a tagged commit is pushed to the remote. Only a tagged commit will also initiate pushing the built image to Docker Hub. The tags should be used to differentiate versions of an image. There will always be the "latest" image, but other images associated with specific CRAN dates or package versions may be useful. To tag Git commits and push to the remote to initiate the automatic build an example call would be (without the curly brackets in the actual call):

```bash
git tag -a v{name.0.0}
git push origin v{name.0.0}
```

## Creating custom image

For creating a Docker image custom to a specific analysis or paper, you can use the `docker-base` image here as the starting point! Simply create a new Dockerfile to create the new image. Below is a rough example.

```bash
FROM labwaller/base:latest

# Set up the file structure in the container to match your analysis.
# RUN mkdir /home/dir1 /home/dir2 

# Copy over any local data files to the container. 
# COPY localfile /home/localfile 
```

## Helpful links

* [R Docker Tutorial](http://ropenscilabs.github.io/r-docker-tutorial/)
* [`install2.r` code](https://github.com/eddelbuettel/littler/blob/master/inst/examples/install2.r)
* [`rocker/bayesian` Dockerfile](https://github.com/mavelli/rocker-bayesian/blob/master/Dockerfile)
* [R-INLA Dockerfile](https://github.com/egonzalf/rstudio-inla/blob/master/Dockerfile)
* [Derek Powell Guide to R Docker](http://www.derekmpowell.com/posts/2018/02/docker-tutorial-1/)
