COLUMN size_mb      FORMAT '999,999,990.0'
COLUMN num_rows     FORMAT '999,999,990'
COLUMN fmt_short    FORMAT A24


COLUMN owner        FORMAT A16
COLUMN table_name   LIKE fmt_short
COLUMN tablespace_name  LIKE fmt_short

SET LINESIZE 200
SET AUTOTRACE OFF

COMPUTE SUM OF size_mb ON REPORT
BREAK ON REPORT

SELECT 
    lower( owner )      AS owner
    ,lower(table_name)  AS table_name
    ,tablespace_name
    ,num_rows
    ,blocks*8/1024      AS size_mb
    ,pct_free
    ,compression 
    ,logging
FROM    all_tables 
WHERE   owner           LIKE UPPER('&1')
OR  owner           = USER
ORDER BY 1,2;

CLEAR COMPUTES
CLEAR BREAKS
