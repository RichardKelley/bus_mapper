FROM nvidia/cudagl:11.1.1-base-ubuntu20.04
 
# Minimal setup
RUN apt-get update \
 && apt-get install -y locales lsb-release
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
 
# Install ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update \
 && apt-get install -y --no-install-recommends ros-noetic-desktop-full
RUN apt-get install -y --no-install-recommends python3-rosdep
RUN rosdep init \
 && rosdep fix-permissions \
 && rosdep update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

RUN apt-get install -y emacs
RUN apt-get install -y ros-noetic-velodyne
RUN apt-get install -y ros-noetic-velodyne-pcl
RUN apt-get install -y libceres1
RUN apt-get install -y libceres-dev
RUN apt-get install -y python3-catkin-tools
RUN apt-get install -y g++

# To install GTSAM
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:borglab/gtsam-release-4.0
RUN apt-get install -y libgtsam-dev
RUN apt-get install -y libgtsam-unstable-dev