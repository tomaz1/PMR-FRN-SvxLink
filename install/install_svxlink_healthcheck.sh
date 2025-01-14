#!/bin/bash
#23. 12. 24 Tomaz, ideja: da avtomatiziramo namestitev servica za helthcheck.sh

sudo wget https://tomaz1.github.io/PMR-FRN-SvxLink/usr/local/bin/svxlink_healthcheck.sh -P /usr/local/bin/
sudo chmod +x /usr/local/bin/svxlink_healthcheck.sh
sudo wget https://tomaz1.github.io/PMR-FRN-SvxLink/etc/systemd/system/svxlink_healthcheck.service -P /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable svxlink_healthcheck.service
sudo systemctl start svxlink_healthcheck.service


