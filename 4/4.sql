SELECT emp1.employee_id,
       to_char(emp1.hire_date, 'YYYY') year,
       emp1.first_name,
       emp1.last_name,
       emp1.salary,
       1 + count(DISTINCT emp2.employee_id) pos
  FROM employees emp1 
       LEFT OUTER JOIN employees emp2 
       ON to_char(emp1.hire_date, 'YYYY') = to_char(emp2.hire_date, 'YYYY')
          AND (emp1.salary < emp2.salary 
           OR emp1.salary = emp2.salary
          AND emp1.employee_id > emp2.employee_id)
 GROUP BY emp1.employee_id, to_char(emp1.hire_date, 'YYYY'), emp1.first_name, emp1.last_name, emp1.salary
 ORDER BY year, pos, emp1.employee_id