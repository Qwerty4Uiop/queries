WITH cases AS 
     (SELECT '0-0' A FROM dual
       UNION ALL
      SELECT '0-1' FROM dual
       UNION ALL
      SELECT '0-2' FROM dual
       UNION ALL
      SELECT '0-3' FROM dual
       UNION ALL
      SELECT '0-4' FROM dual
       UNION ALL
      SELECT '0-5' FROM dual
       UNION ALL
      SELECT '1-0' FROM dual
       UNION ALL
      SELECT '1-1' FROM dual
       UNION ALL
      SELECT '1-2' FROM dual
       UNION ALL
      SELECT '1-3' FROM dual
       UNION ALL
      SELECT '1-4' FROM dual
       UNION ALL
      SELECT '1-5' FROM dual
       UNION ALL
      SELECT '2-0' FROM dual
       UNION ALL
      SELECT '2-1' FROM dual
       UNION ALL
      SELECT '2-2' FROM dual
       UNION ALL
      SELECT '2-3' FROM dual
       UNION ALL
      SELECT '2-4' FROM dual
       UNION ALL
      SELECT '2-5' FROM dual
       UNION ALL
      SELECT '3-0' FROM dual
       UNION ALL
      SELECT '3-1' FROM dual
       UNION ALL
      SELECT '3-2' FROM dual
       UNION ALL
      SELECT '3-3' FROM dual
       UNION ALL
      SELECT '3-4' FROM dual
       UNION ALL
      SELECT '3-5' FROM dual),
     s AS 
     (SELECT sys_connect_by_path(A, ', ') b
        FROM cases
       START WITH A = '0-0'
     CONNECT BY NOCYCLE 
             (substr(A, 1, 1) = '3' AND substr(A, 3, 1) = substr(PRIOR A, 3, 1))
          OR (substr(A, 1, 1) = '0' AND substr(A, 3, 1) = substr(PRIOR A, 3, 1))
          OR (substr(A, 1, 1) = '3' AND substr(PRIOR A, 3, 1) >= 3 - substr(PRIOR A, 1, 1) AND substr(A, 3, 1) = substr(PRIOR A, 3, 1) - 3 + substr(PRIOR A, 1, 1))
          OR (substr(A, 1, 1) = substr(PRIOR A, 1, 1) AND substr(A, 3, 1) = '5')
          OR (substr(A, 1, 1) = substr(PRIOR A, 1, 1) AND substr(A, 3, 1) = '0')
          OR (substr(A, 3, 1) = '5' AND substr(PRIOR A, 1, 1) >= 5 - substr(PRIOR A, 3, 1) AND substr(A, 1, 1) = substr(PRIOR A, 1, 1) - 5 + substr(PRIOR A, 3, 1))
          OR (substr(A, 1, 1) = '0' AND substr(PRIOR A, 3, 1) + substr(PRIOR A, 1, 1) <= 5 AND substr(A, 3, 1) = substr(PRIOR A, 3, 1) + substr(PRIOR A, 1, 1))
          OR (substr(A, 3, 1) = '0' AND substr(PRIOR A, 3, 1) + substr(PRIOR A, 1, 1) <= 3 AND substr(A, 1, 1) = substr(PRIOR A, 3, 1) + substr(PRIOR A, 1, 1)))
SELECT substr(b, 3) path
  FROM s
 WHERE REGEXP_LIKE(b, '^[^4]*4$')