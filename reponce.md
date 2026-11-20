# P1

## 1.

### 1

_YEAR(date_commande) = 2026_
sa oblige un seq scan sur tout les ligne

### 2

absance d'indexation randu ancor plus lourd a cose de SELECT\*

## 2.

fichier [sql_1.sql](sqlFile/sql_1.sql)

Limit
Coût : 27.41..29.36
Lignes : 10
Temps : 3.41 ms
Buffers : 5 hit / 2 read
LIMIT 10
Sort
Coût : 27.41..29.36
Lignes : 39
Temps : 3.41 ms
Buffers : 5 hit / 2 read
Tri sur montant_total DESC
Partition Pruningsur commandes
Accès optimisé
Coût : 0..23.9
Lignes : 39
Temps : 2.96 ms
Buffers : 5 hit / 2 read
Partitions scannées : commandes_2026 (1/3)
Filtre : statut = LIVREE AND YEAR ( date_commande ) = 2026

Partition Pruningsur commandesvia idx_cmd_date
Accès optimisé
Coût : 0.15..9.27
Lignes : 39
Temps : 0.38 ms
Buffers : 4 hit / 0 read
Partitions scannées : commandes_2026 (1/3)
Filtre : statut = LIVREE AND date_commande >= 2026-01-01

Partition Pruning permet d'exclure les pzrtition 2024 et 2025 sans il lirais les 3 sa fais donc gager 2/3 de temp

## 3.

fichier [sql_2.sql](sqlFile/sql_2.sql)

# P2

## 4.

1FN: Atomisation de projets_liste -> clé composite (employe_id, projet_id).
2FN: Suppression des dépendances partielles -> isolation de employes et projets.
3FN: Suppression des dépendances transitives -> isolation de departements et chefs_projet.

#### Tables 3FN finales :

1. departements (id PK, nom)
2. employes (id PK, nom, dept_id FK)
3. chefs_projet (id PK, nom, tel)
4. projets (id PK, nom, chef_id FK)
5. affectations (employe_id PK FK, projet_id PK FK)

## 5.

fichier [sql_3.sql](sqlFile/sql_3.sql)

## 6.

fichier [sql_4.sql](sqlFile/sql_4.sql)

# C

## 7.

si manager_id == NULL sa ranvera UNKNOWN

fichier [sql_5.sql](sqlFile/sql_5.sql)

## 8.

1. T1 lit solde = 1 000 €
2. T2 fait un virement de 200 € et commit (`UPDATE ...; COMMIT;`)
3. T1 relit solde = 800 €

problem : deux lectures identiques dans la même transaction donnent deux résultats différents car READ COMMITTED prend un snapshot frais à chaque instruction

solution : Snapshot MVCC unique figé dès la 1er lecture de T1 T1 continue de lire 1 000 €

WAL:

1. Rejoue les transactions validées et enregistrées dans les log
2. Annule les transactions interrompues pour éviter les états financiers partiels
