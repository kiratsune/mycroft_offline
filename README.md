[WIP] Trying to fix everything to 'make it just works' on my server.  

This project is a collection of files which helps you deploy a full instance of [mycroft](https://mycroft.ai/) (only backend, APIs and web-ui, the front-end (enclosures) can already be setup with one docker command).  
  
Heavily based on the original repo by Dimitris Karakasilis (jimmykarily) at https://github.com/jimmykarily/mycroft_offline .  

## Goal

Deploy an offline home assistant server as easily as possible.

## Why

There are various home assistant solutions out there but all of them transfer your voice to some server for processing. This is a no-go for many people although the technology is interesting and could be useful. There are various open source tools to achieve the same result but there is no turn-key open source self hosted solution. The goal of this project is to implement a way to have a home assistant running locally - ideally with one command.

The project that is closer to the desired result is Mycroft (https://mycroft.ai/). It is very easy to run the client side components using one docker command but their backend is running remotely. All the tools they use though are open source so it only needs one to do the work and package them in a nice little docker-compose file (https://mycroft-ai.gitbook.io/docs/about-mycroft-ai/faq#can-mycroft-run-completely-offline-can-i-self-host-everything).

## Prerequisites

- docker: https://www.docker.com/get-started
- docker-compose: https://docs.docker.com/compose/
- Internet connection to download docker images and dependencies
- A good CPU, STT AND TTS are very CPU intensive. (Using a (nvidia/CUDA ?) GPU would speed up the process a lot but I don't know if it works with this setup yet.)

## Prepare configuration

Edit and complete:
  
- `config.env`
- `config_external_accounts.env`
- `.env`

The .env file is only used to build the images, but the variable it contains must have the same value as the one in `config.env`.  

To generate all needed passwords in `./generated` you can run:
```sh
./setup.sh (only needed once)  
```


If you do not have a valid domain you can use a fake one like `asdf.asdf` as `MICROFT_DOMAIN`.

Then you should edit your `/etc/hosts` to something like that:
```
127.0.0.1 sso.asdf.asdf
127.0.0.1 account.asdf.asdf
127.0.0.1 api.asdf.asdf
127.0.0.1 market.asdf.asdf
127.0.0.1 home.asdf.asdf
127.0.0.1 asdf.asdf
```

## Start Mycroft-Backend

```sh
docker-compose up -d  
```
And everything is ready to go. The setup phase can take a while.  

Now you should be able to access your very own Selene Backend (i.e. browse to `https://home.asdf.asdf`)


## Start Mycroft-Core (client)

```sh
cd ./client
docker-compose up -d
```

The host-connections of `./client/storage/mycroft.conf` are linked to the backend docker containers. If you want to start the client on a different machine you need to adjust these ones and the network link in `./client/docker-compose.yml`.

## Register Device and enjoy your personal assistant

During first startup, Mycroft-Core should tell you a pairing code. Browse to `https://home.asdf.asdf` and register your client.

After the registration you should be able to talk to Mycroft and even access Backend-APIs like WolframAlpha (if you registered a valid API-Key).


## Security hint

The reverse proxy of Microft-Backend currently uses a self-signed certificate so we needed to disable client side SSL-Verification. If you are using a reverse proxy delivering a valid certificate we strongly recommend you to re-enable SSL-Verification.

To enable SSL-Verification you simply need to remove the entire `entrypoint` section in `./client/docker-compose.yml` and rebuild the container.

## Development

After changing the domain settings in `.env` you need to clean build everything to 'burn' the new domain settings into the images

```sh
docker-compose build --no-cache --pull
```

A completely fresh startup can be achieved by

```sh
docker-compose down -v
rm -rf ./generated
./setup.sh
docker-compose build --no-cache --pull
docker-compose up -d
```

## Troubleshooting

#### Problem: No skills available in the marketplace.  
**Solution** :  your selene version is too high... A quick fix is to edit get_display_data_for_skills.sql and change the equal sign = for a less or equal sign <= in the WHERE clause. (In a container the file is in : /opt/selene/selene-backend/shared/selene/data/skill/repository/sql/get_display_data_for_skills.sql )  

## TODO
- Use uWSGI for both mozilla-tts and deepspeech server instead of directly exposing the flask dev server through nginx.
- Make the deepspeech server container use the mainstream repo now that it has been updated.
- core-version should not be hardcoded in docker-compose.yml (get latest somehow?)
- Add more variables to the .env files. (There are some left in docker-compose.yml)
- Remove `.env` and `config.env` and `config_external_accounts.env` from git repository add them to `.gitignore` and place `.*.template` files instead (reduce risk of accidental commit)
- Make TTS and STT use the GPU. Not very difficult to do, but they seem to use CUDA and for now I do not plan on installing anything proprietary on my servers.
- Include a fix for the problems in the troubleshooting section.  
- Rewrite the nginx config to expose api only on the required domains ? to make it easier to split this on multiple computers without docker swarm ?  

## Note

This project started as part of SUSE Hackweek 19: https://hackweek.suse.com/projects/home-assistant-that-doesnt-spy-on-you-developers-edition

Idea: Create a mycroft skill to deploy apps with CF (cf cli wrapper)

## Links

- https://github.com/jimmykarily/mycroft_offline
- https://mycroft.ai/
- https://mycroft.ai/initiatives/
- https://fosspost.org/lists/open-source-speech-recognition-speech-to-text
- https://mycroft-ai.gitbook.io/docs/about-mycroft-ai/faq#can-mycroft-run-completely-offline-can-i-self-host-everything
- https://mycroft-ai.gitbook.io/docs/using-mycroft-ai/customizations/stt-engine
- https://github.com/MycroftAI/selene-backend/issues/203
