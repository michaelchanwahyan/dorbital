# Dockerfile for building general development
# environment for orbital
FROM ubuntu:18.04
LABEL maintainer "michaelchan_wahyan@yahoo.com.hk"

ENV SHELL=/bin/bash \
    TZ=Asia/Hong_Kong \
    PYTHONIOENCODING=UTF-8 \
    PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/lib:/usr/local/lib:/SOURCE/orbital/build:/SOURCE/pcl/build:/SOURCE/pcl/build/lib:/SOURCE/vtk_7_0_0/build:/SOURCE/vtk_7_0_0/build/lib \
    LD_LIBRARY_PATH=/usr/local/lib:/SOURCE/orbital/build:/SOURCE/pcl/build:/SOURCE/pcl/build/lib:/SOURCE/vtk_7_0_0/build:/SOURCE/vtk_7_0_0/build/lib \
    LIBRARY_PATH=/SOURCE/pcl/build:/SOURCE/pcl/build/lib:/SOURCE/vtk_7_0_0/build:/SOURCE/vtk_7_0_0/build/lib \
    CPLUS_INCLUDE_PATH=/SOURCE/orbital \
    BOOST_SYSTEM_LIBRARY=/SOURCE/boost-1.61.0/bin.v2/libs

RUN apt-get -y update ;\
    apt-get -y upgrade

RUN apt-get -y install screen apt-utils htop wget curl net-tools \
        cmake gcc make g++ gfortran ca-certificates musl-dev fortune \
        vim nano git apt-transport-https bc doxygen firefox cowsay sl

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install xorg openbox \
        xauth xserver-xorg-core xserver-xorg ubuntu-desktop x11-xserver-utils

# in order to run the x11 forward from container to host machine
# we need to execute `xhost +local:docker` in host machine to
# give docker the rights to access the X-Server
# ref: https://forums.docker.com/t/start-a-gui-application-as-root-in-a-ubuntu-container/17069

RUN mkdir -p /SOURCE /data

RUN apt-get -y update ;\
    apt-get -y install \
        build-essential autotools-dev libicu-dev libbz2-dev python-dev \
        freeglut3-dev libjsoncpp-dev libpcap-dev

RUN cd /SOURCE ;\
    wget https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.bz2 ;\
    tar --bzip2 -xf boost_1_61_0.tar.bz2 ; rm -f boost_1_61_0.tar.bz2 ;\
    cd boost_1_61_0 ; ./bootstrap.sh ; ./b2 install -j1

RUN cd /SOURCE ;\
    wget -O eigen_3_2_8.tar.bz2 http://bitbucket.org/eigen/eigen/get/3.2.8.tar.bz2 ;\
    tar --bzip2 -xf eigen_3_2_8.tar.bz2 ; rm -f eigen_3_2_8.tar.bz2 ; mv eigen-eigen-* eigen_3_2_8 ;\
    cd eigen_3_2_8 ; mkdir build ; cd build ; cmake .. ; make -j1 ; make install

RUN cd /SOURCE ;\
    wget -O flann_1_8_4-src.zip http://www.cs.ubc.ca/research/flann/uploads/FLANN/flann-1.8.4-src.zip ;\
    unzip flann_1_8_4-src.zip ; rm -f flann_1_8_4-src.zip ; mv flann-1.8.4-src flann_1_8_4 ;\
    cd flann_1_8_4 ; mkdir build ; cd build ; cmake .. ; make -j1 ; make install

RUN cd /SOURCE ;\
    wget -O vtk_7_1_0.tar.bz2 https://gitlab.kitware.com/vtk/vtk/-/archive/v7.1.0/vtk-v7.1.0.tar.bz2 ;\
    tar --bzip2 -xf vtk_7_1_0.tar.bz2 ; rm -f vtk_7_1_0.tar.bz2 ; mv vtk-v7.1.0 vtk_7_1_0 ;\
    cd vtk_7_1_0 ; mkdir build ; cd build ; cmake .. ; make -j1 ; make install

RUN cd /SOURCE ;\
    git clone https://github.com/PointCloudLibrary/pcl.git ;\
    cd pcl ; git checkout tags/pcl-1.8.0 ; rm -rf .git ;\
    mkdir build ; cd build ; cmake .. ; make -j1 ; make install

RUN echo /usr/local/lib >> /etc/ld.so.conf ;\
    ldconfig

COPY [ ".bashrc" , ".vimrc" , "/root/" ]

CMD [ "/bin/bash" ]
