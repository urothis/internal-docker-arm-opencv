FROM balenalib/raspberrypi3-debian:stretch-20190612 AS builder

# Install dependencies
RUN install_packages build-essential \
  python3 \
  python3-dev \
  python3-pip \
  python-rpi.gpio \
  python3-rpi.gpio \
  python3-setuptools \
  gstreamer-1.0 \
  v4l-utils \
  libffi-dev \
  libssl-dev \
  libopus-dev \
  libvpx-dev \
  libsrtp2-dev \
  libopencv-dev \
  libatlas3-base \
  libatlas-base-dev \
  libjasper-dev \
  libilmbase12 \
  libopenexr22 \
  libavformat-dev \
  libswscale-dev \
  libqtgui4 \
  libqt4-test \
  libavdevice-dev \
  libavfilter-dev \
  libavcodec-dev \
  network-manager

# so network manager knows where to look for our dbus location
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
# our camera
RUN printf "bcm2835-v4l2\n" >> /etc/modules

# pip install stuff
RUN pip3 install --upgrade pip
RUN pip3 install async-timeout av==6.1.0 balena-sdk requests psutil hurry.filesize pyudev
RUN pip3 install aiohttp aiohttp_basicauth==0.1.3 aioice==0.6.10 aiortc==0.9.11 numpy==1.15.4 opencv-python==3.4.4.19 gpiozero --index-url https://www.piwheels.org/simple

# udev for dynamic usb
ENV UDEV=on

# workdir
WORKDIR /usr/src/app
