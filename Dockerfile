FROM debian:8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get -qq -y --no-install-recommends install \
    ca-certificates \
    curl \
    python \
    python-setuptools

RUN mkdir /etc/supervisord \
    && mkdir /etc/supervisord/conf.d \
    && mkdir /var/log/supervisord

RUN curl -L -s \
        https://github.com/Supervisor/supervisor/archive/3.2-branch.tar.gz \
        | tar xz -C /usr/local/src \
    && (cd /usr/local/src/supervisor-3.2-branch/ && python setup.py -q install)

COPY supervisord.conf /etc/supervisord/
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord/supervisord.conf"]
