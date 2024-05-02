CREATE OR REPLACE VIEW ALL_WORKERS AS
SELECT 
    last_name,
    first_name,
    age,
    first_day AS start_date
FROM 
    WORKERS_FACTORY_1
WHERE 
    last_day IS NULL

UNION

SELECT 
    last_name,
    first_name,
    null,
    start_date AS start_date
FROM 
    WORKERS_FACTORY_2
WHERE 
    end_date IS NULL

ORDER BY start_date DESC;


CREATE OR REPLACE VIEW ALL_WORKERS_ELAPSED AS
SELECT
    last_name,
    first_name,
    age,
    start_date,
    TRUNC(SYSDATE - start_date) AS days_elapsed
FROM
    ALL_WORKERS;
    
CREATE OR REPLACE VIEW BEST_SUPPLIERS AS
SELECT
    SUPPLIERS.name AS supplier_name,
    SUM(SUPPLIERS_BRING_TO_FACTORY_1.quantity) AS total_de_pieces
FROM
    SUPPLIERS
JOIN
    SUPPLIERS_BRING_TO_FACTORY_1 ON SUPPLIERS.supplier_id = SUPPLIERS_BRING_TO_FACTORY_1.supplier_id
GROUP BY
    SUPPLIERS.name
HAVING
    SUM(SUPPLIERS_BRING_TO_FACTORY_1.quantity) > 1000
ORDER BY
    total_de_pieces DESC;
    

CREATE VIEW ROBOTS_FACTORIES AS
SELECT
    R.id AS robot_id,
    R.model AS robot_model,
    F.main_location AS factory_location
FROM
    ROBOTS R
JOIN
    ROBOTS_FROM_FACTORY RF ON R.id = RF.robot_id
JOIN
    FACTORIES F ON RF.factory_id = F.id;