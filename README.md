[WIP] Trying to fix everything to 'make it just works' on my server.  

This project is a collection of files which helps you deploy a full instance of [mycroft](https://mycroft.ai/) (only backend, APIs and web-ui, the front-end (enclosures) can already be setup with one docker command).  
  
Heavily based on the original repo by jimmykarily at https://github.com/jimmykarily/mycroft_offline .  

## Goal

Deploy an offline home assistant server as easely as possible.

## Why

There are various home assistant solutions out there but all of them transfer your voice to some server for processing. This is a no-go for many people although the technology is interesting and could be useful. There are various open source tools to achieve the same result but there is no turn-key open source self hosted solution. The goal of this project is to implement a way to have a home assistant running locally - ideally with one command.

The project that is closer to the desired result is Mycroft (https://mycroft.ai/). It is very easy to run the client side components using one docker command but their backend is running remotely. All the tools they use though are open source so it only needs one to do the work and package them in a nice little docker-compose file (https://mycroft-ai.gitbook.io/docs/about-mycroft-ai/faq#can-mycroft-run-completely-offline-can-i-self-host-everything).

## Prerequisites

- docker: https://www.docker.com/get-started
- docker-compose: https://docs.docker.com/compose/
- Internet connection to download docker images and dependencies
- A good CPU, STT AND TTS are very CPU intensive. (Using a (nvidia/CUDA ?) GPU would speed up the process a lot but I don't know if it works with my setup yet.)

## Getting started

Edit and complete thses files:  
  
- config.env
- config_external_accounts;env
- .env

Run ./setup.sh (only needed once)  

Run docker-compose up -d  
And everything is ready to go. The setup phase can take while.  
## Troubleshooting

#### Problem: No skills available in the marketplace.  
**Solution** :  your selene version is too high... A quick fix is to edit get_display_data_for_skills.sql and change the equal sign = for a less or equal sign <= in the WHERE clause. (In a container the file is in : /opt/selene/selene-backend/shared/selene/data/skill/repository/sql/get_display_data_for_skills.sql )  

## TODO
- Make TTS and STT use the GPU. Not very difficult to do, but they seem to use CUDA and for now I don't plan on installing anything proprietary on my servers.
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
