-- Exibe todas as Sessões bloqueadas
prompt blocked sessions from V$LOCK
select /*+ ORDERED */
blocker.sid blocker_sid
, blocked.sid blocked_sid
, TRUNC(blocked.ctime/60) min_blocked
, blocked.request
from (select *
from v$lock
where block != 0
and type = 'TX') blocker
, v$lock blocked
where blocked.type='TX'
and blocked.block = 0
and blocked.id1 = blocker.id1
/