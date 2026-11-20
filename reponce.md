# Parti 1

## 1.

### 1

_YEAR(date_commande) = 2026_
sa oblige un seq scan sur tout les ligne

### 2

absance d'indexation randu ancor plus lourd a cose de SELECT\*

## 2.

fichier [sql_1.sql](sqlFile/sql_1.sql)

Limit
Coût : 31.03..33.28
Lignes : 10
Temps : 3.76 ms
Buffers : 6 hit / 2 read
LIMIT 10
Sort
Coût : 31.03..33.28
Lignes : 45
Temps : 3.76 ms
Buffers : 6 hit / 2 read
Tri sur montant_total DESC
Partition Pruningsur commandes
Accès optimisé
Coût : 0..26.98
Lignes : 45
Temps : 3.31 ms
Buffers : 6 hit / 2 read
Partitions scannées : commandes_2026 (1/3)
Filtre : statut = LIVREE AND YEAR ( date_commande ) = 2026

Partition Pruningsur commandesvia idx_cmd_date
Accès optimisé
Coût : 0.15..9.53
Lignes : 45
Temps : 0.38 ms
Buffers : 4 hit / 0 read
Partitions scannées : commandes_2026 (1/3)
Filtre : statut = LIVREE AND date_commande >= 2026-01-01

Partition Pruning permet d'exclure les pzrtition 2024 et 2025 sans il lirais les 3 sa fais donc gagner 2/3 de temp

## 3.

fichier [sql_2.sql](sqlFile/sql_2.sql)

# P2

## 4.

Dépendances fonctionnelles :

- employe_id -> employe_nom, dept_nom
- projet_id -> chef_projet, chef_projet_tel
- chef_projet -> chef_projet_tel
- (employe_id, projet_id) -> affectation

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

Piège de la logique ternaire SQL :
`id NOT IN (..., NULL)` équivaut à `id != ... AND id != NULL`.
Or `id != NULL` s'évalue à `UNKNOWN`.
Comme `TRUE AND UNKNOWN` donne `UNKNOWN` et que la clause WHERE exige strictement `TRUE`, 0 ligne n'est retournée.

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

## 9.

### (a) GPS 30 000 véhicules / 3s

- Cassandra (Colonnes larges) - AP / PA/EL
- 10 000 écritures/s en append-only (LSM-Tree). Disponibilité et vitesse prioritaires sur la cohérence immédiate.

### (b) Facturation bancaire

- PostgreSQL (Relationnel) - CP / PC/EC
- Transactions ACID strictes, zéro erreur tolérée sur l'argent, modèle 3FN normalisé.

### (c) Amis et trajets (3 sauts)

- Neo4j (Graphe) - Index-Free Adjacency
- Traversée directe des liens en mémoire en O(k^3) au lieu de 3 jointures SQL lourdes.
