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