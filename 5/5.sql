SELECT regexp_substr(first_name, '([a-zA-Z])\1', 1, 1, 'i', 1) "Letter",
       listagg(employee_id || ' ' || first_name || ' ' || last_name, ', ') WITHIN GROUP (ORDER BY employee_id) "Employees"
  FROM employees
 WHERE REGEXP_LIKE(first_name, '([a-zA-Z])\1', 'i')
 GROUP BY regexp_substr(first_name, '([a-zA-Z])\1', 1, 1, 'i', 1);