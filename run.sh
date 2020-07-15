#!/bin/sh
# Made by John Beckmann
# A tool for running docker containers and executing bash terminals inside of them 

echo
echo
if [ $# == 2 ]; then
	# Two arguments were provided
	# Make sure that the image exists and try to run it.
	# Remove the .current_container if it exists and then create a new one
	container=$1
	image=$2

	image_exists=`docker images -q $image`	
	if [ -z "$image_exists" ]; then
		echo "\"$image\" is not an existing image"
		echo "Try again..."	
		echo
		exit
else
	# An incorrect number of arguments were provided.
	# Print an error to the console
	echo "This script takes exactly two arguments (a name for the container to be run and the name of the image that the container is to be run from)"
	echo "Try again..."
	echo
	exit	
fi

docker run -dt -p 6500:6500 --init --rm --hostname meridian --name $container $image
echo
echo
echo "ip address:"
docker inspect $container --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID
echo
echo
echo "opening the terminal..."
echo
docker exec -it $container bash
