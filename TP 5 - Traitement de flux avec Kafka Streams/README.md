# TP5 — Traitement de Flux avec Kafka Streams

**Réalisé par :** AIT-HSSAIN Fatima Ez-Zahraa
**Encadré par :** Abdelmajid BOUSSELHAM | **Université :** ENSET Mohammedia | **Module :** Big Data

---

## Infrastructure

| Composant | Image | Port |
|---|---|---|
| Zookeeper | confluentinc/cp-zookeeper:7.5.0 | 2181 |
| Kafka Broker | apache/kafka:latest | 9092 |

```bash
docker-compose up -d
```

---

## Exercice 1 — Text Cleaner

Nettoyage de texte (trim, majuscules) + filtrage (longueur ≤100, mots interdits `HACK`/`SPAM`/`XXX`).

```
text-input → mapValues(clean) → filter(isValid) → text-clean (valide) / text-dead-letter (invalide)
```

**Résultat :** `"hello world"` → `HELLO WORLD` ✅, `"this is spam message"` → rejeté ❌, `"kafka streams"` → `KAFKA STREAMS` ✅

---

## Exercice 2 — Weather Analyzer

Filtrage temp > 30°C, conversion °C→°F, agrégation par station, métriques **Prometheus** (port 1234).

```
weather-data → parse → filter(temp>30) → convert(F) → groupByKey → aggregate → station-averages
```

| Station | Moy. Temp | Moy. Humidité |
|---|---|---|
| station1 | 99.5°F | 75.0% |
| station2 | 93.2°F | 62.5% |

---

## Exercice 3 — Click Stream Analytics

Architecture 3 apps Spring Boot :

```
Navigateur → Producer(:8082) → topic clicks → Streams App (groupByKey.count()) 
→ topic click-counts → Consumer(:8083) → GET /clicks/count
```

| App | Port | Rôle |
|---|---|---|
| ClickProducerApp | 8082 | Interface web, envoie clics vers `clicks` |
| ClickStreamsApp | — | Compte les clics via state store RocksDB |
| ClickConsumerApp | 8083 | `@KafkaListener`, expose `GET /clicks/count` |

**Résultat final :** `{"totalClicks": 44}`

---

## Technologies

| Techno | Version |
|---|---|
| Apache Kafka / Kafka Streams | 3.9.1 |
| Spring Boot | 3.2.5 |
| Prometheus Java Client | 0.16.0 |
| Java | 17 |

## Structure

```
TP5_kafka-streams/
├── docker-compose.yml
├── screenshots/
└── src/main/java/ma/rafik/
    ├── exercice1/TextCleanerApp.java
    ├── exercice2/WeatherAnalyzerApp.java
    └── exercice3/ (producer, streams, consumer)
```