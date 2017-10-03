DEFINE &&a;
WITH nums(n) AS 
     (SELECT 0 n
        FROM dual
       UNION ALL
      SELECT n + 1
        FROM nums
       WHERE n < 6),
     dice AS
     (SELECT d1.n || d2.n d, d2.n || d1.n i, ROWNUM rn
        FROM nums d1 
             LEFT OUTER JOIN nums d2 
             ON d1.n <= d2.n),
     sepnum AS 
     (SELECT substr(REPLACE('&A', ' '), LEVEL * 2 - 1, 2) n
        FROM dual
     CONNECT BY LEVEL <= round(LENGTH(REPLACE('&A', ' ')) / 2))
SELECT '&A' Bones, 
       CASE
       WHEN count(DISTINCT rn) = count(*) 
         OR REPLACE('&A', ' ') IS NULL THEN 'TRUE'
       ELSE 'FALSE'
        END "Answer"
  FROM sepnum n 
       LEFT OUTER JOIN dice d 
       ON n = d 
       OR n = i;
UNDEFINE A;