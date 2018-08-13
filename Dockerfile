# CircleCI primary docker image to run within
FROM circleci/php:7.2-node-browsers

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Monica CircleCI Primary Docker Image" \
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
                zlib1g-dev \
                libicu-dev \
                libpng-dev \
                mysql-client \
                python-pip

# Install php extensions
RUN set -ex && cd ~ && \
        sudo docker-php-ext-install -j$(nproc) \
                zip \
                intl \
                json \
                iconv \
                bcmath \
                gd \
                pdo_mysql \
                mysqli \
                mbstring

# Install docker-squash
RUN set -ex && cd ~ && \
        pip install docker-squash "docker < 3"

CMD ["/bin/sh"]
