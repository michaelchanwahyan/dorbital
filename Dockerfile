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

RUN mkdir -p /SOURCE

RUN cd /SOURCE ;\
    wget https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.bz2

RUN cd /SOURCE ;\
    tar --bzip2 -xf boost_1_61_0.tar.bz2

RUN apt-get -y update ;\
    apt-get -y install \
    build-essential \
    autotools-dev \
    libicu-dev \
    libbz2-dev

RUN apt-get -y install python-dev

RUN cd /SOURCE ;\
    cd boost_1_61_0 ;\
    ./bootstrap.sh ;\
    ./b2 install -j4

RUN cd /SOURCE ;\
    wget -O eigen_3_2_8.tar.bz2 http://bitbucket.org/eigen/eigen/get/3.2.8.tar.bz2

RUN cd /SOURCE ;\
    tar --bzip2 -xf eigen_3_2_8.tar.bz2 ;\
    mv eigen-eigen-* eigen_3_2_8

RUN cd /SOURCE ;\
    cd eigen_3_2_8 ;\
    mkdir build ;\
    cd build ;\
    cmake .. ;\
    make -j4

RUN cd /SOURCE ;\
    wget -O flann_1_8_4-src.zip http://www.cs.ubc.ca/research/flann/uploads/FLANN/flann-1.8.4-src.zip

RUN cd /SOURCE ;\
    unzip flann_1_8_4-src.zip ;\
    mv flann-1.8.4-src flann_1_8_4

RUN cd /SOURCE ;\
    cd flann_1_8_4 ;\
    mkdir build ;\
    cd build ;\
    cmake .. ;\
    make -j4

RUN cd /SOURCE ;\
    git clone https://github.com/michaelchanwahyan/cmake-3.10.git ;\
    cd cmake-3.10 ;\
    bash preparation.sh

RUN cd /SOURCE ;\
    wget -O vtk_7_0_0.tar.bz2 https://gitlab.kitware.com/vtk/vtk/-/archive/v7.0.0/vtk-v7.0.0.tar.bz2

RUN cd /SOURCE ;\
    tar --bzip2 -xf vtk_7_0_0.tar.bz2 ;\
    mv vtk-v7.0.0 vtk_7_0_0

RUN apt-get install -y freeglut3-dev

RUN cd /SOURCE ;\
    cd vtk_7_0_0 ;\
    mkdir build ;\
    cd build ;\
    cmake .. ;\
    make -j4

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


COPY [ ".bashrc" , ".vimrc" , "/root/" ]

EXPOSE 9090 9999
CMD [ "/bin/bash" ]
