FROM debian:11

# install requirements
RUN apt-get update && apt-get install build-essential python3 python3-dev python3-venv apache2 libapache2-mod-rpaf inotify-tools netcat graphviz pip --yes
RUN pip install poetry

# RUN mkdir /var/log/api/
ADD setup.sh /
ENTRYPOINT ["/setup.sh"]
# HEALTHCHECK --interval=10s --retries=1 --start-period=30s CMD /shared/healthcheck.sh
