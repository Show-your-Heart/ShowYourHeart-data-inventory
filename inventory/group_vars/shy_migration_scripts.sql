--https://www.percona.com/blog/new-features-in-postgresql-14-bulk-inserts-for-foreign-data-wrappers/
--------------------------
-- START DELETES ---------
--------------------------
delete from external.mig_methods_invitation
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_invitation.created_by_id=u.id
    and u.name='MIGRATION'
);


delete from external.mig_methods_externalsurveyinvitation
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_externalsurveyinvitation.created_by_id=u.id
    and u.name='MIGRATION'
);


delete from external.mig_methods_section_indicators
where exists (select *
	from external.corr_section l
	where mig_methods_section_indicators.section_id=l.uuid
);


delete from external.mig_methods_section
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_section.created_by_id=u.id
    and u.name='MIGRATION'
);


delete from external.mig_methods_indicatorresult
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_indicatorresult.created_by_id=u.id
    and u.name='MIGRATION'
);

delete from external.mig_methods_survey
where exists (
    select *
    from external.mig_users_user u
    where mig_methods_survey.created_by_id=u.id
    and u.name='MIGRATION'
);

--delete from external.mig_settings_gender
--where exists (
--    select *
--    from external.mig_users_user u
--    where mig_settings_gender.created_by_id=u.id
--    and u.name='MIGRATION'
--);

delete from external.mig_users_userprofile
where exists (
    select *
    from external.mig_users_user u
    where mig_users_userprofile.created_by_id=u.id
    and u.name='MIGRATION'
);


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


