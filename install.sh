#!/usr/bin/env bash


if [ -z "$ANTHROPIC_API_KEY" ]; then
   echo "ERR. ANTHROPIC_API_KEY env expected"
   echo "Set it like so in a Terminal: export ANTHROPIC_API_KEY=your_api_key_here"
   echo "Get your key at https://console.anthropic.com"
   
   exit 1
fi


docker network create sven;


#
# ChromaDB
#
# docker network connect sven chromadb

# docker volume create chromadb-data;
ChromaDataFolder="$HOME/sven/chromadb-data"
mkdir -p "$ChromaDataFolder"

docker run -d --restart=unless-stopped \
	--network=sven --hostname=chromadb \
	-v $ChromaDataFolder:/data \
	-e ANONYMIZED_TELEMETRY=False \
	--name=chromadb chromadb/chroma

	# -v chromadb-data:/data \


#
# sven-llm-api service
#
# docker network connect sven sven-llm-api

# docker volume create sven-llm-api-data;
LLMApiDataFolder="$HOME/sven/llm-api-data"
mkdir -p "$LLMApiDataFolder"

docker run -d --restart=unless-stopped \
	-e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
	--network=sven --hostname=sven-llm-api -p 12345:12345 \
	-w /sven \
	-v $LLMApiDataFolder:/data \
	--name=sven-llm-api python:3.13 /bin/sh -c "curl -o llm-api.start.in-docker.sh https://raw.githubusercontent.com/sven-ai/sven-for-developers/refs/heads/main/llm-api.start.in-docker.sh && chmod +x llm-api.start.in-docker.sh && ./llm-api.start.in-docker.sh"

	# -v $PWD:/sven \
	# --name=sven-llm-api python:3.13 ./llm-api.start.in-docker.sh


#
# Open WebUI
#
# docker network connect sven open-webui

# docker volume create owui-data;
OWUIDataFolder="$HOME/sven/owui-data"
mkdir -p "$OWUIDataFolder"

docker run -d --restart=unless-stopped \
	--env-file=owui.env \
	--network=sven --hostname=open-webui -p 3000:8080 \
	-v $OWUIDataFolder:/app/backend/data \
	--name open-webui ghcr.io/open-webui/open-webui:main

	# -v owui-data:/app/backend/data \


