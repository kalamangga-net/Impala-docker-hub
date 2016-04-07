FROM cloudera/impala-dev:build-backend-part-2

# Building tests add 10G to the image size, that's probably not worth the convenience.
RUN docker-boot \
    && . bin/impala-config.sh \
    && USE_GOLD_LINKER=true ./buildall.sh -noclean -notests