delete
from external.mig_geodata_city
where exists (
    select *
    from external.mig_users_user u
    where mig_geodata_city.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_geodata_region
where exists (
    select *
    from external.mig_users_user u
    where mig_geodata_region.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_geodata_province
where exists (
    select *
    from external.mig_users_user u
    where mig_geodata_province.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_geodata_autonomouscommunity
where exists (
    select *
    from external.mig_users_user u
    where mig_geodata_autonomouscommunity.created_by_id=u.id
    and u.name='MIGRATION'
);

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
select  uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp
,'Espanya' , 'Spain', 'Espanya', 'España', 'Espainia', 'España', 'Spain'
, us.id
from (select id from external.mig_users_user where name='MIGRATION') us
;


drop table if exists external.corr_autonomouscommunity;
create table external.corr_autonomouscommunity as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.autonomous_community;


insert into external.mig_geodata_autonomouscommunity
select ca.uuid
, current_timestamp, current_timestamp
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}'
, null
, us.id
, c.id
from ec.autonomous_community q
join external.corr_autonomouscommunity ca on q."ID"=ca.id
, external.mig_geodata_country c
, (select id from external.mig_users_user where name='MIGRATION') us
where c.name='Spain';


drop table if exists external.corr_province;
create table external.corr_province as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.provinces;


with tb as (
select jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as prov
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as prov_es
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as prov_gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as prov_eu
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as ccaa
, q."ID"
from ec.provinces q
join ec.autonomous_community c on q.id_autonomous_community = c."ID"
)
insert into external.mig_geodata_province
select pr.uuid, current_timestamp, current_timestamp
,coalesce(prov, prov_es), prov, prov, prov_gl, prov_eu, prov_es, null, mc.id, c.id, us.id
from tb
join external.mig_geodata_autonomouscommunity mc on  ccaa=mc.name
join external.corr_province pr on tb."ID"=pr.id
, (select id from external.mig_users_user where name='MIGRATION') us
, (select id from external.mig_geodata_country c where name='Spain') c
;


drop table if exists external.corr_region;
create table external.corr_region as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.regions;


with tb as (
select jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as reg
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as reg_gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as reg_eu
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as reg_es
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as prov
, q."ID"
from ec.regions q
join ec.provinces c on q.id_province=c."ID"
)
insert into external.mig_geodata_region
select  r.uuid, current_timestamp, current_timestamp
,reg, reg, reg, reg_gl, reg_eu, reg_es, null
, null
, us.id
, mc.id
from tb
join external.mig_geodata_province mc on  prov=mc.name
join external.corr_region r on tb."ID"=r.id
, (select id from external.mig_users_user where name='MIGRATION') us;


drop table if exists external.corr_city;
create table external.corr_city as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.towns;


create table external.mig_towns as
select jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as town
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as town_es
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as town_gl
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as town_eu
, jsonb_path_query(p.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as prov
, jsonb_path_query(p.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as prov_es
, jsonb_path_query(r.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}' as region
, q."ID"
from ec.towns q
	left join ec.provinces p on q.id_province=p."ID"
	left join ec.regions r on q.id_region=r."ID";

with tb as (
select distinct * from external.mig_towns
)
insert into external.mig_geodata_city
select
 c.uuid, current_timestamp, current_timestamp,
town, town, town, town_gl, town_eu, town_es, null
, us.id
, mc.id, mr.id
from tb
join external.corr_city c on c.id=tb."ID"
left join external.mig_geodata_province mc on  coalesce(prov,prov_es)=mc.name
left join external.mig_geodata_region mr on region=mr.name
, (select id from external.mig_users_user where name='MIGRATION') us;


drop table external.mig_towns;

--------------------------
-- END GEODATA -----------
--------------------------



---------------------------------
-- START SETTINGS_SECTOR --------
---------------------------------

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
,ca as name, ca as en, ca, gl, eu, es
, null
, us.id
from t
, (select id from external.mig_users_user where name='MIGRATION') us;

---------------------------------
-- END SETTINGS_SECTOR ----------
---------------------------------


------------------------------------------
-- START SETTINGS_LEGALSTRUCTURE ---------
------------------------------------------


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


------------------------------------------
-- END SETTINGS_LEGALSTRUCTURE -----------
------------------------------------------


-----------------------------
-- START USERS_USER ---------
-----------------------------

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
, coalesce(u."NAME",'') as name
, coalesce(u."SURNAME",'') as surname
, c.email as email
, 0 as email_verification_code
, false as email_verified
, true as is_active
, false as is_staff
, us.id as created_by_id
from ec.user u
join external.corr_user c on u."ID"=c.id
, (select id from external.mig_users_user where name='MIGRATION') us;

---------------------------
-- END USERS_USER ---------
---------------------------

-----------------------------------
-- START SETTINGS_NETWORK ---------
-----------------------------------

drop table if exists external.corr_network;
create table external.corr_network as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.social_agent;

insert into external.mig_settings_network
select c.uuid as id
, current_timestamp as created_at
, current_timestamp as updated_at
, m.name
, us.id as created_by_id
, cu.uuid
, null as parent_network_id
from ec.social_agent m
join external.corr_network c on m."ID"=c.id
join external.corr_user cu on m.id_user=cu.id
, (select id from external.mig_users_user where name='MIGRATION') us;


---------------------------------
-- END SETTINGS_NETWORK ---------
---------------------------------


---------------------------------------------
-- START ORGANIZATIONS_ORGANIZATION ---------
---------------------------------------------

drop table if exists external.corr_organization;
create table external.corr_organization as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.entities;

insert into external.mig_organizations_organization
select c.uuid as id
, current_timestamp as created_at
, current_timestamp as updated_at
, e.name as name
, null as logo --Update a posteriori. Primer s'ha de pujar el fitxer a s3
, e."NIF" as vat_number
, e."WEB"
, case id_bs_state when 1 then 0 when 4 then 1 when 3 then 2 when 2 then 3 end as status
, cy.uuid as town
--, cu.uuid as contact_id
, gc.id as country
, us.id as created_by_id
, ls.uuid as legal_structure_id
, mgc.region_id as region
from ec.entities e
join external.corr_organization c on e."ID"=c.id
join external.corr_legalstructure ls on ls.id=e.id_legal_form  --hi ha casos que no hi son
--join external.corr_user cu on cu.id= e.id_user --hi ha casos que no hi son
left join external.corr_city cy on e.id_town=cy.id
left join external.mig_geodata_city mgc on cy.uuid=mgc.id
, external.mig_geodata_country gc
, (select id from external.mig_users_user where name='MIGRATION') us
where gc.name='Spain'
and e.id_bs_state in (1,2,3,4);


--suposem que els fitxers estan pujats a s3
update external.mig_organizations_organization set logo = mig_organizations_organization.id::varchar||'.'||
CASE
         WHEN substring(e.logo FROM 1 FOR 8) = E'\\x89504e470d0a1a0a' THEN 'PNG'
         WHEN substring(e.logo FROM 1 FOR 3) = E'\\xffd8ff' THEN 'JPEG'
         WHEN substring(e.logo FROM 1 FOR 4) = E'GIF8' THEN 'GIF'
         ELSE 'Desconegut' end
from ec.entities e
join external.corr_organization o on e."ID"=o.id
where  CASE
         WHEN substring(e.logo FROM 1 FOR 8) = E'\\x89504e470d0a1a0a' THEN 'PNG'
         WHEN substring(e.logo FROM 1 FOR 3) = E'\\xffd8ff' THEN 'JPEG'
         WHEN substring(e.logo FROM 1 FOR 4) = E'GIF8' THEN 'GIF'
         ELSE 'Desconegut'
       end<>'Desconegut'
       and o.uuid=mig_organizations_organization.id;

--from sqlalchemy import create_engine
--import urllib.parse
--from boto3 import client
--
--password_enc = urllib.parse.quote_plus("")
--con = create_engine(f'postgresql+psycopg2://usuari:{password_enc}@localhost:64320/dwh')
--
--results = con.execute("""
--select logo, CASE
--         WHEN substring(logo FROM 1 FOR 8) = E'\\\\x89504e470d0a1a0a' THEN 'PNG'
--         WHEN substring(logo FROM 1 FOR 3) = E'\\\\xffd8ff' THEN 'JPEG'
--         WHEN substring(logo FROM 1 FOR 4) = E'GIF8' THEN 'GIF'
--         ELSE 'Desconegut'
--       END AS tipus, e."ID", o.uuid
--from ec.entities e
--join external.corr_organization o on e."ID"=o.id
--where  CASE
--         WHEN substring(logo FROM 1 FOR 8) = E'\\\\x89504e470d0a1a0a' THEN 'PNG'
--         WHEN substring(logo FROM 1 FOR 3) = E'\\\\xffd8ff' THEN 'JPEG'
--         WHEN substring(logo FROM 1 FOR 4) = E'GIF8' THEN 'GIF'
--         ELSE 'Desconegut'
--       end<>'Desconegut'
--       """)
--
--s3 = client(
--    "s3",
--    region_name="",
--    endpoint_url="",
--    aws_access_key_id="",
--    aws_secret_access_key="",
--)
--
--
--
--for record in results:
--    print("\n", record)
--    fitxer = str(record[3]) + "."+record[1]
--    local = "/Imatges/"+fitxer
--
--    with open(local, "wb") as f:
--        f.write(record[0])  # Guardem el contingut del camp BYTEA
--    s3.upload_file(local, "showyourheart", "static/logos/"+fitxer)
--

-------------------------------------------
-- END ORGANIZATIONS_ORGANIZATION ---------
-------------------------------------------



-----------------------------------
-- START METHODS_CAMPAIGN ---------
-----------------------------------

drop table if exists external.corr_campaign;
create table external.corr_campaign as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.campaigns;

insert into external.mig_methods_campaign
select q.uuid , current_timestamp, current_timestamp
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}'
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}'
, jsonb_path_query(c.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}'
, null
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

---------------------------------
-- END METHODS_CAMPAIGN ---------
---------------------------------

--------------------------------
-- START METHODS_TOPIC ---------
--------------------------------
--drop table if exists external.corr_topic;
--create table external.corr_topic as
--select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
--from ec.form_blocks;
--
--
--with t as (
--	select "ID", "ID_PARENT"
--	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
--	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
--	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
--	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
--	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as dca
--	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as dgl
--	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as deu
--	, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as des
--	from ec.form_blocks q
--)
--insert into external.mig_methods_topic
--select c.uuid, current_timestamp, current_timestamp
--, case when left(ca,50)='' then left(es,50) else left(ca,50) end
--, case when left(ca,50)='' then left(es,50) else left(ca,50) end, left(ca,50), left(gl,50), left(eu,50), left(es,50), null
--, dca, dca, dca, dgl, deu, des, null
--, us.id
--, cp.uuid
--from t
--	join external.corr_topic c on t."ID" = c.id
--	left join external.corr_topic cp on t."ID_PARENT" = cp.id
--	, (select id from external.mig_users_user where name='MIGRATION') us
--;

------------------------------
-- END METHODS_TOPIC ---------
------------------------------

-------------------------------
-- START METHODS_LIST ---------
-------------------------------

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

-----------------------------
-- END METHODS_LIST ---------
-----------------------------

-------------------------------
-- START METHODS_LISTITEM -----
-------------------------------

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
, coalesce(ca,es, eu, gl)
, ca, ca, gl, eu, es, null
, '' as formula, value, case when active='1' then true else false end as active
, us.id
from t q
join external.corr_listitem l on q."ID"=l.id
, (select id from external.mig_users_user where name='MIGRATION') us
;

-----------------------------
-- END METHODS_LISTITEM -----
-----------------------------

---------------------------------
-- START METHODS_LIST_ITEMS -----
---------------------------------

insert into external.mig_methods_list_items
select -row_number()over( order by li.uuid), l.uuid, li.uuid
    from ec.custom_list_item q
    join external.corr_listitem  li on q."ID" =li.id
    join external.corr_list l on q.id_custom_list = l.id;

---------------------------------
-- END METHODS_LIST_ITEMS -----
---------------------------------



---------------------------------
-- START METHODS_INDICATOR ------
---------------------------------
drop table if exists external.corr_indicator;
create table external.corr_indicator as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.questions;

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
	, jsonb_path_query(q.validation_message::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as vca
	, jsonb_path_query(q.validation_message::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as vgl
	, jsonb_path_query(q.validation_message::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as veu
	, jsonb_path_query(q.validation_message::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as ves
	from qt q
)
insert into external.mig_methods_indicator
select q.uuid, current_timestamp, current_timestamp,
"QUESTION_KEY", t.version
, coalesce(case when ca='' then es else ca end, gl, eu, es,'ND')
, case when ca='' then es else ca end, ca, gl, eu, es, null
, coalesce(dca, dgl, deu, des, 'ND')
, dca, dca, dgl, deu, des,null
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
, coalesce(t.vca, t.ves, t.veu, t.vgl, ''), t.vca, t.vca, t.vgl, t.veu, t.ves, null
,  us.id
, cl.uuid list_options_id
from t
	join external.corr_indicator q on t."ID" = q.id
	left join (
        select id_question, max(id_custom_list) as id_custom_list
        from ec.question_custom_list l
        group by id_question
	) li on t."ID"=li.id_question
	left join external.corr_list cl on li.id_custom_list = cl.id
	, (select id from external.mig_users_user where name='MIGRATION') us
;


drop table if exists external.corr_indicator_indirect;
create table external.corr_indicator_indirect as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.indicators;


with t as (
	select *
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
		, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
		, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
		, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
		, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as dca
		, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as dgl
		, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as deu
		, jsonb_path_query(q.description::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as des
	from ec.indicators q
)
insert into external.mig_methods_indicator
select i.uuid, current_timestamp, current_timestamp
, t."INDICATOR_KEY"
, t.version
, coalesce(ca, es, gl, eu), ca, ca, gl, eu, es, null
, coalesce(dca, des, dgl, deu), dca, dca, dgl, deu, des, null
, false
, 'SC' --TODO
, case value_type
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
,'' as condition
, t."FORMULA"
, '' as validation
, '' as message, null , null , null , null , null
, us.id
, null
from t
	join external.corr_indicator_indirect i on t."ID" = i.id
	, (select id from external.mig_users_user where name='MIGRATION') us
where t."FORMULA" is not null;


-------------------------------
-- END METHODS_INDICATOR ------
-------------------------------

----------------------------------------
-- START METHODS_INDICATOR_TOPICS ------
----------------------------------------

-- De momento solo para los directos
--insert into external.mig_methods_indicator_topics
--with t as (
--select distinct ci.uuid as induuid, ct.uuid as topuuid
--from ec.module_form_block_question q
--join ec.module_form_block fb on q.id_module_form_block = fb.id
--join  external.corr_topic ct on fb.id_form_block =ct.id
--join external.corr_indicator ci on q.id_question=ci.id
--join ec.questions qu on q.id_question=qu."ID"
--where  qu."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306')
--)
--select -row_number()over(order by induuid, topuuid), induuid, topuuid
--from t;


--------------------------------------
-- END METHODS_INDICATOR_TOPICS ------
--------------------------------------

------------------------------
-- START METHODS_METHOD ------
------------------------------

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
, ca, ca, ca, gl, eu, es, null
, coalesce(dca,dgl, deu, des,'ND'), dca, dca, dgl, deu, des, null
, coalesce(type, 'ORG') as unit_of_analysis
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
;


drop table if exists external.mig_external_modules;
create table external.mig_external_modules as
select distinct cm."uuid"
from ec.questions q
join ec.answers a on a.id_question = q."ID"
join ec.module_form_block_question mf on mf.id_question=q."ID"
join ec.module_form_block mfb on mf.id_module_form_block=mfb."id"
join ec.modules m on mfb.id_module=m."ID"
join ec.emails e on a.id_email=e."ID"
join ec.contacts c on c."ID"=e.id_contact
join external.corr_method cm on cm.id=m."ID" ;
--where a.id_email =65709

update external.mig_methods_method set unit_of_analysis='EXT'
where exists (select *
	from external.mig_external_modules m
	where mig_methods_method.id=m.uuid
);

----------------------------
-- END METHODS_METHOD ------
----------------------------


----------------------------------------
-- START METHODS_LEGAL_STRUCTURES ------
----------------------------------------


insert into external.mig_methods_method_legal_structures
select -row_number() over (order by m.id, l.id), m."uuid" , l."uuid"
from ec.modules_legalforms ml
join external.corr_method m on m.id =ml.id_module
join external.corr_legalstructure l on l.id = ml.id_legalform ;
--------------------------------------
-- END METHODS_LEGAL_STRUCTURES ------
--------------------------------------


----------------------------------------
-- START METHODS_CAMPAIGH_METHODS ------
----------------------------------------

insert into external.mig_methods_campaign_methods
select -row_number() over (order by c.id, l.id), c."uuid" , l."uuid"
from ec.modules m
join external.corr_campaign c on m.id_campaign = c.id
left join external.corr_method l on m."ID" = l.id ;

--------------------------------------
-- END METHODS_CAMPAIGH_METHODS ------
--------------------------------------

----------------------------------------
-- START METHODS_METHOD_INDICATORS -----
----------------------------------------

-- això serveix només pels indirectes.
insert into external.mig_methods_method_indicators
select -row_number() over (order by c.id, l.id), l."uuid", c."uuid"
from ec.modules_indicators m
join external.corr_indicator_indirect c on m.id_indicator  = c.id
join external.corr_method l on m.id_module = l.id
join external.mig_methods_method mm on mm.id=l.uuid
join external.mig_methods_indicator ii on c.uuid=ii.id
join ec.indicators q on q."ID"=c.id
;

-- indicadors directes
insert into external.mig_methods_method_indicators
with t as (
select distinct ci.uuid as induuid, ct.uuid as topuuid
from ec.module_form_block_question q
join ec.module_form_block fb on q.id_module_form_block = fb.id
join  external.corr_method ct on fb.id_module =ct.id
join external.corr_indicator ci on q.id_question=ci.id
join ec.questions qu on q.id_question=qu."ID"
where  qu."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306')
group by ci.uuid, ct.uuid
)
select a.id-row_number()over(order by induuid, topuuid)
, topuuid, induuid
from t
, (select min(id)as id from external.mig_methods_method_indicators) a;



--------------------------------------
-- END METHODS_METHOD_INDICATORS -----
--------------------------------------



-------------------------------------------------
-- START ORGANIZATIONS_ORGANIZATION_METHODS -----
-------------------------------------------------

insert into external.mig_organizations_organization_methods
select  -row_number() over (order by o.id, l.id), o.uuid, l.uuid
from ec.entity_module m
join external.corr_organization o on m.id_entity = o.id
join external.mig_organizations_organization mo on mo.id = o."uuid"
join external.corr_method l on m.id_module = l.id
join ec.questions q on q."ID"=l.id
where q."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306');

-----------------------------------------------
-- END ORGANIZATIONS_ORGANIZATION_METHODS -----
-----------------------------------------------


--------------------------------
-- START USERS_USERPROFILE -----
--------------------------------

with ent as (
	select u."ID", left(coalesce(max(u.phone),''),20) as phone
	, max(e."ID" ) as id_entity, max(id_legal_form) as id_legal_form
	from ec.user u
	join ec.entities e on e.id_user = u."ID"
	join external.corr_legalstructure ls on ls.id=e.id_legal_form  --hi ha casos que no hi son
	where e.id_bs_state in (1,2,3,4)
	group by u."ID"
)
insert into external.mig_users_userprofile
select c.uuid, current_timestamp, current_timestamp, phone , us.id, o.uuid, c.uuid
from ent e
join external.corr_user c on e."ID"=c.id
left join external.corr_organization o on e.id_entity=o.id
, (select id from external.mig_users_user where name='MIGRATION') us;
--------------------------------
-- END USERS_USERPROFILE -----
--------------------------------

------------------------------
-- START SETTINGS_GENDER -----
------------------------------
--
--insert into external.mig_settings_gender
--select uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp, 'D', u.id
--from external.mig_users_user u where name='MIGRATION'
--union all
--select uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp, 'H', u.id
--from external.mig_users_user u where name='MIGRATION'
--union all
--select uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp, 'NB', u.id
--from external.mig_users_user u where name='MIGRATION';
--

----------------------------
-- END SETTINGS_GENDER -----
----------------------------



-
------------------------------
-- START METHODS_SURVEY ------
------------------------------

drop table if exists external.mig_answer_question_campaign_module;
create table external.mig_answer_question_campaign_module as
select a."ID" as id_answer
, q.id_campaign
, a.id_question
, a.id_entity
, e.id_user
, m."ID" as id_module
from ec.questions q
join ec.answers a on a.id_question = q."ID"
join ec.entities e on a.id_entity=e."ID"
join ec.module_form_block_question mf on mf.id_question=q."ID"
join ec.module_form_block mfb on mf.id_module_form_block=mfb."id"
join ec.modules m on mfb.id_module=m."ID"
join ec.entity_module em on em.id_module = m."ID" and em.id_entity =  a.id_entity
where
 q.id_campaign is not null and e.id_bs_state in (1,2,3,4);;


drop table if exists external.corr_survey;
create table external.corr_survey as
with a as (
select distinct id_campaign, id_module, id_entity, id_user
from  external.mig_answer_question_campaign_module
)
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, *
from a;

insert into external.mig_methods_survey
select m.uuid, current_timestamp, current_timestamp, '' as token, 0 as status, cc.uuid
, us.id, cm.uuid, co.uuid, cu.uuid
from external.corr_survey m
join external.corr_method cm on m.id_module=cm.id
join external.corr_organization co on m.id_entity=co.id
join external.mig_organizations_organization o on co.uuid=o.id
join external.corr_user cu on m.id_user=cu.id
join external.corr_campaign cc on m.id_campaign=cc.id
, (select id from external.mig_users_user where name='MIGRATION') us


----------------------------
-- END METHODS_SURVEY ------
----------------------------




---------------------------------------
-- START METHODS_INDICATORRESULT ------
---------------------------------------
drop table if exists external.mig_aux_indicatorresult_results;
create table external.mig_aux_indicatorresult_results as
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid
	, a."ID" as id_answer
	, q."ID" as id_question
    , a.value as value_origin
    , q."QUESTIONTYPE"
    , c."ID" as id_campaign
    , a.id_entity
    , m."ID" as id_module
    from ec.questions q
        join ec.campaigns c on q.id_campaign = c."ID"
        join ec.answers  a on a.id_question = q."ID"
        join ec.module_form_block_question mf on mf.id_question=q."ID"
        join ec.module_form_block mfb on mf.id_module_form_block=mfb."id"
        join ec.modules m on mfb.id_module=m."ID"
        join ec.entity_module em on em.id_module = m."ID" and em.id_entity =  a.id_entity
    where 1=1
        and a.value is not null;


drop table if exists external.corr_indicatorresult;
create table external.corr_indicatorresult as
with genders as (
	select string_agg(id::text, ',' order by ord) as gender_id
	-- TODO validar 1: dona
	from (
		select 1 as id, 1 ord
		union all
		select 2, 2 ord
		union all
		select 3, 3 ord
	) a
)
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid_indicator_gender
, r.uuid as uuid_answer, r.id_answer, r.id_question, r.value_origin, r."QUESTIONTYPE" as question_type, r.id_campaign, r.id_entity, r.id_module
, unnest( (string_to_array(replace(replace(r.value_origin,'[',''),']',''),','))) as value
, unnest(string_to_array(g.gender_id,','))::int as answer_genders
from external.mig_aux_indicatorresult_results r
, genders g;



select *
from external.corr_indicatorresult

insert into external.mig_methods_indicatorresult
select  uuid_in(md5(random()::text || random()::text)::cstring) as id, current_timestamp as created_at, current_timestamp as updated_at
 	, case when question_type in ('Gender', 'GenderDecimal') then answer_genders else 1 end as gender_id
	, case when question_type in ('Gender', 'GenderDecimal') then ir.value else ir.value_origin end as value
 	, us.id as created_by_id
 	, i.uuid as indicator_id
 	, s.uuid as survey_id
 	--, ir.*
 from external.corr_indicatorresult ir
 	join external.corr_survey s on s. id_campaign=ir.id_campaign and  s.id_module=ir.id_module and s.id_entity=ir.id_entity
 	join external.mig_methods_survey ms on ms.id=s.uuid --TODO només els surveis que existeixen
 	join external.corr_indicator i on ir.id_question=i.id
 	join external.mig_methods_indicator mi on i.uuid=mi.id --TODO només els indicadors que existeixen
 	, (select id from external.mig_users_user where name='MIGRATION') us
where ir.value is not null
	and question_type not in ('Gender', 'GenderDecimal') -- TODO
group by case when question_type in ('Gender', 'GenderDecimal') then ir.value else ir.value_origin end
 	, us.id
 	, case when question_type in ('Gender', 'GenderDecimal') then answer_genders else 1 end
 	, i.uuid
 	, s.uuid
 	;



---------------------------------------
-- END METHODS_INDICATORRESULT --------
---------------------------------------


---------------------------------------
-- START METHODS_SECTION --------------
---------------------------------------


drop table if exists external.corr_section;
create table external.corr_section as
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, mfb.*, fb.name, fb.description
from  ec.module_form_block mfb
	join  ec.form_blocks fb on mfb.id_form_block = fb."ID"


with forms as (
select *
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
from external.corr_section q
)
insert into external.mig_methods_section
select f.uuid, current_timestamp, current_timestamp, left(f.ca,60), left(f.ca,60), left(f.ca,60), left(f.gl,60), left(f.eu,60), left(f.es,60), null,
coalesce(f.form_block_index, row_number() over (partition by f.id_module order by f.id_form_block))
, us.id
, m.uuid
, null
from forms f
	join external.corr_method m on f.id_module=m.id
	, (select id from external.mig_users_user where name='MIGRATION') us
where f.id_parent is null;


with forms as (
select *
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
from external.corr_section q
)
insert into external.mig_methods_section
select f.uuid, current_timestamp, current_timestamp, left(f.ca,60), left(f.ca,60), left(f.ca,60), left(f.gl,60), left(f.eu,60), left(f.es,60), null
,  coalesce(f.form_block_index, row_number() over (partition by f.id_module order by f.id_form_block))
, us.id
, m.uuid
, pf.uuid
from forms f
	join forms pf on f.id_parent=pf.id
	join external.corr_method m on f.id_module=m.id
	, (select id from external.mig_users_user where name='MIGRATION') us;


---------------------------------------
-- END METHODS_SECTION ----------------
---------------------------------------


---------------------------------------
-- START METHODS_SECTION_INDICATORS ---
---------------------------------------

insert into external.mig_methods_section_indicators
with t as (
select ci.uuid as induuid, ct.uuid as topuuid, min(fb.form_block_index) as form_block_index, min(fb.id_module) as id_module, min(fb.id_form_block) as id_form_block
from ec.module_form_block_question q
join ec.module_form_block fb on q.id_module_form_block = fb.id
join  external.corr_section ct on fb.id =ct.id
join external.corr_indicator ci on q.id_question=ci.id
join ec.questions qu on q.id_question=qu."ID"
where  qu."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306')
group by ci.uuid, ct.uuid
)
select -row_number()over(order by induuid, topuuid), coalesce(form_block_index, row_number() over (partition by id_module order by id_form_block))
, topuuid, induuid
from t;

---------------------------------------
-- END METHODS_SECTION_INDICATORS -----
---------------------------------------



---------------------------------------------
-- START METHODS_ESTERNALSURVEYINVITATION ---
---------------------------------------------

drop table if exists external.mig_external_modules_invitations;
create table external.mig_external_modules_invitations as
select distinct cm."uuid" as external_survey_id , m."MODULE_KEY" as name, m.id_campaign as campaign_id, c."EMAIL" as email, c."NAME", c."SURNAME", c."HASH" as hash
from ec.questions q
join ec.answers a on a.id_question = q."ID"
join ec.module_form_block_question mf on mf.id_question=q."ID"
join ec.module_form_block mfb on mf.id_module_form_block=mfb."id"
join ec.modules m on mfb.id_module=m."ID"
join ec.emails e on a.id_email=e."ID"
join ec.contacts c on c."ID"=e.id_contact
join external.corr_method cm on cm.id=m."ID" ;


insert into external.mig_methods_externalsurveyinvitation
with t as (
select distinct external_survey_id, name, campaign_id, c.uuid as uuid_campaign
from external.mig_external_modules_invitations i
	join external.corr_campaign c on c.id=i.campaign_id
)
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp, name , uuid_campaign
, us.id
, external_survey_id
from t
, (select id from external.mig_users_user where name='MIGRATION') us;


-------------------------------------------
-- END METHODS_ESTERNALSURVEYINVITATION ---
-------------------------------------------


-------------------------------
-- START METHODS_INVITATION ---
-------------------------------

insert into external.mig_methods_invitation
select  uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, m."NAME"||' '||m."SURNAME" as name
, case when cn.cnt>1 then m.hash||'_'||m.email else m.email end
, 1
, MD5(random()::text) as token
, us.id
, e.id
from external.mig_external_modules_invitations m
	join external.corr_campaign c on c.id=m.campaign_id
	join (select email, count(distinct m.hash) as cnt
		from external.mig_external_modules_invitations m
		group by email) cn on m.email=cn.email
join external.mig_methods_externalsurveyinvitation e on m.name=e.name and c.uuid=e.campaign_id and m.external_survey_id=e.external_survey_id
, (select id from external.mig_users_user where name='MIGRATION') us
;


-------------------------------
-- END METHODS_INVITATION ---
-------------------------------