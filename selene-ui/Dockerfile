FROM ubuntu:18.04 as build

# https://github.com/MycroftAI/selene-ui

ARG mycroft_domain

RUN apt-get update && apt-get install -y npm git curl && curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs && npm install -g @angular/cli

WORKDIR /usr/src/app
RUN git clone https://github.com/MycroftAI/selene-ui.git
WORKDIR selene-ui

# Replace mycroft urls with our own. TODO: Get domain from env
RUN find . \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i "s/mycroft\.ai/${mycroft_domain}/g" && npm --version && npm cache clean --forc && npm install
WORKDIR projects
RUN ng build --project shared && ng build --project globalnav && ng build --project account --prod && ng build --project market --prod && ng build --project sso --prod


FROM nginx:latest

RUN apt-get update && apt-get install -y curl dnsutils
ARG application_name

RUN rm -rf /etc/nginx/conf.d/default.conf
ADD ui-app-nginx.conf /etc/nginx/conf.d/ui-app-nginx.conf

# TODO: Delete this line after debugging
COPY --from=build /usr/src/app/selene-ui/ /app_code

COPY --from=build /usr/src/app/selene-ui/dist/${application_name}/ /usr/share/nginx/html
