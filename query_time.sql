-- Order queries by how many cpu seconds they consume
SELECT   hash_value, executions, ROUND (elapsed_time / 1000000, 2) total_time,
         ROUND (cpu_time / 1000000, 2) cpu_seconds
    FROM (SELECT   *
              FROM v$sql
          ORDER BY elapsed_time DESC)
    where rownum <= 10
ORDER BY cpu_seconds DESC;


1
-- Find the total cpu seconds consumed
SELECT SUM (cpu_seconds)
  FROM (SELECT   hash_value, executions,
                 ROUND (elapsed_time / 1000000, 2) total_time,
                 ROUND (cpu_time / 1000000, 2) cpu_seconds
            FROM (SELECT   *
                      FROM v$sql
                  ORDER BY elapsed_time DESC)
        ORDER BY cpu_seconds DESC)
  where rownum <= 10;


-- Find the total time queries have taken
SELECT SUM (total_time)
  FROM (SELECT   hash_value, executions,
                 ROUND (elapsed_time / 1000000, 2) total_time,
                 ROUND (cpu_time / 1000000, 2) cpu_seconds
            FROM (SELECT   *
                      FROM v$sql
                  ORDER BY elapsed_time DESC)
        ORDER BY cpu_seconds DESC);

-- Find execution plan for the damned query you should fix
SELECT *
  FROM v$sql_plan
 WHERE hash_value = 2967942512;