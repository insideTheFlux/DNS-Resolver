server  {
        server_name     domain.com;
        return 301 https://www.domain.com$request_uri;
}

server {

        root /var/www/domain.com;
        index index.html index.htm;

        server_name www.domain.com;

        location / {
                try_files $uri $uri/ =404;
        }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/dns.domain.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/dns.domain.com/privkey.pem; # managed by Certbot
    include /etc/nginx/tls.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

    add_header Strict-Transport-Security "max-age=31536000" always;
    add_header Access-Control-Allow-Methods "GET, HEAD, POST";

}

#server {
#    if ($host = www.domain.com) {
#        return 301 https://$host$request_uri;
#    } # managed by Certbot


 #       listen 80;
 #       listen [::]:80;

  #      server_name www.domain.com;
  #  return 404; # managed by Certbot


# }
