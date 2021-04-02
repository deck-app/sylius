#!/bin/sh

cd /var/www
export COMPOSER_PROCESS_TIMEOUT=2600
if [ -d "bin" ]; then 
echo "Git already exists"
composer install
else
git clone https://github.com/nabad600/sylius.git sylius
cd /var/www/sylius/
cp -a * /var/www/
composer install
echo "Download completed..."
fi

cp /sbin/app /var/www/.env
cd /var/www

bin/console sylius:install
# until bin/console doctrine:query:sql "select 1" >/dev/null 2>&1; do
# 	    (>&2 echo "Waiting for MySQL to be ready...")
# 		sleep 1
# done

bin/console doctrine:migrations:migrate --no-interaction

exec "$@"