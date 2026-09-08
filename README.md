# Big Data — Travaux Pratiques

**Réalisé par :** AIT-HSSAIN Fatima Ez-Zahraa
**Encadré par :** Pr. Abdelmajid BOUSSELHAM
**Université :** ENSET Mohammedia | **Filière :** MII-BDCC | **Année :** 2025–2026

---

## Présentation

Ce dépôt regroupe les travaux pratiques du module **Big Data**, de l'analyse SQL sur Spark jusqu'à l'orchestration de pipelines avec Apache Airflow.

## Structure

```
BIG-DATA-BOUSELHAM-MII-BDCC/
├── TP 3 - SPARK SQL/
├── TP 4 - Spark Structured Streaming + HDFS/
├── TP 5 - Kafka Streams/
└── TP 6 - Apache Airflow/
```

## Résumé des TP

| TP | Technologies | Objectif | Résultat clé |
|---|---|---|---|
| **TP3** | Spark SQL, Java 17, Docker | Analyse de 5 000 locations de vélos | Revenu total : 41 755.7 MAD, station la plus active : Hôpital (447) |
| **TP4** | PySpark Structured Streaming, HDFS, YARN | Analyse quasi temps réel de capteurs | 2 alertes détectées (40.7°C, 45.3°C) sur seuil 35°C |
| **TP5** | Kafka Streams, Spring Boot, Prometheus | 3 exercices : nettoyage texte, météo, compteur de clics | station1 : 99.5°F/75%, station2 : 93.2°F/62.5% |
| **TP6** | Apache Airflow, Docker Compose | Orchestration de pipelines Big Data via DAGs | 4 DAGs fonctionnels, séquentiels et parallèles |

## Infrastructure type

| Composant | Rôle |
|---|---|
| Docker / Docker Compose | Déploiement de l'infrastructure (TP3–6) |
| Spark / PySpark | Traitement batch et streaming |
| Hadoop HDFS / YARN | Stockage et gestion des ressources |
| Kafka / Kafka Streams | Messagerie et traitement de flux |
| Airflow | Orchestration de workflows |