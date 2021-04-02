ARG NODE_VERSION=10
FROM node:${NODE_VERSION}-alpine AS sylius_nodejs

WORKDIR /srv/sylius

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		g++ \
		gcc \
		git \
		make \
		python \
	;

# prevent the reinstallation of vendors at every changes in the source code
COPY package.json yarn.lock ./
RUN set -eux; \
	yarn install; \
	yarn cache clean

# COPY --from=sylius_php /srv/sylius/vendor/sylius/sylius/src/Sylius/Bundle/UiBundle/Resources/private vendor/sylius/sylius/src/Sylius/Bundle/UiBundle/Resources/private/
# COPY --from=sylius_php /srv/sylius/vendor/sylius/sylius/src/Sylius/Bundle/AdminBundle/Resources/private vendor/sylius/sylius/src/Sylius/Bundle/AdminBundle/Resources/private/
# COPY --from=sylius_php /srv/sylius/vendor/sylius/sylius/src/Sylius/Bundle/ShopBundle/Resources/private vendor/sylius/sylius/src/Sylius/Bundle/ShopBundle/Resources/private/

# COPY --from=sylius_php /srv/sylius/vendor/sylius/sylius/src/Sylius/Bundle/AdminBundle/gulpfile.babel.js vendor/sylius/sylius/src/Sylius/Bundle/AdminBundle/gulpfile.babel.js
# COPY --from=sylius_php /srv/sylius/vendor/sylius/sylius/src/Sylius/Bundle/ShopBundle/gulpfile.babel.js vendor/sylius/sylius/src/Sylius/Bundle/ShopBundle/gulpfile.babel.js

COPY gulpfile.babel.js .babelrc ./
# RUN set -eux; \
# 	GULP_ENV=prod yarn build

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD ["yarn", "watch"]
