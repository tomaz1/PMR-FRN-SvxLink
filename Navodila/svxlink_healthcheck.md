## Navodilo kako se ročno namesti svxlink_helthcheck

### Program skrbi, da je svxlink vedno pognan, četudi preneha delovati zaradi kateregakoli razloga

Avtor: Žiga, dec. 2024.

```bash
#nano ali vi, kar vam je bolj domače:
sudo vi /usr/local/bin/svxlink_healthcheck.sh

```
[svxlink_healthcheck.sh](../usr/local/bin/svxlink_healthcheck.sh)

```bash
sudo chmod +x /usr/local/bin/svxlink_healthcheck.sh
```

```bash
#nano ali vi, kar vam je bolj domače:
sudo vi /etc/systemd/system/svxlink_healthcheck.service

```
[svxlink_healthcheck.service](../etc/systemd/system/svxlink_healthcheck.service)

```bash
sudo systemctl daemon-reload
sudo systemctl enable svxlink_healthcheck.service
sudo systemctl start svxlink_healthcheck.service

```
Po potrebi preverimo loge
```bash
sudo tail -f /var/log/svxlink_healthcheck.log
```

V kolikor bi želeli, da svxlink namenoma res ostane izklopljen:
```bash
sudo systemctl stop svxlink_healthcheck
sudo systemctl stop svxlink
```

#### [Pojdi nazaj](./RPi3-glavna-navodila.md)