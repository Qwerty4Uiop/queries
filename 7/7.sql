DEFINE &&s
WITH dgts AS 
     (SELECT regexp_replace('&S', '[^[:digit:]]*') num
        FROM dual),
     t(A, c, d) AS
     (SELECT substr(num, 1, 1) A, substr(num, 2) c, substr(num, 1, 1) d
        FROM dgts
       UNION ALL
      SELECT substr(c, 1, 1),
             CASE
             WHEN c IS NULL THEN d
             ELSE substr(c, 2)
             END,
             CASE
             WHEN c IS NULL THEN '0'
             ELSE to_char(d + substr(c, 1, 1))
             END
        FROM t
       WHERE c IS NOT NULL 
          OR d > 10),
     res AS 
     (SELECT '&S' q, d
        FROM t
       WHERE c IS NULL 
         AND d <= 10
       UNION ALL
      SELECT '&S', '0'
        FROM dual)
SELECT q "Source string", MAX(d) "Result"
  FROM res
 GROUP BY q;
UNDEFINE s;