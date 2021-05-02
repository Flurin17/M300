# Leistungsbeurteilung 3 Modul 300
## _Flurin Laim_
TBZ 1.5.2021


## Inhaltsverzeichnis
* Serice Beschreibung
* Service Anwendungsbereich
* Grafische Übersicht
* Code Beschreibung
* Testprotokoll
* Quellenverzeichnis

## Service Beschreibung
Mein Docker Compose verbindet verschiedene Webapplikationen. Folgende Applikationen werden verwendet:
| Docker | Image |
| ------ | ------ |
| [Nginx][nginx] | nginx:latest |
| [Plex][plex] | plexinc/pms-docker:latest | 
| [BitTorrent][bittorrent] | ghcr.io/linuxserver/qbittorrent:latest |
## Service Anwendungsbereich
Der Service kann für verschiedene Anwendungen verwendet werden, da der Nginx Reverse Proxy server vielseitig einsetzbar ist und so unendlich viele Services über ein Kontenpunkt erreicht werden können.
Mein Einsatzzweck hier ist jedoch ein kleines Entertainmentsystem, welches Abspielen von Filmen, etc. möglich macht und das Herunterladen dieser Filme durch einen Torrentclient.
Durch den Reverse Proxy können diese Systeme auf dem gleichen Docker angesprochen werden.

## Grafische Übersicht
![Grafik](https://nexcon.ch/wp-content/uploads/2020/02/reverse_proxy.png)

## Code Beschreibung

### Nginx Docker Image erstellen
```
FROM nginx:latest
COPY nginx.conf /etc/nginx/conf.d/default.conf
```
* Hollt sich das nötige Image
* Der zweite Command kopiert ein File in das Docker Image herein

### Netzwerkkonfiguration
```
networks:
    media_network:
        driver: bridge
        ipam:
            driver: default
            config:
                - subnet: 192.168.60.0/24
```


## Testprotokoll

| Nötige Eingabe /Aktion | Erwartetes Ergebnis | Tatsächliches Ergebnis |
| ------ | ------ | ---- |
| docker-compose up -d| Alle drei Docker starten gleichzeitig | Alle drei Docker starten gleichzeitig |
| 192.168.60.101 im Browser eingeben| Es öffnet sich nichts, da man die richtigen Endpoints angeben muss |Die Website funktioniert nicht, da dass docker-compose im Bridge Modus läuft. Der Service kann unter 127.0.0.1 erreicht werden |
| 192.168.2.10/api im Browser eingeben | Die API öffnet sich und gibt Hello World zurück | Die API öffnet sich und gibt Hello World zurück |



## Quellenverzeichnis
Grafik für Aufbau, <https://nexcon.ch/traefik-der-moderne-reverse-proxy/>, 2.5.2021


[nginx]: <https://www.nginx.com/>
[plex]: <https://www.plex.tv/>
[bittorrent]: <https://www.bittorrent.com/de/>
