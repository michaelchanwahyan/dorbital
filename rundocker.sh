#!/bin/sh
clear
export TZ=Asia/Hong_Kong
mem=$(free -g | head -2 | tail -1 | awk -F " " '{print $2}') # if you run to error, set mem to your system memory (in GB unit)
target_mem=$(echo "$mem * 0.9" | bc) # if you run to error, install bc
#docker run -p 9999:9999 \
#           -p 9090:9090 \
#           -v /app:/app \
#           -dt \
#           --name=sleepy_pikachu \
#           --memory="$target_mem"g \
#           datalab:stable \
#           /bin/bash /startup.sh
xhost +local:docker
docker run -dt \
           --name=sleepy_pikachu \
           --memory="$target_mem"g \
           -e DISPLAY=$DISPLAY \
           -v /tmp/.X11-unix:/tmp.XIM-unix \
           dorbital:latest \
           systemd
#           /bin/bash
#docker run -dt \
#    --env="DISPLAY=localhost:0" \
#    --env="QT_X11_NO_MITSHM=1" \
#    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
#    dorbital:latest \
#    bash
