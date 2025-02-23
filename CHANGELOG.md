# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog],
and this project adheres to [Semantic Versioning].

## [Unreleased]

- Ideja: da bi imeli več wget ukazov, in bi lahko enostavneje namestili zadevo, tudi samo navodilo bi bilo tako lahko krajše :)

### Added
- 

## [0.0.5] - 2025-02-23

### Added

- Dodanova Žigova skripta svxlink-healthcheck (in pripravljena instalacijska procedura, da je namestitev lažja), ki preverja ali je service delujoč in če ni, da se ponovno zažene. To pomeni, da če želimo res ustaviti svxlink je postopek sledeč:
  -     sudo systemctl stop svxlink_healthcheck
  -     sudo systemctl stop svxlink
- Dodana ikonica favicon.ico in _includes\head-custom.html, da je na vseh github pages in vseh podstraneh tudi vključena .ico :). Ico dodan tako: \<link rel="shortcut icon" type="image/x-icon" href="{{ site.baseurl }}/favicon.ico"\>
- Dodana funkcionalnost, da če ni interneta, da prehod preklopi v način papagaja (Hvala @Žiga)
- Dodano nekaj wget ukazov za poenostavitev (niso še vsi, ki bi si jih želel)

### Changed


## [0.0.4] - 2024-12-21

### Added

- Dodan github-pages in tema: Tactile z dodatkoma: style.scss in _config.yml (z [relative-links](https://github.com/benbalter/jekyll-relative-links) pluginom)

### Changed

- obrnjena stran na glavo, kar je bilo na osnovni strani je bilo prestavljeno na dve podstrani


## [0.0.3] - 2024-12-20

### Changed

- Razdelek na CloufFlare - Težave prestavljen v ločeno datoteko

### Added

- Dodana prazna datoteka za RPi Connect
- Dodana navodila za WireGuard - VPN-WireGuard.md
- Dodani razdelki: Predpogoji za postavitev SvxLinka, Napajanje, Kako zgleda FRN prehod?

## [0.0.2] - 2024-12-16

### Added

- dodana datoteka ModuleFrn.conf (zaradi enostavnejšega wget)
- dodana datoteka Module.tcl (zaradi enostavnejšega wget)
- dodan razdelek AIOC in kako se nagradi AIOC firmware na v1.3

### Changed

- v datoteki ModuleFrn.conf in README spremenjena verdnost SERVER_BACKUP=pmr.si

## [0.0.1] - 2024-12-14

- initial release

<!-- Links -->
[keep a changelog]: https://keepachangelog.com/en/1.0.0/
[semantic versioning]: https://semver.org/spec/v2.0.0.html

<!-- Versions -->
[unreleased]: https://github.com/tomaz1/PMR-FRN-SvxLink/compare/v0.0.5...HEAD
[0.0.5]: https://github.com/tomaz1/PMR-FRN-SvxLink/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/tomaz1/PMR-FRN-SvxLink/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/tomaz1/PMR-FRN-SvxLink/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/tomaz1/PMR-FRN-SvxLink/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/tomaz1/PMR-FRN-SvxLink/releases/tag/v0.0.1