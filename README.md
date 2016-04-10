# Dockerfiles for an Impala development environment

## Images

Several images are available but only two are inteded for use:

#### Complete
The complete image has Impala built and test data loaded. Because of the size and time required to build this image and limitations of dockerhub, **the image is not available for download but can be built locally**. The built image will be about 50 GB in size and take 1-4 hours depending on your system.

To build the complete image:

```
$ docker build complete
```

Using the complete image:

```
$ docker run -i -t cloudera/impala-dev:complete /bin/bash
[container]$ docker-boot   # starts Postgres and SSH both needed to run Impala
[container]$ . bin/impala-config.sh   # sets the Impala environment variables
[container]$ run-all.sh   # starts dependent services -- HDFS, Hive metastore, etc
[container]$ start-impala-cluster.py
[container]$ impala-shell.sh
[localhost:21000] > select count(*) from tpch.lineitem;
```

The image can also be run in the background and logged into over SSH:

(Note the "-d" and the lack of the trailing "/bin/bash".)

```
$ docker run -d -t cloudera/impala-dev:complete
<some hash>
$ docker inspect <some hash> | grep IPAddress
<output showing the IP address>
$ ssh dev@<IP address>   # password is cloudera
[container]$ . bin/impala-config.sh   # sets the Impala environment variables
[container]$ run-all.sh   # starts dependent services -- HDFS, Hive metastore, etc
[container]$ start-impala-cluster.py
[container]$ impala-shell.sh
[localhost:21000] > select count(*) from tpch.lineitem;
```

This works because the default command for the image is to run "docker-boot" which starts an SSH service.

#### Minimal
The minimal image has Impala built but the test data is not loaded. The image is about 5 GB and can be downloaded from dockerhub or built locally.

Using the minimal image:

```
$ docker run -i -t cloudera/impala-dev:minimal /bin/bash
[container]$ docker-boot   # starts Postgres and SSH both needed to run Impala
[container]$ cd Impala
[container]$ . bin/impala-config.sh   # sets the Impala environment variables
[container]$ ./buildall.sh -format -skiptests
[container]$ run-all.sh   # starts dependent services -- HDFS, Hive metastore, etc
[container]$ start-impala-cluster.py
[container]$ impala-shell.sh
[localhost:21000] > create database test;
```

This image can also be started in the background.

If you want to load the test data manually inside the minimal instance, see the necessary steps in complete/Dockerfile.

#### Other Images
The remainder of the images only exist as workarounds for the limitations of dockerhub. Compiling code on dockerhub is slow and builds have a 2 hour timeout. The build of the Minimal image needed to be split into several steps to avoid the timeout.

### Prebuilt images are hosted by [Dockerhub](https://hub.docker.com/r/cloudera/impala-dev/tags/).

### For more information see the [Impala wiki](https://github.com/cloudera/Impala/wiki/) or ask a question on the [dev user group](https://groups.google.com/a/cloudera.org/forum/#!forum/impala-dev).
