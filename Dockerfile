FROM devopsfaith/krakend

ADD ./krakend.json /etc/krakend/krakend.json

EXPOSE 8080
