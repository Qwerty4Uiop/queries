WITH tot AS
     (SELECT e1.employee_id, e1.department_id, e1.first_name, e1.last_name, e1.hire_date, e1.salary, sum(e2.salary) s1
        FROM employees e1 
             INNER JOIN employees e2 
             ON e1.department_id = e2.department_id
                AND (e2.hire_date < e1.hire_date 
                 OR e2.hire_date = e1.hire_date 
                AND e2.employee_id <= e1.employee_id)
       GROUP BY e1.employee_id, e1.department_id, e1.first_name, e1.last_name, e1.hire_date, e1.salary
       ORDER BY 2, 5, 1),
     rn AS
     (SELECT employee_id, ROWNUM rn
        FROM tot),
     tot2 AS
     (SELECT employee_id, department_id, first_name, last_name, hire_date, salary, s1, rn
        FROM tot 
             INNER JOIN rn 
             USING(employee_id))
SELECT tot2.employee_id, tot2.department_id, tot2.first_name, tot2.last_name, tot2.hire_date, tot2.salary, tot2.s1, sum(tot3.salary) s2
  FROM tot2 
       INNER JOIN tot2 tot3 
       ON tot3.rn <= tot2.rn
 GROUP BY tot2.employee_id, tot2.department_id, tot2.first_name, tot2.last_name, tot2.hire_date, tot2.salary, tot2.s1
 ORDER BY 2, 5, 1;