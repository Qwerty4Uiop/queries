WITH fnl AS
     (SELECT employee_id, lower(substr(first_name, lvl, 1)) ch
        FROM employees CROSS JOIN
             (SELECT LEVEL lvl
                FROM dual
             CONNECT BY LEVEL<=
                     (SELECT MAX(LENGTH(first_name))
                        FROM employees))
       WHERE substr(first_name, lvl, 1) IS NOT NULL),
     snl AS
     (SELECT employee_id, lower(substr(last_name, lvl, 1)) ch
        FROM employees CROSS JOIN 
             (SELECT LEVEL lvl
                FROM dual
             CONNECT BY LEVEL<=
                     (SELECT MAX(LENGTH(last_name))
                        FROM employees))
       WHERE substr(last_name, lvl, 1) IS NOT NULL),
     let AS
     (SELECT DISTINCT fnl.employee_id, fnl.ch
        FROM fnl 
             INNER JOIN snl 
             ON fnl.employee_id = snl.employee_id 
                AND fnl.ch = snl.ch
       ORDER BY 1)
SELECT first_name "First_Name", last_name "Last_Name", listagg(ch, ', ') WITHIN GROUP(ORDER BY ch) "Letters", count(employee_id) "Count"
  FROM let 
       LEFT OUTER JOIN employees 
       USING(employee_id)
 GROUP BY first_name, last_name
HAVING count(employee_id) >= 3;