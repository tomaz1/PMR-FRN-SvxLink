
# 🛠️ Koraki za namestitev

### 1.) Poženemo Raspberry Pi Imager

[https://www.raspberrypi.com/software/](https://www.raspberrypi.com/software/)

### 2.) Izberemo "Raspberry Pi OS (other)" → Raspberry Pi OS Lite (**32-bit**)

Izberemo "A port of Debian **Bookworm** with no desktop environment"

### 3.) Predeno zapišemo na kartico, izberemo "EDIT SETTINGS"

in nastavimo hostname, nastavimo uporabniško ime in geslo. Omogočimo  SSH (zavihek Services), nastavimo wifi, če ga bomo uporabljali.

### 4.) Zapišemo na SD kartico in jo vstavimo v RPi3

Priklopimo RPi3. Zgodi se generiranje SSH ključev in 2-3x reboot, konec je šele, ko pokaže IP in čaka na vpis gesla.

P.S.: wifi (wireless) je na začetku izklopljen, če ga ne potrebujemo niti ne bomo nastavili WLAN Country v raspi-config (točka v programu: *5. → L4*)

V nastavitve RPi3 pridemo z ukazom:

```bash
sudo su -

raspi-config
```

<sup>* "sudo su -" ukaz je zato, da ni potrebno pred ukaze vpisovati sudo. Tako postanemo root (uporabnik z največ pravicami)</sup>
<br>

## 5.) ⚒️ Nastavitve raspi-config:

#### "5 Localisation Options" → L1 Locale

→ sl_SI.UTF-8 UTF-8 <Ok> Default locale ostane na en_GB.UTF-8 <Ok>

#### "5 Localisation Options" → L2 Timezone

→ Europe <Ok> Ljubljana <Ok>

#### "5 Localisation Options" → L3 Keyboard

→ pustimo Generic 105-key PC <Ok> Slovenian - Slovenian (with guillemets) <Ok> Right Alt (AltGr) <Ok> No compose key <Ok>
Verjetno nepotrebno, ker se bomo oddaljeno prijavljali preko terminalske SSH seje.

#### "6 Advanced Options" → A1 Expand Filesystem

#### "8 Update"

ali ročno "apt update", "apt upgrade" nato po potrebi "y" (yes)
Obstaja tudi ukaz: "apt full-upgrade"

```bash
reboot
```

## 6.) Nastavitev statičnega IP-ja, če je potrebno

```bash
nmtui 
```

in sledimo GUI vmesniku.

## 7.) Namestitev svxlink strežnika:

```bash
sudo su -
#apt update
apt-get install svxlink-server
```

## 8.) ⚡Nastavitve SvxLink-a:

Poiščemo oz. preverimo ali je AIOC kartica zaznana

```bash
lsusb

#dobiti moramo
#Bus 001 Device 008: ID 1209:7388 Generic All-In-One-Cable
```

Poiščemo ali je zaznalo zvočno kartico na AIOC, [vir](http://np2wj.com/echolink-node-on-raspberry-pi-using-svxlink-part-1/):

```bash

arecord -l 
#prikaže:
#**** List of CAPTURE Hardware Devices ****
#card **2**: AllInOneCable [All-In-One-Cable], device 0: USB Audio [USB Audio]
#  Subdevices: 1/1
#  Subdevice #0: subdevice #0

aplay -l
#card 0: Headphones [bcm2835 Headphones], device 0: bcm2835 Headphones [bcm2835 Headphones]
#  Subdevices: 8/8
#  Subdevice #0: subdevice #0
#  Subdevice #1: subdevice #1
#  Subdevice #2: subdevice #2
#  Subdevice #3: subdevice #3
#  Subdevice #4: subdevice #4
#  Subdevice #5: subdevice #5
#  Subdevice #6: subdevice #6
#  Subdevice #7: subdevice #7
#card 1: vc4hdmi [vc4-hdmi], device 0: MAI PCM i2s-hifi-0 [MAI PCM i2s-hifi-0]
#  Subdevices: 1/1
#  Subdevice #0: subdevice #0
#card **2**: AllInOneCable [All-In-One-Cable], device 0: USB Audio [USB Audio]
#  Subdevices: 1/1
#  Subdevice #0: subdevice #0

vi /usr/share/alsa/alsa.conf #ali nano /usr/share/alsa/alsa.conf
#in spremenimo v 2, ker je AIOC zaznana kot "card 2"
default.ctl.card 2 # iz 0
default.pcm.card 2 # iz 0

reboot
```

Preverimo zvočno kartico

```bash
#nastavitve zvočne kartice:
alsamixer
#P.S. Tu zgoraj se tudi vidi številko USB AIOC zvočne kartice, če pritisnemo tipko F6.

#Takole se verjetno shrani nastavitve, nisem še preveril:
alsactl store
```

Kako ugotovimo serijski port za AIOC:

```bash
ls -l /dev/serial/by-id/
#total 0
#lrwxrwxrwx 1 root root 13 Dec  6 22:21 usb-AIOC_All-In-One-Cable_56a33314-if04 -> ../../ttyACM0
#in vidimo, da je **/dev/ttyACM0**
#ali 
dmesg | grep tty
#...
#[    8.087478] cdc_acm 1-1.5:1.4: ttyACM0: USB ACM device
#in isti rezultat ttyACM0
```

Vidimo, da je /dev/ttyACM0

### Nastavitve svxlink.conf (**NI ŠE KONČNA VERZIJA; v delu**):

[Žigova svxlink.conf datoteka !](../etc/svxlink/svxlink.conf) - za Baofeng 888


```bash
#naredimo varnostno kopijo
cp /etc/svxlink/svxlink.conf /etc/svxlink/svxlink.bkp

#vi ali nano, kar vam je bolj domače:
#nano /etc/svxlink/svxlink.conf
vi /etc/svxlink/svxlink.conf
```

```bash
###############################################################################
#                                                                             #
#                Configuration file for the SvxLink server                    #
#                                                                             #
###############################################################################

[GLOBAL]
#MODULE_PATH=/usr/lib/arm-linux-gnueabihf/svxlink
LOGICS=SimplexLogic
CFG_DIR=svxlink.d
TIMESTAMP_FORMAT="%c"
CARD_SAMPLE_RATE=48000
#mono:
CARD_CHANNELS=1
#LOCATION_INFO=LocationInfo
#LINKS=LinkToR4

[SimplexLogic]
TYPE=Simplex
RX=Rx1
TX=Tx1
#MODULES=ModuleHelp,ModuleParrot,ModuleFrn
MODULES=ModuleParrot,ModuleFrn
#Klicni znak vam dodeli Žiga:
CALLSIGN=S5PMRxxx
SHORT_IDENT_INTERVAL=0
LONG_IDENT_INTERVAL=0
EVENT_HANDLER=/usr/share/svxlink/events.tcl
DEFAULT_LANG=en_US
#-1 da je RGR disabled:
RGR_SOUND_DELAY=-1
#REPORT_CTCSS=123.0
MACROS=Macros
FX_GAIN_NORMAL=0
FX_GAIN_LOW=-12

[Rx1]
TYPE=Local
#Spremenimo iz 0 v 2 (ker smo zgoraj ugotovili, da je zvočna kartica št 2)
AUDIO_DEV=alsa:plughw:2
AUDIO_CHANNEL=0
SQL_DET=VOX
SQL_START_DELAY=300
SQL_DELAY=50
SQL_HANGTIME=1500
VOX_FILTER_DEPTH=100
VOX_THRESH=75
DEEMPHASIS=0
PEAK_METER=1
DTMF_DEC_TYPE=INTERNAL
DTMF_MUTING=1
DTMF_HANGTIME=40
DTMF_SERIAL=/dev/ttyS0
#PREAMP=3
PREAMP=2
#SQL_TAIL_ELIM=100

[Tx1]
TYPE=Local
AUDIO_DEV=alsa:plughw:2
AUDIO_CHANNEL=0
#LIMITER_THRESH=-6
PTT_TYPE=SerialPin
PTT_PORT=/dev/ttyACM0
PTT_PIN=DTR!RTS
TIMEOUT=300
TX_DELAY=500
#Preverite ali je bolje, če je PREEMPHASIS 1 ali 0 (odvisno od postaje)
#PREEMPHASIS=1
PREEMPHASIS=0
DTMF_TONE_LENGTH=100
DTMF_TONE_SPACING=50
DTMF_DIGIT_PWR=-15
#MASTER_GAIN=9
```

### Uredimo ModuleFrn.conf (**NI ŠE KONČNA VERZIJA; v delu**):

```bash
#naredimo varnostno kopijo nastavitev:
cp /etc/svxlink/svxlink.d/ModuleFrn.conf /etc/svxlink/svxlink.d/ModuleFrn.bkp
#vi ali nano, kar vam je bolj domače:
#nano /etc/svxlink/svxlink.d/ModuleFrn.conf
vi /etc/svxlink/svxlink.d/ModuleFrn.conf

[ModuleFrn]
NAME=Frn
PLUGIN_NAME=Frn
ID=2
TIMEOUT=300

# Details http://freeradionetwork.eu/frnprotocol.htm

# main server
SERVER=pmr.si
PORT=10024

# backup server (Zaenkrat ga ni, zato nastavimo enako pmr.si)
SERVER_BACKUP=pmr.si
PORT_BACKUP=10024

# login details
VERSION=2014003
EMAIL_ADDRESS=emailnaslov@nekaj.nekaj
DYN_PASSWORD=GESLO
CLIENT_TYPE=1
CALLSIGN_AND_USER="S5PMRxxx, Ime"
BAND_AND_CHANNEL="446.xxxxxFM CTCSS 123.0Hz"
DESCRIPTION="CH1x(SUB18), SvxLink, RPi3, Baofeng UV5R, AIOC, Yagi antena na strehi"
COUNTRY=Slovenia
CITY_CITY_PART="Kraj - Predel kraja"
NET=Test

# debugging
#FRN_DEBUG=1
#DISABLE_RF=1
```

### Namestitev zvočnih datotek za SvxLink:

Pri trenutni postavitvi piše, da gre za svxlink v1.7.0 in zgleda je to verzija 19.09, [vir](https://github.com/sm0svx/svxlink/blob/maint/src/doc/README-19.09.adoc)<br>
Kako se namesti datoteke, [vir](https://it9fdp.blogspot.com/2015/09/installare-svxlink.html):

```bash
sudo su -
cd /usr/share/svxlink/sounds/
wget https://github.com/sm0svx/svxlink-sounds-en_US-heather/releases/download/19.09/svxlink-sounds-en_US-heather-16k-19.09.tar.bz2
bunzip2 svxlink-sounds-en_US-heather-16k-19.09.tar.bz2
tar -xvf svxlink-sounds-en_US-heather-16k-19.09.tar
cp -r en_US-heather-16k en_US
rm svxlink-sounds-en_US-heather-16k-19.09.tar
rm -r ./en_US-heather-16k/
```


### Uredimo logiko, da se avtomatsko požene FRN modul:
Gre za spremenjeno Tilnovo SimplexLogic.tcl datoteko!

[Datoteka SimplexLogic.tcl](../usr/share/svxlink/events.d/SimplexLogic.tcl)

Gre za to, da ob zagonu programa takoj oz. 1 minuto po zagonu SvxLink programa avtomatsko aktivira FRN modul. Če kdo na SvxLinku z DTMF toni aktivira papigo (ali kakšen drug modul) bo le ta aktiven največ minuto, nato bo sistem sam preklopil nazaj v Frn način :)

```bash
#vi ali nano, kar vam je bolj domače:
#nano /usr/share/svxlink/events.d/SimplexLogic.tcl
vi /usr/share/svxlink/events.d/SimplexLogic.tcl
#urediti začetek (nove spremenljivke)

#in dodamo kodo v
#proc every_minute {} {
#    ...
```

### Da ob zagonu FRN modula tega ne govori v eter/internet:

```bash
#vi ali nano, kar vam je bolj domače:
#nano /usr/share/svxlink/events.d/Module.tcl
vi /usr/share/svxlink/events.d/Module.tcl

#zakomentiramo activating/deactivating modula

proc activating_module {module_name} {
  #playMsg "Default" "activating";
  #playSilence 100;
  #playMsg $module_name "name";
  #playSilence 200;
}

#
# Executed when a module is being deactivated.
#
proc deactivating_module {module_name} {
  #playMsg "Default" "deactivating";
  #playSilence 100;
  #playMsg $module_name "name";
  #playSilence 200;
}
```

### Nastavimo, da se svxlink vedno zažene bo zagonu:

```bash
#test delovanja
sudo -u svxlink svxlink

#da se zažene avtomatsko po rebootu/zagonu
sudo svxlink --daemon

#kontrola servica:
sudo systemctl status svxlink

#Če želimo ustaviti servis, da bomo potestirali delovanje z različnimi nastavitvami to naredimo tako:
sudo systemctl stop svxlink
sudo -u svxlink svxlink
    #da zapremo / končamo testiranje pritisnemo tipke: CTRL+C

#Ko smo zadovoljni z rezultatom lahko ponovno poženemo SvxLink, da teče kot servis v ozadju
systemctl start svxlink

```

### Logi SvxLink:

```bash
#spremljanje loga v živo:
tail -f /var/log/svxlink
```

## 9.) Nastavitev oddaljenega SSH dostopa preko brskalnika (brez odpiranja portov)

Oddaljen SSH dostop je možen na več načinov, navodila za dostop z uporabo:
  - [storitve CloudFlare Zero Trust](CloudFlare.md)
  - [VPN WireGuard](VPN-WireGuard.md)
  - [storitve Raspberry Pi Connect (TODO)](RPi-Connect.md)
  

<br>
<hr>

## 10.) Če imate težave z VOX sprejemanjem?

Če vas radijska postaja sprejema in pošilja v FRN omrežje, vendar se pogosto dogaja, da če ste tiho VOX ne zazna govora in prekine pošiljanje v FRN omrežje? 

[Nadgradnja AIOC na firmware 1.3 in uporaba proženja preko HIDRAW namesto preko serijskega porta (Navodilo, povezava na navodila).](AIOC-upgrade-FW-to-1.3.md)

## 11.) 🔌/🔋 Napajanje
(TODO)

## Pomoč / Viri

- #### [Navodila za namesitev FRN prehoda na sistemu Java FRN](https://slo-tech.com/forum/t834577/p8355681?fbclid=IwZXh0bgNhZW0CMTAAAR3apADiQJbOcgX9zCMiAXMCZ_xrUPe8YrlSoydmHYD4oyywWxe3iKNXdxw_aem_7KIs547M3SwynhY7aNpZ_Q#p8355681) (Slo-Tech forum)

- [Github SvxLink](https://github.com/sm0svx/svxlink)
- [SvxLink Discussions](https://groups.io/g/svxlink)
- [AIOC adapter](https://github.com/skuep/AIOC)


## Zahvale
@Žiga<br>
@Tilen<br>
@Franc (Radovljica)<br>
... **TODO - Dodati še vse ostale**

<hr>
Datum: 12/2024 

[@Tomaz1](https://github.com/tomaz1) - priprava navodil.

<hr>

#### [Pojdi nazaj](../README)