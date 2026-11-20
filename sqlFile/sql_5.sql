sql

SELECT employes.id, employes.nom
FROM employes
WHERE NOT EXISTS (
    SELECT 1
    FROM employes sub
    WHERE sub.manager_id = employes.id
);