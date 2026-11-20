WITH RECURSIVE organigramme AS (
    SELECT id, nom, poste, 1 AS niveau, CAST(nom AS VARCHAR(255)) AS chemin
    FROM employes
    WHERE manager_id IS NULL

    UNION ALL

    SELECT employes.id, employes.nom, employes.poste, organigramme.niveau + 1, CAST(organigramme.chemin || ' > ' || employes.nom AS VARCHAR(255))
    FROM employes
    JOIN organigramme ON employes.manager_id = organigramme.id
    WHERE organigramme.niveau < 20
)
SELECT id, nom, poste, niveau, chemin
FROM organigramme
ORDER BY niveau ASC, id ASC;