#!/bin/bash

cd /src/indexer-api
poetry install
export VENV_PATH=$(/usr/local/bin/poetry env info -p)

# add venv bin path to PATH for easy access
if ! grep PATH /root/.bashrc >/dev/null 2>&1; then
  echo "export PATH=\"$VENV_PATH/bin:$PATH\"" >> /root/.bashrc
fi
source /root/.bashrc

echo "waiting for DB spot-sql:3306..."
while ! nc -w 1 spot-sql 3306 2>/dev/null
do
  echo -n .
  sleep 1
done
echo 'ok'

while true
do
	uvicorn indexer_api.main:app --host 0.0.0.0 --port 8000 --reload
	echo "FastAPI crashed - Waiting 5 seconds for auto restart..."
	sleep 5s
done

#test
