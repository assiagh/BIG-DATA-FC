# TP6 — Apache Airflow : Orchestration de Pipelines Big Data

**Réalisé par :** AIT-HSSAIN Fatima Ez-Zahraa
**Encadré par :** Abdelmajid BOUSSELHAM | **Université :** ENSET Mohammedia
**Filière :** II-BDDC | **Module :** Big Data | **Année :** 2026

---

## Description

Atelier d'orchestration de pipelines avec **Apache Airflow** via **Docker Compose**. Airflow définit, planifie et surveille des workflows (DAGs) sans remplacer les outils de traitement (Spark, Hadoop).

## Architecture

```
TP6_Big Data Apache Airflow/
├── dags/ (4 DAGs Python)
├── data/ (fichiers CSV/JSON manipulés)
├── logs/
└── docker-compose.yml
```

## Lancement

```bash
docker compose up -d
docker ps
# → http://localhost:8080 (airflow / airflow)
```

## DAGs réalisés

| DAG | Description |
|---|---|
| `mon_premier_dag` | 3 tâches séquentielles (debut → traitement → fin) |
| `pipeline_big_data_python` | Pipeline complet en 7 étapes : ingestion → stockage → validation → transformation → analyse → chargement → rapport |
| `pipeline_big_data_parallele` | Préparation → validation → **parallèle** (par ville / par produit) → rapport final |
| `pipeline_inscription_etudiants` | Mini-projet : réception → stockage → validation → nettoyage → **parallèle** (groupes / stats) → rapport |

**Résultat `pipeline_big_data_python` (CA par ville) :**

```json
{"Casablanca": 23500.0, "Rabat": 6100.0, "Marrakech": 1500.0, "Tanger": 8500.0}
```

## Concepts clés testés

- **Logs** : consultables via DAG → run → tâche → onglet Logs
- **Planification** : `schedule="@daily"` pour exécution automatique quotidienne
- **Gestion d'erreurs** : `raise Exception(...)` → tâche rouge, tâches suivantes bloquées (upstream_failed)
- **Retries** : `default_args={"retries": 2, "retry_delay": timedelta(minutes=1)}`
- **Parallélisme** : syntaxe `[tache_A, tache_B]` — deux tâches indépendantes exécutées simultanément

## Réponses synthétiques

- Une tâche échouée bloque toutes les tâches en aval qui en dépendent.
- Le parallélisme apparaît dans la vue Graph comme deux flèches divergentes puis convergentes.
- Les retries permettent de gérer les échecs temporaires (réseau, fichier manquant) sans intervention manuelle.

## Conclusion

L'atelier a permis de maîtriser Airflow comme outil d'orchestration : déploiement Docker, création de DAGs séquentiels et parallèles avec PythonOperator, gestion des erreurs et des retries, et planification automatique via `schedule`.

---

> **Technologies :** Apache Airflow 2.8.1 · Python 3.8 · Docker · PostgreSQL 13 · Docker Compose