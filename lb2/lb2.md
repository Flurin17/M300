# Leistungsbeurteilung 2 Modul 300
## _Flurin Laim_

## Erklärung
Mein Vagrant Setup baut 3 verschiedene Server auf.
| Server | Paket |
| ------ | ------ |
| Webserver | [Apache][webserver] |
| API | [Python][api] |
| Nginx | [Nginx][nginx] |


### Webserver
> Auf diesem Apache Server, läuft ein HTML File welches von mir erstellt wurde.
> Die Files werdem vom Host System übernommen.


### API Server
> Auf diesem Server läuft eine API welche auf Python basiert. Das Pythonskript habe ich selber geschrieben
> Zuerst müssen auf der VMs Updates installiert werden um danach PIP und die nötigen Pakete zu installieren.
> Als letzten Schritt wird das Skript in ein Service umgewandelt, damit die API auch ohnen manuellen Start und im Hintergrund laufen kann.


### Nginx
> Auf dem letzten Server läuft eine Instanz von Nginx. Dieser wird als reverse Proxy verwendet, um beide Services von einem zentralen Punkt aufrufen zu können.
> Dabei habe ich verschiedene Endpoints für die Services gesetzt.
> 
> 
| Service | Endpoint |
| ------ | ------ |
| API (python) | /api |
| Webserver (apache) | / |


## Set up
**Mein Vagrant File benötigt keine externen Änderungen**\
Heisst man muss die VMs nur mit Vagrant UP starten

Der reverse Proxy kann nach dem Start unter: **http://192.168.2.10/** erreicht werden

Die anderen zwei Services können notfalls unter **http://192.168.2.20** für den Webserver und **http://192.168.2.30/api/** für die API erreicht werden

## Testprotokoll
| Nötige Eingabe /Aktion | Erwartetes Ergebnis | Tatsächliches Ergebnis |
| ------ | ------ | ---- |
| Vagrant up| Alle drei VMs Starten nacheinander | Alle drei VMs Starten nacheinander |
| 192.168.2.10 im Browser eingeben| Es öffnet sich der nginx der direkt auf den Webserver weiterleitet |Es öffnet sich der nginx der direkt auf den Webserver weiterleitet |
| 192.168.2.10/api im Browser eingeben | Die API öffnet sich und gibt Hello World zurück | Die API öffnet sich und gibt Hello World zurück |

[webserver]: <https://www.apache.org/>
[api]: <https://github.com/Flurin17/API>
[nginx]: <https://www.nginx.com/>