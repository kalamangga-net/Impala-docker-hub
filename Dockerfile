FROM cloudera/impala-dev:minimal

RUN docker-boot \
    && . bin/impala-config.sh \
    && mkdir -p $IMPALA_HOME/testdata/impala-data \
    && pushd $IMPALA_HOME/testdata/impala-data \
    && cat /tmp/tpch.tar.gz{0..6} > tpch.tar.gz \
    && tar -xzf tpch.tar.gz \
    && rm tpch.tar.gz \
    && cat /tmp/tpcds.tar.gz{0..3} > tpcds.tar.gz \
    && tar -xzf tpcds.tar.gz \
    && rm tpcds.tar.gz \
    && if false; then \
         wget http://util-1.ent.cloudera.com/impala-test-data/foo.tar.gz; \
         tar -xzf foo.tar.gz; \
       fi \
    && popd \
    && ./buildall.sh -notests -noclean -format -testdata \
    && sudo rm -rf $IMPALA_HOME/testdata/impala-data
