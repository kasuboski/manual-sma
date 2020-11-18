FROM linuxserver/ffmpeg as ffmpeg
FROM ubuntu:bionic as base

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

# get ffmpeg and ffprobe from the built image
COPY --from=ffmpeg /usr/local/bin/ff* /usr/local/bin/

RUN \
  # make directory
  mkdir ${SMA_PATH} && \
  # download repo
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git ${SMA_PATH} && \
  # set up a virtual self contained python environment
  python3 -m virtualenv ${SMA_PATH}/venv && \
  ${SMA_PATH}/venv/bin/pip install -r ${SMA_PATH}/setup/requirements.txt

WORKDIR ${SMA_PATH}

ENTRYPOINT [ "/entrypoint.sh" ]