#!/bin/sh
docker build -t dorbital:latest ./
docker rmi   -f $(docker images -f "dangling=true" -q)
