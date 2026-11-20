WITH classement AS (
    SELECT cat.nom AS categorie,
           produits.nom AS produit,
           produits.prix_unitaire,
           DENSE_RANK() OVER (
               PARTITION BY produits.categorie_id
               ORDER BY produits.prix_unitaire DESC
           ) AS rang_prix
    FROM produits
    JOIN categories cat ON cat.id = produits.categorie_id
)-- si sa peux est retrecie en cat il est obligatoire de le fair :3
SELECT categorie, produit, prix_unitaire, rang_prix
FROM classement
WHERE rang_prix <= 2
ORDER BY categorie ASC, rang_prix ASC;