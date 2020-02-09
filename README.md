# DORBITAL (Dockerised ENV for ORBITAL)

ORBITAL (Oh! lidaR Brother Is waTching you At Lampost)

## Purpose

This is a container environment for PCL software development with all the environment preset.

Refer to the [github repo](https://github.com/michaelchanwahyan/dorbital) to build the image on your own.

The major PCL library and 3rd Party dependency versions are listed below:

| Library | Version |
| --- | --- |
| pcl | 1.8.0 |
| boost | 1.61 |
| eigen | 3.2.8 |
| flann | 1.8.4 |
| vtk | 7.0.0 |

## Build & Usage

From a Linux with 8G memory + 8G swap memory, build the docker image by doing:

```
bash buildimg.sh
```

This may take you some time.

To run up the container with x11 forwarding, do:

```
bash rundocker.sh
```

## Library

The boost, eigen, flann, vtk, and pcl source and header files are all placed under the directory

```
/SOURCE/boost_1_61_0

/SOURCE/eigen_3_2_8

/SOURCE/flann_1_8_4

/SOURCE/vtk_7_0_0

/SOURCE/pcl
```

while the library files have been installed into

```
/usr/local/lib
```

during make and install

## Remark 1

macOS may encounter the following build error during PCL library compilation:

```
c++: internal compiler error: Killed (program cc1plus)
```

It is yet to be fixed using some know-how ...

## Remark 2

Docker Hub build time out in pcl compilation layer

so that i need to build this layer on my own and push to docker hub
