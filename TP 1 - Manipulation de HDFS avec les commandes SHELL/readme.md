# Rapport de l'Exercice de Synthèse 21 : Maîtrise de HDFS

**Module :** Big Data - Atelier Hadoop HDFS  
**Objectif :** Vérifier la maîtrise des commandes essentielles de HDFS (création d'arborescence, manipulation de fichiers, analyse des blocs et gestion de la réplication).

---

## 1. Exécution des tâches (Pas à pas)

*Pré-requis : Toutes ces commandes sont exécutées à l'intérieur du conteneur NameNode (`docker compose exec namenode bash`).*

### Étape 1 & 2 : Création de l'arborescence HDFS
Création du dossier principal et des sous-dossiers `raw`, `archive` et `export`.
```bash
hdfs dfs -mkdir -p /exercice/raw /exercice/archive /exercice/export