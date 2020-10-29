#!/bin/bash

DOCKER_ORG=lloydalbin
DOCKER_IMAGE_NAME=postgres
DOCKER_USERNAME=lloydalbin
declare -a PGVERSION_Array=("pg9.5" "pg9.6" "pg10" "pg11" "pg12" "pg13" )

for PGVERSION in ${PGVERSION_Array[@]}; do
    echo "$DOCKER_PASSWORD" | docker login -u $DOCKER_USERNAME --password-stdin
    ~/postgres-docker/build_postgres.sh -v -v -v -V --add all -pgv $PGVERSION --org $DOCKER_ORG --pg_name $DOCKER_IMAGE_NAME --push --clean --override_exit
    # Use the following line to rebuild images even if the images already exist.
    # This is needed if there is an error in the Docker images and it needs replacing.
    #~/postgres-docker/build_postgres.sh -v -v -v -V --add all -pgv $PGVERSION --org $DOCKER_ORG --pg_name $DOCKER_IMAGE_NAME --push --clean --override_exit --push_force
    docker logout
done 
