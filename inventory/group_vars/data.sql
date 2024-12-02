CREATE TABLE data (
    data date,
    dies_mes smallint,
    dia_setmana integer,
    es_primer_dia_mes boolean,
    es_ultim_dia_mes boolean,
    es_primer_dia_trimestre boolean,
    es_ultim_dia_trimestre boolean,
    es_primer_dia_any boolean,
    es_ultim_dia_any boolean
);


insert into data (data)
select  cast('2009-12-31' as date) + ((rn||' days')::INTERVAL)
from (
select row_number() over (order by (select 1)) as rn from odoo_contract_contract limit 5000
) a;


update data set dies_mes=date_part('day', date_trunc('month', data)+interval '1 month'-interval '1 day' )
,dia_setmana = date_part('dow', data)
,es_primer_dia_mes = date_part('day', data)=1
,es_ultim_dia_mes = date_part('day', data+1)=1
,es_primer_dia_trimestre = date_trunc('quarter', data)=data
,es_ultim_dia_trimestre = date_trunc('quarter', data)+interval '3 months'=data+1
,es_primer_dia_any = date_trunc('year', data)=data
,es_ultim_dia_any = date_trunc('year', data)+interval '12 months'=data+1
;