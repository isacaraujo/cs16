FROM cs16ds/server:latest

ADD ./addons/metamod/plugins.ini /opt/hlds/cstrike/addons/metamod/plugins.ini
ADD ./addons/amxmodx/configs/maps.ini /opt/hlds/cstrike/addons/amxmodx/configs/maps.ini

COPY ./shared /shared

RUN for dir in `ls /shared`; do mkdir -p ./cstrike/${dir} ; cp -aRv /shared/${dir}/* ./cstrike/${dir} ; done

RUN rm -rf /shared