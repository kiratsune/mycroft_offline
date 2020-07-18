FROM ubuntu:18.04

# https://pypi.org/project/deepspeech-server/

RUN apt-get update && \
    apt-get install -y python3.7 python python3-pip git wget python3.7-dev && \
    pip3 install deepspeech && \
    pip3 install deepspeech-server && \
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.7.1/deepspeech-0.7.1-models.pbmm && \
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.7.1/deepspeech-0.7.1-models.scorer
RUN wget -O config.json https://raw.githubusercontent.com/MainRo/deepspeech-server/master/config.sample.json
CMD ["deepspeech-server", "--config", "config.json"]
