#!/bin/bash

cd /src/indexer-api
poetry install
export VENV_PATH=$(/usr/local/bin/poetry env info -p)

# add venv bin path to PATH for easy access
if ! grep PATH /root/.bashrc >/dev/null 2>&1; then
  echo "export PATH=\"$VENV_PATH/bin:$PATH\"" >> /root/.bashrc
fi
source /root/.bashrc

while true
do
	uvicorn indexer_api.main:app --host 0.0.0.0 --port 8000 --reload
	echo "FastAPI crashed - Waiting 5 seconds for auto restart..."
	sleep 5s
done
