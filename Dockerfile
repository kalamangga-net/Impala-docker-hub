FROM cloudera/impala-dev:prereqs

RUN docker-boot \
    && . bin/impala-config.sh \
    && ./bin/create-test-configuration.sh
# Building tests add 10G to the image size, that's probably not worth the convenience.
RUN docker-boot && USE_GOLD_LINKER=true ./buildall.sh -notests -so
