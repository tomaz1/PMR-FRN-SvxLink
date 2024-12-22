# Nekaj morda zanimivh ukazov:

```bash
ln -s /etc/svxlink/svxlink.conf ~/link-svxlink.conf
ln -s /etc/svxlink/svxlink.d/ModuleFrn.conf ~/link-ModuleFrn.conf
ln -s /usr/share/svxlink/events.d/SimplexLogic.tcl ~/link-SimpleLogic.tcl
```

```bash
#Nato lahko kasneje spreminjamo vse nastavitve neposredno, da nam ni potrebno razmišljati, kje so že nastavitvene datoteke.
vi link-svxlink.conf
vi link-ModuleFrn.conf
```

Vsebina datoteke: ***restartFRN.sh***

```bash
cat restartFRN.sh
#Restart svxlink strežnika:
systemctl restart svxlink
```

```bash
#Nastavimo, da se skripta lahko izvede:
chmod +x restartFRN.sh
```
```bash
#ko potrebujemo restart strežnika poženemo ukaz:
./restartFRN.sh
```

<hr>

#### [Pojdi nazaj](Rpi3-glavna-navodila.md)