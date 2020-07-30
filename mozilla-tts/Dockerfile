FROM debian

WORKDIR /srv/app

RUN apt-get update && \
	apt-get install -y python3 python3-pip libsndfile1 espeak wget && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY requirements.txt /srv/app/
RUN pip3 install -r requirements.txt

RUN wget https://github.com/reuben/TTS/releases/download/ljspeech-fwd-attn-pwgan/TTS-0.0.1+92aea2a-py3-none-any.whl
RUN pip3 install --no-cache-dir *.whl
# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

EXPOSE 5002

CMD python3 -m TTS.server.server
