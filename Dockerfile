FROM cloudera/impala-dev:updated-code

# Trying to build all of the backend will timeout on Docker hub. The build needs to be
# done in peices.
RUN docker-boot \
     && . bin/impala-config.sh \
     && USE_GOLD_LINKER=true \
         cmake -DCMAKE_TOOLCHAIN_FILE=cmake_modules/toolchain.cmake . \
     && bin/gen_build_version.py \
     && pushd common/function-registry \
     && popd \
     && make -j$(nproc) Catalog Exprs Exec ImpalaThrift Util
