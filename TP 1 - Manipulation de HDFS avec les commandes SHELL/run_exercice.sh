#!/bin/bash
# =========================================================
# Script d'exécution - Exercice de synthèse 21 (HDFS)
# À exécuter dans le conteneur : docker compose exec namenode bash
# =========================================================

echo "🔹 Étape 1 & 2 : Création de l'arborescence HDFS"
hdfs dfs -mkdir -p /exercice/raw /exercice/archive /exercice/export

echo "🔹 Étape 3 : Création du fichier local clients.csv"
cat > /tmp/clients.csv << 'EOF'
id_client,nom,ville,pays
1,Ahmed,Casablanca,Maroc
2,Fatima,Rabat,Maroc
3,Youssef,Fes,Maroc
4,Sara,Marrakech,Maroc
EOF

echo "🔹 Étape 4 : Envoi du fichier vers HDFS (/exercice/raw)"
hdfs dfs -put -f /tmp/clients.csv /exercice/raw/

echo "🔹 Étape 5 : Lecture du fichier depuis HDFS"
hdfs dfs -cat /exercice/raw/clients.csv

echo "🔹 Étape 6 : Copie du fichier vers /exercice/archive"
hdfs dfs -cp /exercice/raw/clients.csv /exercice/archive/

echo "🔹 Étape 7 : Téléchargement du fichier vers le système local"
mkdir -p /tmp/export
hdfs dfs -get -f /exercice/raw/clients.csv /tmp/export/
echo "Fichier téléchargé localement dans /tmp/export/"

echo "🔹 Étape 8 : Affichage de la taille du fichier"
hdfs dfs -du -h /exercice/raw

echo "🔹 Étape 9 : Vérification des blocs et emplacements"
hdfs fsck /exercice/raw/clients.csv -files -blocks -locations

echo "🔹 Étape 10 : Modification du facteur de réplication à 3"
hdfs dfs -setrep -w 3 /exercice/raw/clients.csv

echo "✅ Exercice terminé. Vérification finale de l'arborescence :"
hdfs dfs -ls -R /exercice