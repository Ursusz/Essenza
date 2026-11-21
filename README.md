# Essenza

Aplicație web (PWA) pentru parfumuri: scanare vizuală, fișa parfumului cu scorul comunității,
ghid anti-contrafacere, garderobă și gamification. Echipa 5, IP 2026.

## Structura

```
essenza/
├── api/              Spring Boot (Java 21) — monolit modular
│   └── src/main/java/ro/unibuc/essenza/
│       ├── catalog/        brand, parfum, note, căutare
│       ├── scan/           scanări, callback-ul intern, decizia de recunoaștere
│       ├── review/         recenzii și scoruri agregate
│       ├── article/        articolele influencerilor
│       ├── wardrobe/       garderoba personală
│       ├── authenticity/   liste de verificare, verificări, rapoarte
│       ├── gamification/   XP, niveluri, insigne, clasamente, misiuni, influenceri
│       ├── auth/           conturi, JWT, securitate
│       └── common/         configurare, erori, utilitare
│       (fiecare modul: controller / service / repository / domain / dto)
│   └── src/main/resources/db/migration/   migrări Flyway
├── web/              React + TypeScript (Vite), PWA; nginx (HTTPS 8443) în container
├── scan-processor/   funcția Lambda (Python, PyTorch, OpenCV): calitate + embedding
├── ingest/           job de ingestie a catalogului (Python)
├── infra/
│   ├── init/         init-aws.sh: bucket S3, funcția Lambda, notificarea S3 (Floci)
│   └── certs/        certificatele mkcert (ignorate de git)
├── docs/             rapoartele de analiză și proiectare
└── docker-compose.yml
```

## Pornire (PoC local)

1. `cp .env.example .env` și completează valorile.
2. Certificat HTTPS (necesar pentru cameră pe telefon):
   `mkcert -cert-file infra/certs/essenza.pem -key-file infra/certs/essenza-key.pem <IP-laptop> localhost`
3. `docker compose --profile build build scan-processor`
4. `docker compose up -d`
5. Ingestie catalog (la cerere): `docker compose --profile tools run --rm ingest`

Aplicația: `https://<IP-laptop>:8443`.

## Dezvoltare locală

- API: `cd api && mvn spring-boot:run`
- Web: `cd web && npm install && npm run dev`
- Python: `pip install -r requirements.txt -r requirements-dev.txt && pytest`
