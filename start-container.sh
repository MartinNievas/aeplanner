#!/bin/bash
IMAGE_NAME="aeplanner-docker"
CONTAINER_NAME="aeplanner-test"
# Repo path
AEPLANER_LOCAL_REPO="/.../aeplanner"
CATKIN_SIMPLE_LOCAL_REPO="/.../catkin_simple"

list_containers="docker ps --format '{{.Names}}' -a"

echo "Corroborando si existe un contenedor con el mismo nombre"
if [[ $( $list_containers | grep -w $CONTAINER_NAME ) ]]; then
    echo " -> Existe un contenedor con el mismo nombre, se procede a eliminarlo"
    docker rm --force $CONTAINER_NAME
else
    echo " -> No existe un contenedor con el mismo nombre"
fi

echo "Corriendo xhost +local:docker"
xhost +local:docker #Permite GUIs en docker

echo "Procediendo a construir y ejecutar el contenedor"
docker  run -d -i \
        --env="DISPLAY=unix$DISPLAY" \
        --net=host \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
        --volume="$AEPLANER_LOCAL_REPO:/mnt/aeplanner" \
        --volume="$CATKIN_SIMPLE_LOCAL_REPO:/mnt/catkin_simple" \
        --name $CONTAINER_NAME \
        $IMAGE_NAME
