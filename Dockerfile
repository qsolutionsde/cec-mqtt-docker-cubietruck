FROM arm32v7/python:3.6
    
RUN apt-get update && apt-get install -y libx11-6 libxrandr2 cmake libudev-dev libxrandr-dev python3-dev swig
RUN cd /tmp && git clone --depth 1 https://github.com/Pulse-Eight/platform.git
RUN mkdir /tmp/platform/build && cd /tmp/platform/build && cmake .. && make && make install
RUN cd /tmp && git clone https://github.com/Pulse-Eight/libcec.git
# Fix
COPY CheckPlatformSupport.cmake /tmp/libcec/src/libcec/cmake/CheckPlatformSupport.cmake
RUN mkdir /tmp/libcec/build && cd /tmp/libcec/build && cmake .. && make && make install && ldconfig
 
RUN pip3 install paho-mqtt

RUN cd /opt && git clone https://github.com/qsolutionsde/cec-mqtt-bridge.git

WORKDIR /opt/cec-mqtt-bridge
ENTRYPOINT ["python3", "/opt/cec-mqtt-bridge/bridge.py"]
