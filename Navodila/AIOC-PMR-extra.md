# Priprava vezja in vezava AIOC na PMR postajo

Na primeru "Alecto FR-66"

## 🔧 Izmerimo kaj se dogaja na priloženem zunanjem mikrofonu, ko stisnemo PTT

Multimeter pokaže 1,2 &Omega; med GND in MIC+ in to sporoči PMR postaji, da gre na oddajo (PTT).
Uporablja samo 3 povezave od 4ih na bananci zunanjega mikrofona postaje. To so: GND, MIC+, SOUND+. 

### 1.) Izmerimo kaj je na izhodih AIOC adapterja?

Na sliki sta še dva neoznačena konektorja, verjetno gre za stereo del zvoka.
![AIOC pinout](../img/AIOC-PMR-extra-pinout.png)

### 2.) Ker rabimo 1,2 &Omega; upora na PMR na mikrofonskem vhodu je potrebno pripraviti inverzni signal

ChatGPT je pomagal pripraviti idejo, kako signal PTT iz AIOC obrniti, da bo na oddaji visok (3V) namesto trenutnega niskega signala na oddaji (0V)
Pripravljena shema z dvema tranzistorjema, da se obrne PTT signal:

![Shema](../img/AIOC-PMR-shema.png)

Ideja, je da bi bila pozicija uporov tako, da je čim manj križanj:

![Shema-kabli](../img/AIOC-PMR-shema1.png)

3D prikaz:

![3D prikaz spredaj](../img/AIOC-PMR-shema2-3D.png)

3D prikaz, da se vidi kako so povezane žice, potrebno za naslednji korak:

![3D prikaz zadaj](../img/AIOC-PMR-shema3-3D.png)

### 4.) Pripravimo vezja:

Eksperimentiranje z različnimi upori:

![Board elementi](../img/AIOC-PMR-shema4.png)

Nato priprava končne verzije:

![Vezje](../img/AIOC-PMR-shema5.png)

![alt text](../img/AIOC-PMR-shema6.png)

![alt text](../img/AIOC-PMR-shema7.png)

![alt text](../img/AIOC-PMR-shema8.png)!

[alt text](../img/AIOC-PMR-shema9.png)

![alt text](../img/AIOC-PMR-shema10.png)

<hr>

#### [Pojdi nazaj](RPi3-glavna-navodila.md)