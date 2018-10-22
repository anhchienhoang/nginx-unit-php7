# Nginx Unit + PHP7

Build your own image or pull from docker hub:
```bash
$ docker pull anhchienhoang/nginx-unit-php7
```

Run it
```bash
$ docker run -p 80:8300 --name nginx-unit-php -d anhchienhoang/nginx-unit-php7
```

Open your browser and go to
```bash
http://localhost
```

You will see the php-info page.


