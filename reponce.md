# P1

## 1.

### 1

_YEAR(date_commande) = 2026_
sa oblige un seq scan sur tout les ligne

### 2

absance d'indexation randu ancor plus lourd a cose de SELECT\*

## 2.

fichier sql 1

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

fichier sql_2

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

fichier sql_3
