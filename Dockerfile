FROM buildpack-deps:stretch-curl

RUN curl -sSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list &&\
    curl -sSL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get update && \
    apt-get install -qqy google-chrome-unstable nodejs xvfb dbus-x11 && \
    apt-get clean -qqy && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN npm i -g --silent tape-run

COPY xvfb /etc/init.d/xvfb

COPY entrypoint.sh /

RUN chmod +x /etc/init.d/xvfb && \
    chmod +x /entrypoint.sh

RUN useradd -m chromeuser && \
    adduser chromeuser sudo

ENTRYPOINT ["/entrypoint.sh"]
