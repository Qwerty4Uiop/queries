 SELECT department_id, nvl(ltrim(MAX(sys_connect_by_path(last_name,', ')) KEEP (DENSE_RANK LAST ORDER BY curr),', '), ' ') AS employees
   FROM (SELECT department_id,
               last_name,
               row_number() OVER (PARTITION BY department_id ORDER BY last_name) curr,
               row_number() OVER (PARTITION BY department_id ORDER BY last_name) - 1 prev
          FROM departments 
               LEFT OUTER JOIN employees 
               USING(department_id))
  START WITH curr = 1
CONNECT BY prev = PRIOR curr 
    AND department_id = PRIOR department_id
  GROUP BY department_id;