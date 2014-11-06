-- Insira o DDL dentro do loop e o select no cursor.
BEGIN        
  FOR r IN (select
    s.SEGMENT_NAME, 
    s.BYTES/1024/1024/1024,
    t.owner,
    t.table_name
from dba_segments s inner join dba_tables t on (s.SEGMENT_NAME = t.table_name)
where
	s.SEGMENT_TYPE = 'TABLE'
and s.owner = 'TOTVS10'
and t.table_name not like 'RUPD$%'
and t.table_name not like 'MLOG$%'
AND t.table_name not like 'QUEST%'
and trim(t.degree) <> 'DEFAULT'
and s.BYTES/1024/1024/1024 > 1)
  LOOP
    EXECUTE IMMEDIATE 'alter table '||r.owner||'.'||r.table_name||' parallel (degree default)';
  END LOOP;
END;
/


select table_name,degree from dba_tables where owner='TOTVS10' and trim(degree) <> 'DEFAULT'
and table_name not like 'RUPD$%'
and table_name not like 'MVLOG%'
AND table_name not like 'QUEST%';

set lines 200
col 2 format a20
select
    s.SEGMENT_NAME, 
    s.BYTES/1024/1024/1024,
    t.degree
from dba_segments s inner join dba_tables t on (s.SEGMENT_NAME = t.table_name)
where
	s.SEGMENT_TYPE = 'TABLE'
and s.owner = 'TOTVS10'
and t.table_name not like 'RUPD$%'
and t.table_name not like 'MLOG$%'
AND t.table_name not like 'QUEST%'
and trim(t.degree) <> 'DEFAULT'
and s.BYTES/1024/1024/1024 > 1;

ALTER TABLE totvs10.SE2500 parallel (degree default);