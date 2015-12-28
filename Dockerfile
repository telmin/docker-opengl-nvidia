FROM ubuntu:14.04

RUN ln -snf /bin/bash /bin/sh

# config opengl settings
RUN apt-get update
RUN apt-get install -y x-window-system
RUN apt-get install -y binutils
RUN apt-get install -y mesa-utils
RUN apt-get install -y module-init-tools
RUN apt-get install -y wget

ADD nvidia-driver.run /tmp/nvidia-driver.run
RUN sh /tmp/nvidia-driver.run -a -N --ui=none --no-kernel-module
RUN rm /tmp/nvidia-driver.run

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y ros-indigo-desktop python-rosinstall

RUN rosdep init
RUN rosdep update

RUN echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
RUN source ~/.bashrc

RUN sudo apt-get install -y ros-indigo-libg2o ros-indigo-cv-bridge liblapack-dev libblas-dev freeglut3-dev libqglviewer-dev libsuitesparse-dev libx11-dev

CMD /bin/bash
