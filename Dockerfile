FROM ubuntu:bionic

ENV SMA_PATH /usr/local/sma

RUN \
  apt-get update && \
  apt-get install -y \
  git \
  wget \
  python3 \
  python3-pip && \
  python3 -m pip install --user --upgrade pip && \
  python3 -m pip install --user virtualenv && \
  # cleanup
  apt-get purge --auto-remove -y && \
  apt-get clean && \
  rm -rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

COPY entrypoint.sh /entrypoint.sh

RUN \
  # make directory
  mkdir ${SMA_PATH} && \
  # download repo
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git ${SMA_PATH} && \
  # set up a virtual self contained python environment
  python3 -m virtualenv ${SMA_PATH}/venv && \
  ${SMA_PATH}/venv/bin/pip install -r ${SMA_PATH}/setup/requirements.txt && \
  # ffmpeg
  wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz -O /tmp/ffmpeg.tar.xz && \
  tar -xJf /tmp/ffmpeg.tar.xz -C /usr/local/bin --strip-components 1 && \
  chgrp users /usr/local/bin/ffmpeg && \
  chgrp users /usr/local/bin/ffprobe && \
  chmod g+x /usr/local/bin/ffmpeg && \
  chmod g+x /usr/local/bin/ffprobe

WORKDIR ${SMA_PATH}

ENTRYPOINT [ "/entrypoint.sh" ]