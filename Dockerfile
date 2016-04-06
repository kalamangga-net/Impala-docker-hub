FROM cloudera/impala-dev:updated-code

# Building tests add 10G to the image size, that's probably not worth the convenience.
RUN docker-boot \
   && . bin/impala-config.sh \
   && USE_GOLD_LINKER=true ./bin/make_impala.sh -notests -build_shared_libs
