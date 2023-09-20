#!/usr/bin/env bash

########################################################
# Script to build images and push them to dockerhub.   #
#                                                      #
# Takes one parameter, the release version to tag.     #
########################################################


# check we have a version argument
if [ -z "$1" ]
  then
    echo "No tag/version supplied, exiting"
    exit 1
fi


tag="naturalhistorymuseum/ckantest:$1"

echo "Building $tag"
if [ "$1" = "next" ]
  then
    docker build -f ckantest/ckan-2.10/Dockerfile -t $tag .
  else
    docker build -f ckantest/ckan-2.9/Dockerfile -t $tag .
fi

echo "Pushing $tag"
docker push $tag

# all done :)
echo "Release complete"
exit 0
