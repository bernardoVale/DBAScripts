break on report
compute sum of Value on report
select METRIC_NAME,avg(AVERAGE) as "Value"
   from dba_hist_sysmetric_summary
   where METRIC_NAME in ('Physical Read Total IO Requests Per Sec','Physical Write Total IO Requests Per Sec')
   group by METRIC_NAME;