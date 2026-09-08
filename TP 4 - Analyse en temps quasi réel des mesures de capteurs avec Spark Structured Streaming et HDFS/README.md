# TP4 — PySpark Structured Streaming : Capteurs sur HDFS

**Réalisé par :** AIT-HSSAIN Fatima Ez-Zahraa
**Encadré par :** Abdelmajid BOUSSELHAM | **Université :** ENSET Mohammedia
**Filière :** II-BDDC | **Année :** 2026

---

## Objectifs

Pipeline de traitement en temps quasi réel avec **PySpark Structured Streaming**, lecture de fichiers CSV depuis **HDFS**, calcul de statistiques par capteur, détection d'anomalies, checkpoints pour tolérance aux pannes.

## Architecture

```
[CSV locaux] → docker cp → [Namenode] → hdfs dfs -put → [/streaming/capteurs/]
                                              │
                                    [PySpark Structured Streaming]
                                       │                    │
                                 [Stats/capteur]      [Alertes valeur>35]
```

**Infra Docker :** 1 namenode, 5 datanodes, resourcemanager, nodemanager, spark-master, 2 spark-workers.

## Données

```
id,timestamp,capteur,valeur,unite
1,2026-03-30 09:00:00,CAPTEUR_TEMP_1,22.5,C
```

## Étapes principales

1. `docker-compose up -d` — démarrage infra
2. Vérification Spark UI (8081), HDFS NameNode (9870), YARN (8088)
3. Création répertoires HDFS (`/streaming/capteurs`, `/streaming/checkpoints/...`)
4. Lancement app : `spark-submit --master spark://spark-master:7077 /app/app.py`
5. Injection CSV : `docker cp` + `hdfs dfs -put`
6. Vérification checkpoints (`commits`, `metadata`, `offsets`, `sources`)

## Code clé

```python
df_stream = spark.readStream.option("maxFilesPerTrigger", 1).schema(schema_capteurs).csv(source_path)

stats_capteurs = df_stream.groupBy("capteur").agg(avg("valeur"), min("valeur"), max("valeur"), count("*"))
alertes = df_stream.filter(col("valeur") > 35.0)
```

## Résultats

| Capteur | Moyenne | Min | Max | Mesures |
|---|---|---|---|---|
| CAPTEUR_TEMP_1 | 26.74°C | 21.9°C | 40.7°C | 5 |
| CAPTEUR_TEMP_2 | 30.85°C | 24.1°C | 45.3°C | 4 |
| CAPTEUR_HUM_1 | 65.33% | 60.3% | 70.6% | 3 |

2 alertes déclenchées : id=8 (40.7°C), id=12 (45.3°C).

## Difficultés rencontrées

| Problème | Cause | Solution |
|---|---|---|
| `FileNotFoundException` | URI sans préfixe HDFS | Utiliser `hdfs://namenode:8020/...` |
| `Incomplete HDFS URI` | Triple slash sans hostname | Préciser `namenode:8020` |
| `AccessControlException` | Permissions user `hadoop` vs `spark` | `hdfs dfs -chmod 777` sur les checkpoints |

## Questions clés (résumé)

- **Schéma explicite** : obligatoire en streaming car Spark ne peut pas inférer depuis des fichiers qui n'existent pas encore.
- **Checkpoint** : sauvegarde l'état (offsets, commits) pour permettre une reprise exactly-once après panne.
- **complete vs append** : `complete` réécrit tout le résultat (agrégations), `append` n'émet que les nouvelles lignes (alertes).
- **maxFilesPerTrigger** : simule une arrivée progressive des données au lieu d'un traitement batch unique.
- **Kafka vs HDFS** : Kafka préférable pour faible latence, producteurs multiples, flux continu et rejouable.

## Conclusion

Le pipeline complet (infra → ingestion → calcul → alertes → checkpoints) a été validé de bout en bout. Les principales difficultés concernaient la configuration réseau HDFS et les permissions, plus que le code Spark lui-même.