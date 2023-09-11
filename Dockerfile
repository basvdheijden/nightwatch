FROM node:17

RUN apt-get update -y && apt-get install -y jq zip wget unzip xdg-utils curl xvfb gtk2-engines-pixbuf xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable x11-apps \
	&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
	&& dpkg -i --force-depends google-chrome-stable_current_amd64.deb \
	&& apt-get -y -f install \
	&& rm google-chrome-stable_current_amd64.deb \
	&& mkdir /var/www

COPY ./package.json /var/www/
COPY ./package-lock.json /var/www/
COPY ./nightwatch.conf.js /var/www/

RUN cd /var/www/ && npm install

WORKDIR /var/www/

ENTRYPOINT ["/usr/local/bin/npx nightwatch -e chrome"]
CMD ["node_modules/nightwatch/examples/tests/ecosia.js"]
