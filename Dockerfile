# Dockerfile
FROM ros:kinetic
WORKDIR /home/catkin_ws

ENV DISPLAY=unix$DISPLAY

## Installl ROS/Gazebo
RUN apt-get update && \
    apt-get install ros-kinetic-desktop-full -y && \
    apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y && \
    apt-get update && \
    apt-get install vim -y && \
    apt-get install git -y && \
    apt-get install python-pip -y && \
    pip install rtree && \
    apt-get install libspatialindex-dev -y && \
    apt-get install python-catkin-tools python-rosinstall-generator -y && \
    apt-get install ros-kinetic-octomap* -y

RUN echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc
RUN mkdir -p /home/catkin_ws/src && cd /home/catkin_ws/src
RUN ln -s /mnt/aeplanner /home/catkin_ws/src/ && \
    ln -s /mnt/catkin_simple /home/catkin_ws/src/

