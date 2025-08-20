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
, null as created_by_id;


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



with t as (select uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
, null
, null
from ec.sectors q)
insert into external.mig_settings_sector
select uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp
,left(ca,50)as name, left(ca,50) as en, left(ca,50), left(gl,50), left(eu,50), left(es,50)
, null
, us.id
from t
, (select id from external.mig_users_user where name='MIGRATION') us;



insert into external.mig_settings_legalstructure
select uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
, null
, null
, null as parent_id
from ec.legal_forms q
where id_parent is null;

insert into external.mig_settings_legalstructure
with t as (
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
, jsonb_path_query(p.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as parent_ca
from ec.legal_forms q
join ec.legal_forms p on q.id_parent=p."ID"
)
select uuid, current_timestamp, current_timestamp, ca as name, ca as en, ca, gl, eu, es
, null
, us.id
, l.id as parent_id
from t
join external.mig_settings_legalstructure l on t.parent_ca=l.name
, (select id from external.mig_users_user where name='MIGRATION') us;


insert into external.mig_settings_legalstructure
with t as (
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
, jsonb_path_query(p.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as parent_ca
from ec.legal_forms q
join ec.legal_forms p on q.id_parent=p."ID"
)
select uuid, current_timestamp, current_timestamp, ca as name, ca as en, ca, gl, eu, es
, null
, us.id
, l.id as parent_id
from t
join external.mig_settings_legalstructure l on t.parent_ca=l.name
, (select id from external.mig_users_user where name='MIGRATION') us
where not exists (
	select*
	from  external.mig_settings_legalstructure e
	left join external.mig_settings_legalstructure e2 on e2.id=e.parent_id
	where t.ca=e.name
	and coalesce(t.parent_ca,'')=coalesce(e2.name,'')
);


insert into external.mig_users_user
select 'migration'||"ID"::varchar as password
, null as last_login
, false as is_superuser
, uuid_in(md5(random()::text || random()::text)::cstring) as id
, current_timestamp as created_at
, current_timestamp as updated_at
, coalesce(left(u."NAME",50),'') as name
, coalesce(left(u."SURNAME",50),'') as surname
, coalesce(u."EMAIL",'no email ')||uuid_in(md5(random()::text || random()::text)::cstring)  as email
, 0 as email_verification_code
, false as email_verified
, true as is_active
, false as is_staff
, us.id as created_by_id
from ec.user u
, (select id from external.mig_users_user where name='MIGRATION') us;


insert into external.mig_settings_network
select uuid_in(md5(random()::text || random()::text)::cstring) as id
, current_timestamp as created_at
, current_timestamp as updated_at
, left(m.name,50)
, us.id as created_by_id
, muu.id
, null as parent_network_id
from ec.social_agent m
join external.mig_users_user muu on muu.password= 'migration'||m.id_user::varchar
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

--TODO fer la join per city per població i província
insert into external.mig_organizations_organization
select uuid_in(md5(random()::text || random()::text)::cstring) as id
, current_timestamp as created_at
, current_timestamp as updated_at
, left(e.entity_name,50) as name
, left(e.entity_nif,20) as vat_number
, left(e.entity_web,100)
, 'N/A' --, gc.id as country
, 'N/A' --, gr.id as region
, 'N/A' --, gci.id as city
, case id_status when 1 then 0 when 4 then 1 when 3 then 2 end as status
, muu.id as contact_id
, us.id as created_by_id
, ls.id as legal_structure_id
from external.entities e
left join external.mig_geodata_region gr on e.entity_comarca=gr.name
left join external.mig_geodata_city gci on e.entity_town=gci.name
join external.mig_settings_legalstructure ls on ls.name=e.entity_legal_form  --hi ha casos que no hi son
left join external.mig_users_user muu on muu.password= 'migration'||e.entity_id_user::varchar
, external.mig_geodata_country gc
, (select id from external.mig_users_user where name='MIGRATION') us
where gc.name='Espanya'
and e.id_status in (1,3,4);