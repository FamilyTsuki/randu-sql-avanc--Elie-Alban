-- p1
CREATE MATERIALIZED VIEW mv_synthese_segments AS
SELECT c.segment, COUNT(cmd.id) AS nb, ROUND(SUM(cmd.montant_total), 2) AS ca
FROM commandes cmd
JOIN clients c ON c.id = cmd.client_id
GROUP BY c.segment;

SELECT * FROM mv_synthese_segments;

-- p2
INSERT INTO commandes (client_id, date_commande, statut, montant_total)
VALUES (1, '2026-11-20', 'LIVREE', 5000.00);

SELECT * FROM mv_synthese_segments;

-- p3
REFRESH MATERIALIZED VIEW mv_synthese_segments;

SELECT * FROM mv_synthese_segments;