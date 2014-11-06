BEGIN        
  FOR r IN (select index_name from dba_indexes where OWNER='TOTVS10'
  	and index_name not like 'SYS%')
  LOOP
    EXECUTE IMMEDIATE 'alter index  TOTVS10.' || r.index_name || ' rebuild online';
  END LOOP;
END;
/