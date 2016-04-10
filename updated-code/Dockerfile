FROM cloudera/impala-dev:prereqs

WORKDIR /home/dev/hadoop-lzo
RUN git fetch origin
RUN git reset --hard origin/master
RUN git clean -xdf
RUN ant package

WORKDIR /home/dev/Impala-lzo
RUN git fetch origin
RUN git reset --hard origin/cdh5-trunk
RUN git clean -xdf

WORKDIR /home/dev/Impala
RUN git fetch origin
RUN git reset --hard origin/cdh5-trunk
RUN git clean -xdf

RUN docker-boot \
    && . bin/impala-config.sh \
    && ./bin/create-test-configuration.sh

RUN . bin/impala-config.sh \
    && bin/bootstrap_toolchain.py
