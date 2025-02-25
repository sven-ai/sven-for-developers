#!/usr/bin/env bash
#
# Script is intented to run inside of a docker container
#

rm -rf llm-api-local;
git clone https://github.com/sven-ai/llm-api-local

cd llm-api-local
pip install -r py.reqs.list

cd src
python server.py