WITH SUMMARY AS 
     (SELECT sum(salary) sum
        FROM employees
       WHERE department_id IS NOT NULL),
     sals AS 
     (SELECT department_name, last_name, sum(salary) sal
        FROM departments 
             INNER JOIN employees 
             USING(department_id)
       GROUP BY ROLLUP(department_name, last_name)),
     parts AS
     (SELECT nvl(department_name, 'TOTAL') department_name, last_name, trunc(sal / sum * 100, 2) pt
        FROM sals 
             JOIN SUMMARY 
             ON 1=1
       ORDER BY 1, 2),
     deps AS 
     (SELECT department_name, sum(pt) pt1
        FROM parts
       WHERE last_name IS NOT NULL
       GROUP BY (department_name)
       UNION ALL
      SELECT 'TOTAL', sum(pt) - 100
        FROM parts
       WHERE last_name IS NULL),
     lemp AS 
     (SELECT department_name, MAX(last_name) nm
        FROM parts
       GROUP BY department_name),
     diffs AS
     (SELECT department_name, pt - pt1 dif
        FROM parts 
             INNER JOIN deps 
             USING (department_name)
       WHERE last_name IS NULL),
     ldep AS 
     (SELECT MAX(department_name) m
        FROM deps
       WHERE department_name != 'TOTAL')
SELECT department_name, last_name, 
       CASE
       WHEN department_name != m 
        AND last_name = nm THEN pt + diffs.dif
       WHEN department_name = m 
        AND last_name IS NULL THEN pt + d.dif
       WHEN department_name = m 
        AND last_name = nm THEN pt + diffs.dif + d.dif
       ELSE pt
        END percentage
  FROM parts
       LEFT OUTER JOIN diffs 
       USING(department_name)
       LEFT OUTER JOIN lemp 
       USING(department_name)
       LEFT OUTER JOIN (SELECT dif 
                          FROM diffs 
                         WHERE department_name = 'TOTAL') d 
       ON 1=1 
       LEFT OUTER JOIN ldep
       ON 1=1
 ORDER BY 1, 2 NULLS FIRST;