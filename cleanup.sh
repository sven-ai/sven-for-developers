#!/usr/bin/env bash


docker stop open-webui; docker rm open-webui;
# docker volume rm owui-data;

docker stop sven-llm-api; docker rm sven-llm-api;
# docker volume rm sven-llm-api-data;

docker stop chromadb; docker rm chromadb;
# docker volume rm chromadb-data;

#
# NOTE: data & db files live in ~/sven/* now.
#