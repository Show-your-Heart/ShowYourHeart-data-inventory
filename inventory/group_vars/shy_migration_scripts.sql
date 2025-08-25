--https://www.percona.com/blog/new-features-in-postgresql-14-bulk-inserts-for-foreign-data-wrappers/
--------------------------
-- START DELETES ---------
--------------------------
delete from external.mig_organizations_organization_methods
where exists (select *
	from external.corr_method l
	where mig_organizations_organization_methods.method_id=l.uuid
);

delete from external.mig_methods_method_indicators
where exists (select *
	from external.corr_method l
	where mig_methods_method_indicators.method_id=l.uuid
);

delete from external.mig_methods_campaign_methods
where exists (select *
	from external.corr_method l
	where mig_methods_campaign_methods.method_id=l.uuid
);


delete from external.mig_methods_method_legal_structures
where exists (select *
	from external.corr_method l
	where mig_methods_method_legal_structures.method_id=l.uuid
);

delete from external.mig_methods_list_items
where exists (select *
	from external.corr_listitem l
	where mig_methods_list_items.listitem_id=l.uuid
);

delete from external.mig_methods_listitem
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_listitem.created_by_id=u.id
    and u.name='MIGRATION'
);

delete from external.mig_methods_list
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_list.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_methods_method
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_method.created_by_id=u.id
    and u.name='MIGRATION'
);


delete from external.mig_methods_indicator_topics
where exists (
    select *
    from external.mig_methods_indicator i
    join external.mig_users_user u on i.created_by_id=u.id
    where mig_methods_indicator_topics.indicator_id=i.id
);

delete
from external.mig_methods_indicator
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_indicator.created_by_id=u.id
    and u.name='MIGRATION'
);

delete
from external.mig_methods_topic
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_topic.created_by_id=u.id
    and u.name='MIGRATION'
);

delete
from external.mig_methods_campaign
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_campaign.created_by_id=u.id
    and u.name='MIGRATION'
);

