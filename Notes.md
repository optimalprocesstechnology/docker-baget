# BaGet Docker

This repository contains the build scripts and configuration for the [BaGet](https://github.com/loic-sharma/BaGet) NuGet docker image.

The docker image runs locally on optiNAS and is exposed externally on <https://nuget.optimalprocess.co.uk:55556>.

The modifications from the standard baget configuration:

1. Enabled mirroring (write-through caching)

## Generating new HTTPS certificates

1. Enable SSH on optinas via the web interface
2. SSH into optinas
3. Log in as admin
4. sudo -i
5. Enter admin password

Run the following commands to Generate Https Certificate:

1. cd /volume1/docker/baget/certs
2. ./generatepfx.sh
3. Stop the container
4. Run up a new docker damon

## Starting the docker damon once stopped

Note: before being able to register the image you will have to stop the container and delete it

1. docker container ls -a
2. docker rm xxx (where xxx is the start of the container id)

Run the following commands to register the docker image:

1. docker pull sboptimal/optimal-baget:latest
2. docker run -d --restart=always --name nuget-server
    -p 55555:80 
    -p 55556:443 
    --env-file /volume1/docker/baget/baget.env 
    -v /volume1/docker/baget/baget-data:/var/baget 
    -v /volume1/docker/baget/certs:/var/baget/certs 
    sboptimal/optimal-baget:latest

## DO NOT FORGET TO DISABLE THE SSH SERVICE FROM THE WEB INTERFACE!!