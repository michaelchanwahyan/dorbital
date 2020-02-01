# DORBITAL (Dockerised env for ORBITAL)

ORBITAL (Oh! lidaR Brother Is waTching you At Lampost)

## Purpose

This is a container environment for PCL software development with all the environment preset.

The major PCL library and 3rd Party dependency versions are listed below:

| Library | Version |
| --- | --- |
| pcl | 1.8.0 |
| boost | 1.61 |
| eigen | 3.2.8 |
| flann | 1.8.4 |
| vtk | 7.0.0 |

## Usage

From a Linux with 8G memory + 8G swap memory, build the docker image by doing:

```
bash buildimg.sh
```

This may take you some time.

To run up the container with x11 forwarding, do:

```
bash rundocker.sh
```

## Remark

macOS may encounter the following build error during PCL library compilation:

```
c++: internal compiler error: Killed (program cc1plus)
```

It is yet to be fixed using some know-how ...

