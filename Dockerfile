FROM haproxy:1.5

MAINTAINER Jan Vincent Liwanag <jvliwanag@gmail.com>

ADD haproxy.cfg.in /haproxy.cfg.in
ADD start.sh /start.sh

EXPOSE 80
EXPOSE 443

CMD ["/start.sh"]

