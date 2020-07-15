#!/bin/sh
# Made by John Beckmann
# A tool for building Docker images

echo
echo
if [ $# == 1 ];then
	# An argument was provided for the name of the image to be built
	image=$1
	image_exists=`docker images -q $image`	
	if [ ! -z "$image_exists" ]; then
		echo "\"$image\" already exists..."
		read -p "Are you sure you want to overwrite it??? (y/n)" answer
		if [[ $answer != [yY] && $answer != [yY][eE][sS] ]]; then
			echo "Exiting..."
			echo
			echo
			exit
		else
			echo
			echo			
		fi	
	fi
else
	# More or less than one argument was provided.
	# Print an error to the console
	echo "This script takes exactly one argument (the name of the image to be built)"
	echo "Try again..."
	echo	
	exit
fi


# Note when the build started
BUILD_START=$(date '+%s')

# Build the image
docker build --force-rm -t $image .

# Compute and display the build time
BUILD_END=$(date '+%s')
BUILD_ELAPSED=`expr $BUILD_END - $BUILD_START`
BUILD_MINUTES=`expr $BUILD_ELAPSED / 60`
BUILD_SECONDS=`expr $BUILD_ELAPSED - $BUILD_MINUTES \* 60`
echo
echo
if [ $BUILD_MINUTES == 0 && $BUILD_SECONDS != 0 ]; then
	echo "BUILD TIME: $BUILD_SECONDS seconds"
elif [ $BUILD_MINUTES != 0 && $BUILD_SECONDS == 0 ]
	echo "BUILD TIME: $BUILD_MINUTES minutes"
elif [ $BUILD_MINUTES == 0 && $BUILD_SECONDS == 0 ]
	echo "BUILD TIME: $BUILD_MINUTES minutes & $BUILD_SECONDS seconds" 
fi
echo
echo
docker image ls
echo
