FROM cloudera/impala-dev:build-backend-part-1

# Build the remainder of the backend.
RUN docker-boot \
     && . bin/impala-config.sh \
     && USE_GOLD_LINKER=true bin/make_impala.sh -notests
