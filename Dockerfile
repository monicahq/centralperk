# CircleCI primary docker image to run within
FROM circleci/php:7.2-apache-node-browsers

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Monica CircleCI Tests Docker Image" \
      org.label-schema.description="Monica custom-built docker image for CircleCI 2.0 jobs. Includes all tools needed to test monica." \
      org.label-schema.url="https://monicahq.com" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/monicahq/centralperk" \
      org.label-schema.vendor="Monica" \
      org.label-schema.version=$VCS_REF \
      org.label-schema.schema-version="1.0"

# Install packages
RUN set -ex && cd ~ && \
        sudo apt-get update && \
        sudo apt-get install -y \
                mysql-client && \
        sudo apt-get clean -y

# Install Chrome
#RUN set -ex && cd ~ && \
#        sudo apt-get install lsb-release && \
#        sudo apt-get clean -y && \
#        curl -L -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
#        sudo dpkg -i google-chrome.deb && \
#        sudo sed -i 's|HERE/chrome"|HERE/chrome" --disable-setuid-sandbox --no-sandbox|g' /opt/google/chrome/google-chrome && \
#        rm -f google-chrome.deb

# Install php extensions
RUN set -ex && cd ~ && \
        sudo apt-get install -y libpng-dev && \
        sudo apt-get clean -y && \
        sudo docker-php-ext-install -j$(nproc) \
                json \
                iconv \
                bcmath \
                gd \
                pdo_mysql \
                mysqli \
                soap \
                mbstring && \
        sudo apt-get remove -y \
                libicu-dev

CMD ["/bin/sh"]
