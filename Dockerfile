ARG TYPO3_VERSION=10
ARG IMAGE_TAG=7-apache

FROM php:${IMAGE_TAG}

# Install git
RUN apt-get update && apt-get install -y git icu-devtools libicu-dev zip unzip iputils-ping

# Install php extensions
RUN docker-php-ext-install intl mysqli pdo_mysql
RUN docker-php-ext-enable mysqli pdo_mysql

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Allow composer to install dependencies as root
ENV COMPOSER_ALLOW_SUPERUSER=1

# Set web root to public directory
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN chown www-data:www-data /var/www/html; \
	     chmod -R 777 /var/www/; 
USER www-data

# Create typo3 project with composer
RUN composer create-project typo3/cms-base-distribution:$TYPO3_VERSION . --no-interaction



# Install rector with composer
RUN composer require rector/rector --dev

# Create rector configuration file for TYPO3 CMS
# RUN ./vendor/bin/rector init --template-type=typo3

# OR add rector configuration file
# ADD rector.php /app/

# Add scripts
COPY rootfs /

CMD [ "entrypoint" ]
