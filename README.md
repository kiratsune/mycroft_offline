[WIP] Trying to fix everything to 'make it just works' on my server.  
This project is a collection of files which helps you deploy a full instance of [mycroft](https://mycroft.ai/) (both backend and frontend).

## Goal

Deploy a home assistant offline as easy as possible.

## Why

There are various home assistant solutions out there but all of them transfer your voice to some server for processing. This is a no-go for many people although the technology is interesting and could be useful. There are various open source tools to achieve the same result but there is no turn-key open source self hosted solution. The goal of this project is to implement a way to have a home assistant running locally - ideally with one command.

The project that is closer to the desired result is Mycroft (https://mycroft.ai/). It is very easy to run the client side components using one docker command but their backend is running remotely. All the tools they use though are open source so it only needs one to do the work and package them in a nice little docker-compose file (https://mycroft-ai.gitbook.io/docs/about-mycroft-ai/faq#can-mycroft-run-completely-offline-can-i-self-host-everything).

## Prerequisites

- yq tool: https://github.com/mikefarah/yq/releases (to parse yaml configuration)
- docker: https://www.docker.com/get-started
- docker-compose: https://docs.docker.com/compose/
- Internet connection to download docker images and dependencies

## Build needed images

Build all the needed images for front-end and back-end:

```
$ make images
```

## Deploy

Start by copying `mycroft.yaml.sample` to `mycroft.yaml`. Then edit the values as needed.

Then run:

```
$ make
```

To cleanup run:

```
$ make clean
```

## Troubleshooting

Problem: No skills available in the marketplace.  
Solution: your selene version is too high... A quick fix is to edit get_display_data_for_skills.sql and change the equal sign = for a less or equal sign <= in the WHERE clause. (In a container the file is in : /opt/selene/selene-backend/shared/selene/data/skill/repository/sql/get_display_data_for_skills.sql )  

Problem: Adding a new device does nothing.  
Solution: Add the selected wake wors in the database (Yes, no wake word are in the database by default, even if they are on the UI..), use something like an Adminer container to edit the databse manually and add the 'Hey mycroft' wake word. The backend is 'precise', the display name 'Hey Mycroft' and name 'hey mycroft'. Account can be null.

## TODO
Include a fix for the problems in the troubleshooting section.  
Rewrite the nginx config to expose api only on the required domains ? to make it easier to split this on multiple computers without docker swarm ?  

## Note

This project started as part of SUSE Hackweek 19: https://hackweek.suse.com/projects/home-assistant-that-doesnt-spy-on-you-developers-edition

Idea: Create a mycroft skill to deploy apps with CF (cf cli wrapper)

## Links

- https://mycroft.ai/
- https://mycroft.ai/initiatives/
- https://fosspost.org/lists/open-source-speech-recognition-speech-to-text
- https://mycroft-ai.gitbook.io/docs/about-mycroft-ai/faq#can-mycroft-run-completely-offline-can-i-self-host-everything
- https://mycroft-ai.gitbook.io/docs/using-mycroft-ai/customizations/stt-engine
- https://github.com/MycroftAI/selene-backend/issues/203

## TODO

- Add precise container for wake word and make sure it's used by mycroft (check `mycroft-conf get`):
  https://mycroft-ai.gitbook.io/docs/using-mycroft-ai/troubleshooting/wake-word-troubleshooting#precise
