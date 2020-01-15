# Dockerfile for building general development
# environment for orbital
FROM ubuntu:16.04
LABEL maintainer "michaelchan_wahyan@yahoo.com.hk"

ENV SHELL=/bin/bash \
    TZ=Asia/Hong_Kong \
    PYTHONIOENCODING=UTF-8 \
    PATH=$PATH:/bin:/usr/local/sbin:/usr/local/bin:/usr/local/lib:/usr/lib:/usr/sbin:/usr/bin:/sbin

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak ;\
    cat /etc/apt/sources.list.bak | \
    sed 's/archive/hk.archive/' > /etc/apt/sources.list ;\
    apt-get -y update ;\
    apt-get -y upgrade

RUN apt-get -y install \
        screen \
        apt-utils \
        cmake \
        htop \
        wget \
        vim \
        nano \
        curl \
        git \
        apt-transport-https \
        net-tools \
        bc \
        ca-certificates \
        musl-dev \
        gcc \
        make \
        g++ \
        gfortran \
        doxygen \
        firefox \
        cowsay \
        fortune \
        sl

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    xorg \
    openbox \
    xauth \
    xserver-xorg-core \
    xserver-xorg \
    ubuntu-desktop \
    x11-xserver-utils

# in order to run the x11 forward from container to host machine
# we need to execute `xhost +local:docker` in host machine to
# give docker the rights to access the X-Server
# ref: https://forums.docker.com/t/start-a-gui-application-as-root-in-a-ubuntu-container/17069

# RUN apt-get -y update ;\
#     apt-get -y install libcurl4-openssl-dev libssl-dev libeigen3-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libgmp-dev libgmpxx4ldbl libmpfr-dev libboost-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libboost-thread-dev libtbb-dev libflann-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libblkid-dev e2fslibs-dev libboost-all-dev libaudit-dev ;\
#     apt-get -y update ;\
#     apt-get -y install freeglut3-dev libusb-1.0-0-dev libx11-dev xorg-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libvtk6-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libglu1-mesa-dev libgl1-mesa-glx libglew-dev libglfw3-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libjsoncpp-dev libpng-dev libpng16-dev libjpeg-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libudev-dev libopenni-dev libopenni2-dev ;\
#     apt-get -y update ;\
#     apt-get -y install libpcl-dev ;\


COPY [ ".bashrc" , ".vimrc"               , "/root/"                 ]

EXPOSE 9090 9999
CMD [ "/bin/bash" ]
