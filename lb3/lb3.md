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
* Hier setzen wir den Modus der Netzwerkkonfiguration 
* Das Subnetz wird ebenfalls gesetzt.

### Container im Docker Compose
```
plex:
        image: plexinc/pms-docker
        container_name: plex
        environment:
            - PUID=1000
            - PGID=1000
            - TZ=Europe/Zurich
        volumes:
            - /plex/library:/config
            - /plex/tvseries:/tv
            - /plex/movies:/movies
        
        networks:
            media_network:
                ipv4_address: 192.168.60.102
        ports:
            - 32400:32400
        restart: unless-stopped
```
* Image
  * Wir setzen das erwünschte Image
* Container Name
  * Geben dem Container einen Namen
* Environment
  * PUID und PGID Sind Benutzer und Gruppe damit der Dienst nicht als Admin läuft
  * TZ ist die Zeitzone
* Volumes
  * Hier werden die verschiedenen Speicherorte angegeben die persistent sind.
* Networks
  * Setzen die Netzwerkschnittstelle
* Ports
  * Geben die Ports frei. Links ist nach aussen und rechts die Ports im Docker selbst
* Restart
  * Gibt an, dass der Docker neustarten soll falls er zum Beispiel abgestürzt ist.



## Testprotokoll

| Nötige Eingabe /Aktion | Erwartetes Ergebnis | Tatsächliches Ergebnis |
| ------ | ------ | ---- |
| docker-compose up -d| Alle drei Docker starten gleichzeitig | Alle drei Docker starten gleichzeitig |
| 192.168.60.101 im Browser eingeben| Es öffnet sich nichts, da man die richtigen Endpoints angeben muss | Die Website funktioniert nicht, da dass docker-compose im Bridge Modus läuft. Der Service kann unter 127.0.0.1 erreicht werden |
| 127.0.0.1/torrent im Browser eingeben | Der Torrent Dienst öffnet sich und das Loginformular erscheint | Der Torrent Dienst öffnet sich und das Loginformular erscheint |
| 127.0.0.1/plex im Browser eingeben | Der Plex Dienst öffnet sich und das Loginformular erscheint | Leider funktioniert dies nicht, da die Konfiguration des Docker Containers von Plex anders als normal ist. Unter <http://127.0.0.1/plex/web/index.html#!/> funktioniert es ||
| docker-compose logs in Powershell eingeben| Zeigt alle Logs die in den Container erstellt worden sind an | Zeigt alle Logs die in den Container erstellt worden sind an |

## Quellenverzeichnis
Grafik für Aufbau, <https://nexcon.ch/traefik-der-moderne-reverse-proxy/>, 2.5.2021


[nginx]: <https://www.nginx.com/>
[plex]: <https://www.plex.tv/>
[bittorrent]: <https://www.bittorrent.com/de/>
