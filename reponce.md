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

 