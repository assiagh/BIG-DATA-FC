# TP3 — Spark SQL : Analyse de locations de vélos

**Réalisé par :** AIT-HSSAIN Fatima Ez-Zahraa
**Module :** Big Data — MII BDCC | **École :** ENSET | **Encadrant :** Pr. Bouselham

---

## Description

Analyse d'un dataset de **5 000 locations de vélos** via **Spark SQL** : chargement CSV, vues temporaires, requêtes d'agrégation, analyse temporelle et comportementale.

## Stack

| Composant | Version |
|---|---|
| Apache Spark | 4.1.1 |
| Java | 17 |
| Maven | 3.x |
| Docker | — |

## Dataset

10 colonnes : `rental_id`, `user_id`, `age`, `gender`, `start_time`, `end_time`, `start_station`, `end_station`, `duration_minutes`, `price`.

## Lancement

```bash
mvn clean package
docker-compose up -d
docker exec spark-master /opt/spark/bin/spark-submit \
  --master spark://spark-master:7077 \
  /opt/spark-apps/target/spark-sql-app.jar
```

## Analyses & résultats clés

```sql
SELECT sum(price) AS total_revenue FROM bike_rentals_view;
SELECT start_station, count(*) FROM bike_rentals_view GROUP BY start_station ORDER BY count(*) DESC LIMIT 1;
SELECT hour(start_time), count(*) FROM bike_rentals_view GROUP BY hour(start_time);
```

| Indicateur | Valeur |
|---|---|
| Total locations | 5 000 |
| Revenu total | 41 755.7 MAD |
| Station la plus active | Hôpital (447) |
| Station matin la plus active | Technopark (207) |
| Heure de pointe | 19h (507 locations) |
| Âge moyen | 41.5 ans |
| Répartition genre | M: 2 542, F: 2 286, Autre: 172 |
| Tranche d'âge dominante | 51+ (1 567) |