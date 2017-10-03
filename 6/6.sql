WITH strn AS 
     (SELECT listagg(first_name) WITHIN GROUP(ORDER BY employee_id) n
        FROM employees),
     coln AS 
     (SELECT DISTINCT upper(regexp_substr(n, '.', 1, LEVEL)) c
        FROM strn
     CONNECT BY LEVEL <= LENGTH(n))
SELECT c, regexp_count(n, c, 1, 'i') cnt
  FROM coln
       LEFT OUTER JOIN strn 
       ON 1=1
 ORDER BY 1;