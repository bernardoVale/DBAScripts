----- get the execution_name for the long run day 

set lines 200 pages 100 
col error_message for a60 
col execution_name for a15 
select execution_name, advisor_name,to_char(execution_start,'dd-mon-yy hh:mi:ss'), to_char(execution_end,'dd-mon-yy hh:mi:ss'), status,error_message 
from dba_advisor_executions 
where task_name = 'SYS_AUTO_SQL_TUNING_TASK' 
order by execution_start; 

----- supply the execution name in the below query 
----- below query will identify if any particular SQL had overran and caused hung 

SELECT sql_id, sql_text FROM dba_hist_sqltext 
WHERE sql_id IN (SELECT attr1 FROM dba_advisor_objects 
WHERE execution_name = '&execution_name' 
AND task_name = 'SYS_AUTO_SQL_TUNING_TASK' 
AND type = 'SQL' AND bitand(attr7,64) <> 0 ); 

----> from the output above find the sql with the attr value 64 and that is the sql causing the issue. 
---> Then use the step below to tune them manually. SELECT sql_id, sql_text FROM dba_hist_sqltext 
WHERE sql_id IN (SELECT attr1 FROM dba_advisor_objects 
WHERE execution_name = '&execution_name' 
AND task_name = 'SYS_AUTO_SQL_TUNING_TASK' 
AND type = 'SQL' AND bitand(attr7,64) <> 0 ); 