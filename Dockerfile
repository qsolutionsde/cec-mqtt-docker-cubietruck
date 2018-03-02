FROM arm32v7/debian

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git python3 python3-pip python3-dev libx11-6 libxrandr2

# Clone the conf files into the docker container
RUN cd /opt && git clone https://github.com/qsolutionsde/cec-mqtt-bridge.git
RUN dpkg -i /opt/cec-mqtt-bridge/libcec/libcec4_4.0.2.1~raspbian_armhf.deb && dpkg -i /opt/cec-mqtt-bridge/libcec/libcec4-dev_4.0.2.1~raspbian_armhf.deb && dpkg -i /opt/cec-mqtt-bridge/libcec/python-libcec_4.0.2.1~raspbian_armhf.deb
RUN pip3 install paho-mqtt

WORKDIR /opt/cec-mqtt-bridge
ENTRYPOINT ["python3", "/opt/cec-mqtt-bridge/bridge.py"]
