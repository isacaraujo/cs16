FROM cs16ds/server:latest

COPY ./shared /shared

RUN for dir in `ls /shared`; do mkdir -p ./cstrike/${dir} ; cp -aRv /shared/${dir}/* ./cstrike/${dir} ; done

RUN rm -rf /shared