delete
from external.mig_organizations_organization
where exists (
    select *
    from external.mig_users_user u
    where mig_organizations_organization.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_settings_network
where exists (
    select *
    from external.mig_users_user u
    where mig_settings_network.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_users_user
where exists (
    select *
    from external.mig_users_user u
    where mig_users_user.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_settings_legalstructure
where exists (
    select *
    from external.mig_users_user u
    where mig_settings_legalstructure.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_settings_sector
where exists (
    select *
    from external.mig_users_user u
    where mig_settings_sector.created_by_id=u.id
    and u.name='MIGRATION'
);


--TODO delete geodata

--------------------------
-- END DELETES -----------
--------------------------

insert into external.mig_users_user
select 'migrationMIGRATION' as password
, null as last_login
, false as is_superuser
, uuid_in(md5(random()::text || random()::text)::cstring) as id
, current_timestamp as created_at
, current_timestamp as updated_at
, 'MIGRATION' as name
, 'MIGRATION' as surname
, 'MIGRATION'  as email
, 0 as email_verification_code
, false as email_verified
, true as is_active
, false as is_staff
, null as created_by_id
where not exists (
    select *
    from external.mig_users_user
    where name='MIGRATION'
)
;


--------------------------
-- START GEODATA ---------
--------------------------

insert into external.mig_geodata_country
select seq,'Espanya' from external.mig_seq_view_geodata_country;

insert into external.mig_geodata_autonomouscommunity
select external.mig_seq_view_geodata_autonomouscommunity_nextval(), jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' , c.id
from ec.autonomous_community q
, external.mig_geodata_country c
where c.name='Espanya';


with tb as (
select jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as prov
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as prov_es
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as ccaa
from ec.provinces q
join ec.autonomous_community c on q.id_autonomous_community = c."ID"
)
insert into external.mig_geodata_province
select external.mig_seq_view_geodata_province_nextval(),coalesce(prov, prov_es), mc.id, null
from tb
join external.mig_geodata_autonomouscommunity mc on  ccaa=mc.name;


with tb as (
select jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as reg
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as prov
from ec.regions q
join ec.provinces c on q.id_province=c."ID"
)
insert into external.mig_geodata_region
select external.mig_seq_view_geodata_region_nextval(),reg, null, mc.id
from tb
join external.mig_geodata_province mc on  prov=mc.name




create table external.mig_towns as
select jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as town
, jsonb_path_query(p.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as prov
, jsonb_path_query(p.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as prov_es
, jsonb_path_query(r.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as region
from ec.towns q
	left join ec.provinces p on q.id_province=p."ID"
	left join ec.regions r on q.id_region=r."ID";


with tb as (
select distinct * from external.mig_towns
)
insert into external.mig_geodata_city
select
-row_number() over(order by town, mc.id, mr.id),
town, mc.id, mr.id
from tb
left join external.mig_geodata_province mc on  coalesce(prov,prov_es)=mc.name
left join external.mig_geodata_region mr on region=mr.name;

drop table external.mig_towns;

--------------------------
-- END GEODATA -----------
--------------------------


--------------------------
-- START SETTINGS --------
--------------------------

drop table if exists external.corr_sector;
create table external.corr_sector as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.sectors;


with t as (select uuid, current_timestamp, current_timestamp
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
, null
, null
from ec.sectors q
join external.corr_sector c on q."ID"=c.id
)
insert into external.mig_settings_sector
select uuid, current_timestamp, current_timestamp
,left(ca,50)as name, left(ca,50) as en, left(ca,50), left(gl,50), left(eu,50), left(es,50)
, null
, us.id
from t
, (select id from external.mig_users_user where name='MIGRATION') us;



drop table if exists external.corr_legalstructure;
create table external.corr_legalstructure as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.legal_forms;

insert into external.mig_settings_legalstructure
select c.uuid, current_timestamp, current_timestamp
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
, null
, null
, cp.uuid as parent_id
from ec.legal_forms q
join external.corr_legalstructure c on q."ID"=c.id
left join external.corr_legalstructure cp on q.id_parent=cp.id
, (select id from external.mig_users_user where name='MIGRATION') us;


--------------------------
-- END SETTINGS ----------
--------------------------



drop table if exists external.corr_user;
create table external.corr_user as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
, case
	when u."EMAIL" is null or u."EMAIL"='' or u."EMAIL"='-'
		then 'No email@'||uuid_in(md5(random()::text || random()::text)::cstring)||'.org'
	when d."EMAIL" is not null and d.minid<>u."ID"
		then u."ID"::varchar||'_'||u."EMAIL"
	else u."EMAIL" end as email
from ec.user u
left join (
	select "EMAIL", min("ID") as minid
	from ec.user
	group by "EMAIL"
	having count(*)>1
	) d on u."EMAIL"=d."EMAIL";

insert into external.mig_users_user
select 'migration'||"ID"::varchar as password
, null as last_login
, false as is_superuser
, c.uuid as id
, current_timestamp as created_at
, current_timestamp as updated_at
, coalesce(left(u."NAME",50),'') as name
, coalesce(left(u."SURNAME",50),'') as surname
, c.email as email
, 0 as email_verification_code
, false as email_verified
, true as is_active
, false as is_staff
, us.id as created_by_id
from ec.user u
join external.corr_user c on u."ID"=c.id
, (select id from external.mig_users_user where name='MIGRATION') us;




drop table if exists external.corr_network;
create table external.corr_network as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.social_agent;

insert into external.mig_settings_network
select c.uuid as id
, current_timestamp as created_at
, current_timestamp as updated_at
, left(m.name,50)
, us.id as created_by_id
, cu.uuid
, null as parent_network_id
from ec.social_agent m
join external.corr_network c on m."ID"=c.id
join external.corr_user cu on m.id_user=cu.id
, (select id from external.mig_users_user where name='MIGRATION') us;




--insert into external.mig_organizations_organization
--select uuid_in(md5(random()::text || random()::text)::cstring) as id
--, current_timestamp as created_at
--, current_timestamp as updated_at
--, e.entity_name as name
--, e.entity_nif as vat_number
--, e.entity_web
--, gc.id as country
--, gr.id as region
--, gci.id as city
--, case id_status when 1 then 0 when 4 then 1 when 3 then 2 end as status
--, muu.id as contact_id
--, us.id as created_by_id
--, ls.id as legal_structure_id
--from external.entities e
--left join external.mig_geodata_region gr on e.entity_comarca=gr.name
--left join external.mig_geodata_city gci on e.entity_town=gci.name
--left join external.mig_settings_legalstructure ls on ls.name=e.entity_legal_form
--left join external.mig_users_user muu on muu.password= 'migration'||e.entity_id_user::varchar
--, external.mig_geodata_country gc
--, (select id from external.mig_users_user where name='MIGRATION') us
--where gc.name='Espanya'
--and e.id_status in (1,3,4);


drop table if exists external.corr_organization;
create table external.corr_organization as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.entities;

--TODO fer la join per city per població i província
insert into external.mig_organizations_organization
select c.uuid as id
, current_timestamp as created_at
, current_timestamp as updated_at
, left(e.name,50) as name
, left(e."NIF",20) as vat_number
, left(e."WEB",100)
, 'N/A' --, gc.id as country
, 'N/A' --, gr.id as region
, 'N/A' --, gci.id as city
, case id_bs_state when 1 then 0 when 4 then 1 when 3 then 2 end as status
, cu.uuid as contact_id
, us.id as created_by_id
, ls.uuid as legal_structure_id
from ec.entities e
join external.corr_organization c on e."ID"=c.id
join external.corr_legalstructure ls on ls.id=e.id_legal_form  --hi ha casos que no hi son
left join external.corr_user cu on cu.id= e.id_user
, external.mig_geodata_country gc
, (select id from external.mig_users_user where name='MIGRATION') us
where gc.name='Espanya'
and e.id_bs_state in (1,3,4);




drop table if exists external.corr_campaign;
create table external.corr_campaign as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.campaigns;

insert into external.mig_methods_campaign
select q.uuid , current_timestamp, current_timestamp
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, year
, case when "ACTIVE"=1 then true else false end as status
, case when start_date<>'0000-00-00' then start_date::date else '9999-12-31' end
, case when end_date<>'0000-00-00' then end_date::date else '9999-12-31' end
, us.id
, qp.uuid
from ec.campaigns c
join external.corr_campaign q on c."ID"=q.id
left join external.corr_campaign qp on c.id_previous_campaign=qp.id
, (select id from external.mig_users_user where name='MIGRATION') us
;


drop table if exists external.corr_topic;
create table external.corr_topic as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.form_blocks;


with t as (
	select "ID", "ID_PARENT"
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as dca
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as dgl
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as deu
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as des
	from ec.form_blocks q
)
insert into external.mig_methods_topic
select c.uuid, current_timestamp, current_timestamp
, case when left(ca,50)='' then left(es,50) else left(ca,50) end
, case when left(ca,50)='' then left(es,50) else left(ca,50) end, left(ca,50), left(gl,50), left(eu,50), left(es,50), null
, dca, dca, dca, dgl, deu, des, null
, us.id
, cp.uuid
from t
	join external.corr_topic c on t."ID" = c.id
	left join external.corr_topic cp on t."ID_PARENT" = cp.id
	, (select id from external.mig_users_user where name='MIGRATION') us
;



drop table if exists external.corr_indicator;
create table external.corr_indicator as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.questions;


-- Message multiidioma
-- revisar units
-- revisar longituds name + description
-- names/description a null
-- alguns donen problemes

with
qt as (
select *,
regexp_replace(regexp_replace(regexp_replace(regexp_replace(q.name, '\t', '', 'g'), 'fórmu"la"', 'fórmula'), 'contemp"la"', 'contempla'), '\\\\"', '') as nm
, regexp_replace(regexp_replace(regexp_replace(regexp_replace(q.description, '\t', '', 'g'), 'fórmu"la"', 'fórmula'), 'contemp"la"', 'contempla'), '\\\\"', '') as descr
from ec.questions q
where q."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306')
),
t as (
select *
	, jsonb_path_query(q.nm::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
	, jsonb_path_query(q.nm::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
	, jsonb_path_query(q.nm::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
	, jsonb_path_query(q.nm::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
	, jsonb_path_query(q.descr::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as dca
	, jsonb_path_query(q.descr::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as dgl
	, jsonb_path_query(q.descr::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as deu
	, jsonb_path_query(q.descr::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as des
	from qt q
)
insert into external.mig_methods_indicator
select q.uuid, current_timestamp, current_timestamp,
"QUESTION_KEY", t.version
, coalesce(case when left(ca,50)='' then left(es,50) else left(ca,50) end, left(gl,50), left(eu,50), left(es,50),'ND')
, case when left(ca,50)='' then left(es,50) else left(ca,50) end, left(ca,50), left(gl,50), left(eu,50), left(es,50), null
, coalesce(left(dca,400), left(dgl,400), left(deu,400), left(des,400), 'ND')
, left(dca,400), left(dca,400), left(dgl,400), left(deu,400), left(des,400),null
, true
, 'SC' as category -- TODO
, case "QUESTIONTYPE"
	when '' then 'S'
	when 'Boolean' then 'B'
	when 'Check' then 'CH'
	when 'Combo' then 'DR'
	when 'Date' then 'D'
	when 'Decimal' then 'DC'
	when 'Gender' then 'I'
	when 'GenderDecimal' then 'DC'
	when 'Literal' then 'T'
	when 'Number' then 'DC'
	when 'PercentageGroup' then 'DC'
	when 'Radio' then 'R'
	when 'Range' then 'R'
	when 'Sector' then 'DR'
	when 'SingleText' then 'S'
	when 'Text' then 'T'
	else 'S'
	end
, '' as sub_data_type -- TODO
, case "UNIT"
	when '' then 'C'
	when 'Boolean' then 'C'
	when 'DinA4' then 'C'
	when 'Euro' then 'DL'
	when 'Hores' then 'C'
	when 'KgAny' then 'C'
	when 'Kwh' then 'E'
	when 'Litres' then 'C'
	when 'M3' then 'C'
	when 'Nombre' then 'C'
	when 'Percentage' then 'C'
	when 'Persones' then 'C'
	when 'Tones' then 'K'
	else 'C'
end
, '' as condition, '' as formula
, left(coalesce(t."VALIDATION", ''), 50)
, '' as message
,  us.id
, null list_options_id
from t
	join external.corr_indicator q on t."ID" = q.id
	, (select id from external.mig_users_user where name='MIGRATION') us
;



insert into external.mig_methods_indicator_topics
with t as (
select distinct ci.uuid as induuid, ct.uuid as topuuid
from ec.module_form_block_question q
join ec.module_form_block fb on q.id_module_form_block = fb.id
join  external.corr_topic ct on fb.id_form_block =ct.id
join external.corr_indicator ci on q.id_question=ci.id
join ec.questions qu on q.id_question=qu."ID"
where  qu."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306')
)
select -row_number()over(order by induuid, topuuid), induuid, topuuid
from t;





drop table if exists external.corr_method;
create table external.corr_method as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.modules;


with modules as (
	select *
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as dca
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as dgl
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as deu
	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as des
	from ec.modules q
)
insert into external.mig_methods_method
select c.uuid, current_timestamp, current_timestamp, case when "ACTIVE"=1 then true else false end
, left(ca,50), left(ca,50), left(ca,50), left(gl,50), left(eu,50), left(es,50), null
, coalesce(left(dca,400),left(dgl,400), left(deu,400), left(des,400),'ND'), left(dca,400), left(dca,400), left(dgl,400), left(deu,400), left(des,400), null
, coalesce(type, 'ORG') as unit_of_analysis --TODO
, '' as documentation --TODO
, us.id
, coalesce(sn.id, nt.id)
from modules m
join external.corr_method c on m."ID" = c.id
left join ( --TODO revisar join/left join
	select id_module, min(id_social_agent) as id_social_agent
	from ec.social_agent_module
	group by id_module
) sa on sa.id_module=m."ID"
left join external.corr_network n on sa.id_social_agent=n.id
left join external.mig_settings_network sn on n.uuid=sn.id
left join (
	select "ID_MODULE", case when max(et."NAME")='Entity' then 'ORG' else 'PRO' end as type
	from ec.modules_evaluable_types met
	join ec.evaluable_type et on met."ID_EVALUABLE_TYPE" =et."ID"
	group by "ID_MODULE"
) ti on ti."ID_MODULE"=m."ID"
, (select id from external.mig_users_user where name='MIGRATION') us
, (select id from external.mig_settings_network where name='Xarxa d''Economia Solidària') nt -- per defecte owner XES




drop table if exists external.corr_list;
create table external.corr_list as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.custom_list;

insert into external.mig_methods_list
select l.uuid, current_timestamp, current_timestamp, q.name, q.name, q.name, null, null, null, null, case when q.other_enabled =0 then false else true end, us.id
from ec.custom_list q
join external.corr_list l on q."ID"=l.id
, (select id from external.mig_users_user where name='MIGRATION') us
;



drop table if exists external.corr_listitem;
create table external.corr_listitem as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.custom_list_item;

with t as (
select *
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
from ec.custom_list_item q
)
insert into external.mig_methods_listitem
select l.uuid, current_timestamp, current_timestamp
, coalesce(left(ca,50),left(es,50), left(eu,50), left(gl,50))
, left(ca,50), left(ca,50), left(gl,50), left(eu,50), left(es,50), null
, '' as formula, value, case when active='1' then true else false end as active
, us.id
from t q
join external.corr_listitem l on q."ID"=l.id
, (select id from external.mig_users_user where name='MIGRATION') us
;


insert into external.mig_methods_list_items
select -row_number()over( order by li.uuid), l.uuid, li.uuid
    from ec.custom_list_item q
    join external.corr_listitem  li on q."ID" =li.id
    join external.corr_list l on q.id_custom_list = l.id;

insert into external.mig_methods_method_legal_structures
select -row_number() over (order by m.id, l.id), m."uuid" , l."uuid"
from ec.modules_legalforms ml
join external.corr_method m on m.id =ml.id_module
join external.corr_legalstructure l on l.id = ml.id_legalform ;


insert into external.mig_methods_campaign_methods
select -row_number() over (order by c.id, l.id), c."uuid" , l."uuid"
from ec.modules m
join external.corr_campaign c on m.id_campaign = c.id
left join external.corr_method l on m."ID" = l.id ;



insert into external.mig_methods_method_indicators
select -row_number() over (order by c.id, l.id), l."uuid", c."uuid"
from ec.modules_indicators m
join external.corr_indicator c on m.id_indicator  = c.id
join external.corr_method l on m.id_module = l.id
join ec.questions q on q."ID"=c.id
where q."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306');


insert into external.mig_organizations_organization_methods
select  -row_number() over (order by o.id, l.id), o.uuid, l.uuid
from ec.entity_module m
join external.corr_organization o on m.id_entity = o.id
join external.mig_organizations_organization mo on mo.id = o."uuid"
join external.corr_method l on m.id_module = l.id
join ec.questions q on q."ID"=l.id
where q."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306');