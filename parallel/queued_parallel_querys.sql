SELECT sql_id, sql_text 
FROM v$SQL_MONITOR
WHERE status='QUEUED';