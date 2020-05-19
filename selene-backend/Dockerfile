FROM ubuntu:18.04

# https://github.com/MycroftAI/selene-backend

ARG mycroft_domain

RUN apt-get update && apt-get install -y python3.7 python python3-pip git wget python3.7-dev && mkdir -p /opt/selene
WORKDIR /opt/selene
RUN git clone https://github.com/MycroftAI/selene-backend.git && python3.7 -m pip install pipenv && find . \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i "s/mycroft\.ai/${mycroft_domain}/g"
WORKDIR /opt/selene/selene-backend/db
RUN pipenv install && mkdir -p /opt/selene/data
WORKDIR /opt/selene/data
RUN wget http://download.geonames.org/export/dump/countryInfo.txt && wget http://download.geonames.org/export/dump/timeZones.txt && wget http://download.geonames.org/export/dump/admin1CodesASCII.txt && wget http://download.geonames.org/export/dump/cities500.zip && bash -c 'export LANG=en; cd /opt/selene/selene-backend/api; for dir in sso account market public; do pushd $dir; pipenv install; popd; done' && mkdir -p /var/log/mycroft && mkdir -p /opt/selene/documentation/_pages && \
  cd /opt/selene/documentation/_pages && \
  printf "%s\n%s\n" '---' '---' > embed-privacy-policy.md && \
  printf "%s\n%s\n" '---' '---' > embed-terms-of-use.md
# https://github.com/MycroftAI/selene-backend/issues/201

