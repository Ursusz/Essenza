# Essenza

Aplicatie web (PWA) pentru parfumuri: scanare vizuala, fisa parfumului cu scorul comunitatii,
ghid anti-contrafacere, garderoba si gamification. Echipa 5, IP 2026.

## Structura

```
essenza/
├── api/              Spring Boot (Java 21) — monolit modular
│   └── src/main/java/ro/unibuc/essenza/
│       ├── catalog/        brand, parfum, note, cautare
│       ├── scan/           scanari, callback-ul intern, decizia de recunoastere
│       ├── review/         recenzii si scoruri agregate
│       ├── article/        articolele influencerilor
│       ├── wardrobe/       garderoba personala
│       ├── authenticity/   liste de verificare, verificari, rapoarte
│       ├── gamification/   XP, niveluri, insigne, clasamente, misiuni, influenceri
│       ├── auth/           conturi, JWT, securitate
│       └── common/         configurare, erori, utilitare
│       (fiecare modul: controller / service / repository / domain / dto)
│   └── src/main/resources/db/migration/   migrari Flyway
├── web/              React + TypeScript (Vite), PWA; nginx (HTTPS 8443) in container
├── scan-processor/   functia Lambda (Python, PyTorch, OpenCV): calitate + embedding
├── ingest/           job de ingestie a catalogului (Python)
├── infra/
│   ├── init/         init-aws.sh: bucket S3, functia Lambda, notificarea S3 (Floci)
│   └── certs/        certificatele mkcert (ignorate de git)
├── docs/             rapoartele de analiza si proiectare
└── docker-compose.yml
```

## Pornire (PoC local)

1. `cp .env.example .env` si completeaza valorile.
2. Certificat HTTPS (necesar pentru camera pe telefon):
   `mkcert -cert-file infra/certs/essenza.pem -key-file infra/certs/essenza-key.pem <IP-laptop> localhost`
3. `docker compose --profile build build scan-processor`
4. `docker compose up -d`
5. Ingestie catalog (la cerere): `docker compose --profile tools run --rm ingest`

Aplicatia: `https://<IP>:8443`.

## Dezvoltare locala

- API: `cd api && mvn spring-boot:run`
- Web: `cd web && npm install && npm run dev`
- Python: `pip install -r requirements.txt -r requirements-dev.txt && pytest`
