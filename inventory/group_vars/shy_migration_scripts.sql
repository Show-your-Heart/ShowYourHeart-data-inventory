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
from external.mig_geodata_region3
where exists (
    select *
    from external.mig_users_user u
    where mig_geodata_region3.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_geodata_region2
where exists (
    select *
    from external.mig_users_user u
    where mig_geodata_region2.created_by_id=u.id
    and u.name='MIGRATION'
);


delete
from external.mig_geodata_region1
where exists (
    select *
    from external.mig_users_user u
    where mig_geodata_region1.created_by_id=u.id
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
,'Espanya' , 'Spain', 'Espanya', 'España', 'Espainia', 'España', 'Spain', 'L''Espagne'
, us.id
from (select id from external.mig_users_user where name='MIGRATION') us
;


drop table if exists external.corr_region1;
create table external.corr_region1 as
select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from ec.autonomous_community;


insert into external.mig_geodata_region1
select ca.uuid
, current_timestamp, current_timestamp
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}'
, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}'
, null
, null
, c.id
, us.id
from ec.autonomous_community q
join external.corr_region1 ca on q."ID"=ca.id
, external.mig_geodata_country c
, (select id from external.mig_users_user where name='MIGRATION') us
where c.name='Espanya';

drop table if exists external.corr_region2;
create table external.corr_region2 as
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
insert into external.mig_geodata_region2
select pr.uuid, current_timestamp, current_timestamp
,coalesce(prov, prov_es), prov, prov, prov_gl, prov_eu, prov_es, null, null, c.id, us.id, mc.id
from tb
join external.mig_geodata_region1 mc on  ccaa=mc.name
join external.corr_region2 pr on tb."ID"=pr.id
, (select id from external.mig_users_user where name='MIGRATION') us
, (select id from external.mig_geodata_country c where name='Espanya') c
;

drop table if exists external.corr_region3;
create table external.corr_region3 as
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
insert into external.mig_geodata_region3
select  r.uuid, current_timestamp, current_timestamp
,reg, reg, reg, reg_gl, reg_eu, reg_es, null
, us.id
, null
, null
, mc.id
from tb
left join external.mig_geodata_region2 mc on  prov=mc.name
join external.corr_region3 r on tb."ID"=r.id
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
town, town, town, town_gl, town_eu, town_es, null, null
, us.id
, co.id, mc.id, mr.id
from tb
join external.corr_city c on c.id=tb."ID"
left join external.mig_geodata_region2 mc on  coalesce(prov,prov_es)=mc.name
left join external.mig_geodata_region3 mr on region=mr.name
, (select id from external.mig_geodata_country c where name='Espanya') co
, (select id from external.mig_users_user where name='MIGRATION') us;


drop table external.mig_towns;

--------------------------
-- END GEODATA -----------
--------------------------

----------------------------------------
-- START GEODATA NETHERLANDS -----------
----------------------------------------

insert into external.mig_geodata_country
select  uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp
,'Netherlands' , 'Netherlands', 'Països Baixos', 'Paises Bajos', 'Paises Bajos', 'Paises Bajos', 'Netherlands', 'Pays-Bas'
, us.id
from (select id from external.mig_users_user where name='MIGRATION') us
;


with ned as (
select distinct g."Provincie code", g."Provincie name"
--, g."Gemeente code", g."Gemeente name" , c."PC4"
from external."georef-netherlands-gemeente.csv" g
left join external."georef-netherlands-postcode-pc4.csv" c on g."Gemeente code" = c."Gemeente code"
)
insert into external.mig_geodata_region2
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."Provincie name", g."Provincie name", g."Provincie name", g."Provincie name", g."Provincie name", g."Provincie name", g."Provincie name", g."Provincie name"
, c.id, us.id, null
from ned g
, (select * from external.mig_geodata_country where name='Netherlands')c
, (select id from external.mig_users_user where name='MIGRATION') us;


with ned as (
select distinct g."Provincie code", g."Provincie name"
, g."Gemeente code", g."Gemeente name"
--, c."PC4"
from external."georef-netherlands-gemeente.csv" g
left join external."georef-netherlands-postcode-pc4.csv" c on g."Gemeente code" = c."Gemeente code"
)
insert into external.mig_geodata_city
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."Gemeente name", g."Gemeente name", g."Gemeente name", g."Gemeente name", g."Gemeente name", g."Gemeente name", g."Gemeente name", g."Gemeente name"
, us.id, c.id, r.id, null
from ned g
join external.mig_geodata_region2 r on g."Provincie name"=r.name
, (select * from external.mig_geodata_country where name='Netherlands')c
, (select id from external.mig_users_user where name='MIGRATION') us;

with ned as (
select distinct g."Provincie code", g."Provincie name"
, g."Gemeente code", g."Gemeente name"
, c."PC4"
from external."georef-netherlands-gemeente.csv" g
join external."georef-netherlands-postcode-pc4.csv" c on g."Gemeente code" = c."Gemeente code"
)
insert into external.mig_geodata_zipcode
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."PC4"
, ci.id
, us.id
from ned g
join external.mig_geodata_region2 r on g."Provincie name"=r.name
join external.mig_geodata_city ci on g."Gemeente name"=ci.name
, (select * from external.mig_geodata_country where name='Netherlands')c
, (select id from external.mig_users_user where name='MIGRATION') us;

--------------------------------------
-- END GEODATA NETHERLANDS -----------
--------------------------------------


-----------------------------------
-- START GEODATA FRANCE -----------
-----------------------------------

insert into external.mig_geodata_country
select  uuid_in(md5(random()::text || random()::text)::cstring), current_timestamp, current_timestamp
,'France' , 'France', 'França', 'Francia', 'Francia', 'Francia', 'Francia', 'La France'
, us.id
from (select id from external.mig_users_user where name='MIGRATION') us
;


with fra as (
select distinct g."Code Officiel Région", g."Nom Officiel Région"
--, g."Code Officiel Département", g."Nom Officiel Département"
--, g."Code Officiel Arrondissement départemental", g."Nom Officiel Arrondissement départemental"
--, "Code Officiel EPCI", "Nom Officiel EPCI"
--, g."Code Officiel Commune", g."Nom Officiel Commune"
--, h."Code_postal"
from external."georef-france-commune.csv" g
left join external."laposte_hexasmal.csv" h on g."Code Officiel Commune"=h."Code_commune_INSEE"
)
insert into external.mig_geodata_region1
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."Nom Officiel Région", g."Nom Officiel Région", g."Nom Officiel Région", g."Nom Officiel Région", g."Nom Officiel Région", g."Nom Officiel Région", g."Nom Officiel Région", g."Nom Officiel Région"
, c.id, us.id
from fra g
, (select * from external.mig_geodata_country where name='France')c
, (select id from external.mig_users_user where name='MIGRATION') us;


with fra as (
select distinct g."Code Officiel Région", g."Nom Officiel Région"
, g."Code Officiel Département", g."Nom Officiel Département"
--, g."Code Officiel Arrondissement départemental", g."Nom Officiel Arrondissement départemental"
--, "Code Officiel EPCI", "Nom Officiel EPCI"
--, g."Code Officiel Commune", g."Nom Officiel Commune"
--, h."Code_postal"
from external."georef-france-commune.csv" g
left join external."laposte_hexasmal.csv" h on g."Code Officiel Commune"=h."Code_commune_INSEE"
)
insert into external.mig_geodata_region2
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."Nom Officiel Département", g."Nom Officiel Département", g."Nom Officiel Département", g."Nom Officiel Département", g."Nom Officiel Département", g."Nom Officiel Département", g."Nom Officiel Département", g."Nom Officiel Département"
, c.id, us.id
from fra g
join external.mig_geodata_region1 r on g."Nom Officiel Région"=r.name
, (select * from external.mig_geodata_country where name='France')c
, (select id from external.mig_users_user where name='MIGRATION') us;


with fra as (
select distinct g."Code Officiel Région", g."Nom Officiel Région"
, g."Code Officiel Département", g."Nom Officiel Département"
--, g."Code Officiel Arrondissement départemental", g."Nom Officiel Arrondissement départemental"
, "Code Officiel EPCI", "Nom Officiel EPCI"
--, g."Code Officiel Commune", g."Nom Officiel Commune"
--, h."Code_postal"
from external."georef-france-commune.csv" g
left join external."laposte_hexasmal.csv" h on g."Code Officiel Commune"=h."Code_commune_INSEE"
)
insert into external.mig_geodata_region3
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."Nom Officiel EPCI", g."Nom Officiel EPCI", g."Nom Officiel EPCI", g."Nom Officiel EPCI", g."Nom Officiel EPCI", g."Nom Officiel EPCI", g."Nom Officiel EPCI", g."Nom Officiel EPCI"
, us.id, r.id, r2.id
from fra g
join external.mig_geodata_region1 r on g."Nom Officiel Région"=r.name
join external.mig_geodata_region2 r2 on g."Nom Officiel Département"=r2.name
, (select * from external.mig_geodata_country where name='France')c
, (select id from external.mig_users_user where name='MIGRATION') us
where "Nom Officiel EPCI" is not null;


with fra as (
select distinct g."Code Officiel Région", g."Nom Officiel Région"
, g."Code Officiel Département", g."Nom Officiel Département"
--, g."Code Officiel Arrondissement départemental", g."Nom Officiel Arrondissement départemental"
, "Code Officiel EPCI", "Nom Officiel EPCI"
, g."Code Officiel Commune", g."Nom Officiel Commune"
--, h."Code_postal"
from external."georef-france-commune.csv" g
left join external."laposte_hexasmal.csv" h on g."Code Officiel Commune"=h."Code_commune_INSEE"
)
insert into external.mig_geodata_city
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."Nom Officiel Commune", g."Nom Officiel Commune", g."Nom Officiel Commune", g."Nom Officiel Commune", g."Nom Officiel Commune", g."Nom Officiel Commune", g."Nom Officiel Commune", g."Nom Officiel Commune"
, us.id,c.id, r2.id, r3.id
from fra g
left join external.mig_geodata_region2 r2 on g."Nom Officiel Département"=r2.name
left join external.mig_geodata_region3 r3 on g."Nom Officiel EPCI"=r3.name
, (select * from external.mig_geodata_country where name='France')c
, (select id from external.mig_users_user where name='MIGRATION') us
where "Nom Officiel EPCI" is not null;



with fra as (
select distinct g."Code Officiel Région", g."Nom Officiel Région"
, g."Code Officiel Département", g."Nom Officiel Département"
--, g."Code Officiel Arrondissement départemental", g."Nom Officiel Arrondissement départemental"
, "Code Officiel EPCI", "Nom Officiel EPCI"
, g."Code Officiel Commune", g."Nom Officiel Commune"
, h."Code_postal"
from external."georef-france-commune.csv" g
left join external."laposte_hexasmal.csv" h on g."Code Officiel Commune"=h."Code_commune_INSEE"
)
insert into external.mig_geodata_zipcode
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, current_timestamp, current_timestamp
, g."Code_postal"
, ci.id
, us.id
from fra g
left join external.mig_geodata_region2 r2 on g."Nom Officiel Département"=r2.name
left join external.mig_geodata_city ci on g."Nom Officiel Commune"=ci.name
, (select * from external.mig_geodata_country where name='France')c
, (select id from external.mig_users_user where name='MIGRATION') us
where "Code_postal" is not null;

-----------------------------------
-- END GEODATA FRANCE -----------
-----------------------------------

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
, null, null
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
	when (u."EMAIL" is null or u."EMAIL"='' or u."EMAIL"='-' ) and u."USERNAME" is null
		then 'No email@'||uuid_in(md5(random()::text || random()::text)::cstring)||'.org'
	when d.email is not null and d.minid<>u."ID"
		then u."ID"::varchar||'_'||coalesce("EMAIL","USERNAME")
	when u."EMAIL" is not null then u."EMAIL"
	when u."USERNAME" like '_%@%.%' and d.minid<>u."ID" then u."ID"::varchar||'_'||u."USERNAME"
	when u."USERNAME" like '_%@%.%' then u."USERNAME"
	else coalesce("EMAIL","USERNAME") end as email
from ec.user u
left join (
	select coalesce("EMAIL","USERNAME") as email, min("ID") as minid
	from ec.user
	group by coalesce("EMAIL","USERNAME")
	having count(*)>1
	) d on coalesce(u."EMAIL",u."USERNAME")=d.email;


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
, left(coalesce(e."ADDRESS", ' '),100)
, case id_bs_state when 1 then 0 when 4 then 1 when 3 then 2 when 2 then 3 end as status
, null as privacy_policy_accepted
, cy.uuid as town
--, cu.uuid as contact_id
, gc.id as country
, us.id as created_by_id
, ls.uuid as legal_structure_id
, mgc.region3_id as region
from ec.entities e
join external.corr_organization c on e."ID"=c.id
join external.corr_legalstructure ls on ls.id=e.id_legal_form  --hi ha casos que no hi son
--join external.corr_user cu on cu.id= e.id_user --hi ha casos que no hi son
left join external.corr_city cy on e.id_town=cy.id
left join external.mig_geodata_city mgc on cy.uuid=mgc.id
, external.mig_geodata_country gc
, (select id from external.mig_users_user where name='MIGRATION') us
where gc.name='Espanya'
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
select l.uuid, current_timestamp, current_timestamp, q.name, q.name, q.name, null, null, null, null, null, case when q.other_enabled =0 then false else true end, us.id
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
, ca, ca, gl, eu, es, null, null
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
--drop table if exists external.corr_indicator;
--create table external.corr_indicator as
--select "ID" as id,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
--from ec.questions;
drop table if exists external.corr_indicator;
create table external.corr_indicator as
select "QUESTION_KEY" as key,  uuid_in(md5(random()::text || random()::text)::cstring) as uuid
from (select distinct "QUESTION_KEY" from ec.questions) a;

drop table if exists external.corr_indicator_key;
create table external.corr_indicator_key as
select c.key, c.uuid, q."ID"  as id
from ec.questions q
join external.corr_indicator c on q."QUESTION_KEY" = c.key;


with
qt as (
select *,
regexp_replace(regexp_replace(regexp_replace(regexp_replace(q.name, '\t', '', 'g'), 'fórmu"la"', 'fórmula'), 'contemp"la"', 'contempla'), '\\\\"', '') as nm
, regexp_replace(regexp_replace(regexp_replace(regexp_replace(q.description, '\t', '', 'g'), 'fórmu"la"', 'fórmula'), 'contemp"la"', 'contempla'), '\\\\"', '') as descr
, row_number() over (partition by "QUESTION_KEY" order by id_campaign desc) as rn
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
, case when ca='' then es else ca end, ca, gl, eu, es, null, null
, coalesce(dca, dgl, deu, des, 'ND')
, dca, dca, dgl, deu, des,null, null
, true
, 'SC' as category -- TODO
, case "QUESTIONTYPE"
	when '' then 'S'
	when 'Boolean' then 'B'
	when 'Check' then 'CH'
	when 'Combo' then 'DR'
	when 'Date' then 'D'
	when 'Decimal' then 'DC'
	when 'Gender' then 'IG'
	when 'GenderDecimal' then 'DG'
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
	when 'Euro' then 'EH'
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
, null::jsonb
, case when t."OPTIONAL"=1 then true else false end
, coalesce(t.vca, t.ves, t.veu, t.vgl, ''), t.vca, t.vca, t.vgl, t.veu, t.ves, null, null
,  us.id
, cl.uuid list_options_id
from t
	join external.corr_indicator q on t."QUESTION_KEY" = q.key
	left join (
        select k.key, max(id_custom_list) as id_custom_list
        from ec.question_custom_list l
            join external.corr_indicator_key k on l.id_question=k.id
        group by k.key
	) li on t."QUESTION_KEY"=li.key
	left join external.corr_list cl on li.id_custom_list = cl.id
	, (select id from external.mig_users_user where name='MIGRATION') us
where t.rn=1
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
, coalesce(ca, es, gl, eu), ca, ca, gl, eu, es, null, null
, coalesce(dca, des, dgl, deu), dca, dca, dgl, deu, des, null, null
, false
, 'SC' --TODO
, case value_type
	when '' then 'S'
	when 'Boolean' then 'B'
	when 'Check' then 'CH'
	when 'Combo' then 'DR'
	when 'Date' then 'D'
	when 'Decimal' then 'DC'
	when 'Gender' then 'IG'
	when 'GenderDecimal' then 'DG'
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
	when 'Euro' then 'EH'
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
, null::jsonb
, false
, '' as message, null , null , null , null , null, null
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
, ca, ca, ca, gl, eu, es, null, null
, coalesce(dca,dgl, deu, des,'ND'), dca, dca, dgl, deu, des, null, null
, coalesce(type, 'ORG') as unit_of_analysis
, '' as documentation
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

-- Els fitxers han d'estar pujats al bucket
update external.mig_methods_method set documentation=mig_methods_method.id
from external.corr_method m
join ec.modules em on em."ID" =m.id
where m."uuid" =mig_methods_method.id
and em.guide is not null;

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
join external.corr_indicator_key ci on q.id_question=ci.id
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
--TODO revisar join amb ec.questions
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
 join external.corr_organization o on e.id_entity=o.id
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
, us.id, cm.uuid, co.uuid, null as project_id, cu.uuid
, null, null, null, null, null
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
    , a.version
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
	-- 1: dona, 0: home, 2: NB
	from (
		select 1 as id, 1 ord
		union all
		select 0, 2 ord
		union all
		select 2, 3 ord
	) a
)
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid_indicator_gender
, r.uuid as uuid_answer, r.id_answer, r.id_question, r.value_origin, r."QUESTIONTYPE" as question_type, r.id_campaign, r.id_entity, r.id_module, r.version
, unnest( (string_to_array(replace(replace(r.value_origin,'[',''),']',''),','))) as value
, unnest(string_to_array(g.gender_id,','))::int as answer_genders
from external.mig_aux_indicatorresult_results r
, genders g
where "QUESTIONTYPE" like 'Gender%';


insert into external.corr_indicatorresult
with genders as (
	select string_agg(id::text, ',' order by ord) as gender_id
	-- 1: dona, 0: home, 2: NB
	from (
		select 1 as id, 1 ord
		union all
		select 0, 2 ord
		union all
		select 2, 3 ord
	) a
)
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid_indicator_gender
, r.uuid as uuid_answer, r.id_answer, r.id_question, r.value_origin, r."QUESTIONTYPE" as question_type
, r.id_campaign, r.id_entity, r.id_module, r.version
,value_origin as value
, null as answer_genders
from external.mig_aux_indicatorresult_results r
, genders g
where "QUESTIONTYPE" not like 'Gender%';


with tab as (
select string_to_array(replace(replace(value_origin,'[',''),']',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indicatorresult
where question_type   in ('Check')
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin
from tab
)
, fin as (
select uuid_indicator_gender, '['||string_agg(l."uuid"::varchar , ',')||']' as new_val
from tab2 t
join external.corr_listitem l on t.val=l.id::text
group by uuid_indicator_gender
order by 1
)
update external.corr_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indicatorresult.uuid_indicator_gender;


with tab as (
select string_to_array(replace(replace(value_origin,'[',''),']',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indicatorresult
where question_type   in ('Combo')
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin  as new_val
from tab
)
, fin as (
select uuid_indicator_gender, l."uuid"::varchar  as new_val
from tab2 t
join external.corr_listitem l on t.val=l.id::text
order by 1
)
update external.corr_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indicatorresult.uuid_indicator_gender;

with tab as (
select string_to_array(replace(replace(replace(value_origin,'{',''),'}',''),'"',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indicatorresult
where question_type   in ('PercentageGroup')
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin
from tab
)
, fin as (
select uuid_indicator_gender
,'{'||string_agg('"'||l."uuid"::varchar||'"":'|| split_part(val,':',2) , ', ')||'}' as new_val
--split_part(val,':',1), split_part(val,':',2),*
from tab2 t
join external.corr_listitem l on split_part(val,':',1)=l.id::text
group by uuid_indicator_gender
)
update external.corr_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indicatorresult.uuid_indicator_gender;



with tab as (
select json_array_elements(value_origin::json) as elem, uuid_indicator_gender
from external.corr_indicatorresult
where question_type   in ('Sector')
--where uuid_indicator_gender='5237cd50-9475-751b-3364-c316529d4e6b'
)
, tab2 as (
select elem::json->>'sectorId' as sector, uuid_indicator_gender
, '{'||('"sectorId":"'||l."uuid"::varchar||'"}') as newsector
, elem::jsonb as elem, l."uuid"::varchar as uuid
from tab t
join external.corr_listitem l on elem::json->>'sectorId'=l.id::text
)
, fin as (
select uuid_indicator_gender, elem::jsonb || newsector::jsonb as new_val
--, elem[sector] = to_jsonb(uuid);
from tab2
)
update external.corr_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indicatorresult.uuid_indicator_gender;


with tab as (
select string_to_array(replace(replace(value_origin,'[',''),']',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indicatorresult ir
join ec.question_custom_list qcl on ir.id_question = qcl.id_question
where QUESTION_TYPE='Radio'
--and value='115'
--and id_entity =2809
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin
from tab
)
, fin as (
select uuid_indicator_gender, string_agg(l."uuid"::varchar , ',') as new_val
--split_part(val,':',1), split_part(val,':',2),*
from tab2 t
join external.corr_listitem l on split_part(val,':',1)=l.id::text
group by uuid_indicator_gender
)
update external.corr_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indicatorresult.uuid_indicator_gender;

drop table if exists external.aux_answer_version_duplicate;
create table external.aux_answer_version_duplicate as
select a.id_entity, id_question, version, max(a."ID") as id
from ec.answers  a
group by a.id_entity, id_question, version
having count(*)>1;


 drop table if exists external.aux_answer_old_version;
 create table external.aux_answer_old_version as
 select a."ID"
 from ec.answers  a
 where exists (
 	select *
 	from ec.answers b
 	where a.id_entity = b.id_entity and a.id_question = b.id_question
 	and a."version" <b."version"
 );

insert into external.mig_methods_indicatorresult
select  uuid_in(md5(random()::text || random()::text)::cstring) as id
    , current_timestamp as created_at, current_timestamp as updated_at
 	, case when question_type in ('Gender', 'GenderDecimal') then answer_genders else null end as gender_id
	, ir.value, false
 	, us.id as created_by_id
 	, i.uuid as indicator_id
 	, s.uuid as survey_id
 	--, ir.*
 from external.corr_indicatorresult ir
 	join external.corr_survey s on s. id_campaign=ir.id_campaign and  s.id_module=ir.id_module and s.id_entity=ir.id_entity
 	join external.mig_methods_survey ms on ms.id=s.uuid --TODO només els surveis que existeixen
 	join external.corr_indicator_key i on ir.id_question=i.id
 	join external.mig_methods_indicator mi on i.uuid=mi.id --TODO només els indicadors que existeixen
 	, (select id from external.mig_users_user where name='MIGRATION') us
where ir.value is not null
	--and question_type not in ('Gender', 'GenderDecimal') -- TODO
	and not exists (
		select *
		from external.aux_answer_version_duplicate d
		where d.id_entity=ir.id_entity and d.id_question=ir.id_question and d.version=ir.version and d.id=ir.id_answer
	)
	and not exists (
		select *
		from external.aux_answer_old_version o
		where o."ID"=ir.id_answer
	)
group by ir.value
 	, us.id
 	, case when question_type in ('Gender', 'GenderDecimal') then answer_genders else null end
 	, i.uuid
 	, s.uuid
 	;


---------------------------------------
-- END METHODS_INDICATORRESULT --------
---------------------------------------


--------------------------------------------------
-- START METHODS_INDICATORRESULT INDIRECT --------
--------------------------------------------------
drop table if exists external.mig_aux_indirect_indicatorresult_results;
create table external.mig_aux_indirect_indicatorresult_results as
select
 i.value_type
, iv.value
, us.id as Created_by_id
, cm."uuid" as indicator_id
, cs."uuid" as survey_id
, m.id_campaign  as id_campaign, m."ID"  as id_module, e."ID" as id_entity, e.id_user  --serveix per a tenir methods_survey
from ec.entity_module_info emi
join ec.modules m on emi.id_module = m."ID"
--join ec.campaigns c on m.id_campaign = c."ID"
join ec.indicator_value iv on emi."ID"=iv.id_module_info
join ec.indicators i on iv.id_indicator = i."ID" and m.id_campaign = i.id_campaign
join ec.entities e on emi.id_entity = e."ID"
join external.corr_survey cs on cs.id_campaign = m.id_campaign and cs.id_entity = e."ID" and cs.id_module = m."ID" and cs.id_user = e.id_user
join external.corr_indicator_indirect cm on cm.id = i."ID"
, (select id from external.mig_users_user where name='MIGRATION') us
where 1=1;

drop table if exists external.corr_indirect_indicatorresult;
create table external.corr_indirect_indicatorresult as
with genders as (
	select string_agg(id::text, ',' order by ord) as gender_id
	-- 1: dona, 0: home, 2: NB
	from (
		select 1 as id, 1 ord
		union all
		select 0, 2 ord
		union all
		select 2, 3 ord
	) a
)
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid_indicator_gender
, r.value as value_origin
, r.created_by_id
, r.indicator_id
, r.survey_id
, r.id_campaign
, r.id_module
, r.id_entity
, r.id_user
, r.value_type
, unnest( (string_to_array(replace(replace(r.value,'[',''),']',''),','))) as value
, unnest(string_to_array(g.gender_id,','))::int as answer_genders
from external.mig_aux_indirect_indicatorresult_results r
, genders g
where "value_type" like 'Gender%';


insert into external.corr_indirect_indicatorresult
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid_indicator_gender
, r.value as value_origin
, r.created_by_id
, r.indicator_id
, r.survey_id
, r.id_campaign
, r.id_module
, r.id_entity
, r.id_user
, r.value_type
, r.value as value
, null as answer_genders
from external.mig_aux_indirect_indicatorresult_results r
where "value_type" not like 'Gender%';

with tab as (
select string_to_array(replace(replace(value_origin,'[',''),']',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indirect_indicatorresult
where value_type   in ('Check')
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin
from tab
)
, fin as (
select uuid_indicator_gender, '['||string_agg(l."uuid"::varchar , ',')||']' as new_val
from tab2 t
join external.corr_listitem l on t.val=l.id::text
group by uuid_indicator_gender
order by 1
)
update external.corr_indirect_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indirect_indicatorresult.uuid_indicator_gender;



with tab as (
select string_to_array(replace(replace(value_origin,'[',''),']',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indirect_indicatorresult
where value_type   in ('Combo')
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin  as new_val
from tab
)
, fin as (
select uuid_indicator_gender, l."uuid"::varchar  as new_val
from tab2 t
join external.corr_listitem l on t.val=l.id::text
order by 1
)
update external.corr_indirect_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indirect_indicatorresult.uuid_indicator_gender;



with tab as (
select string_to_array(replace(replace(replace(value_origin,'{',''),'}',''),'"',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indirect_indicatorresult
where value_type   in ('PercentageGroup')
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin
from tab
)
, fin as (
select uuid_indicator_gender
,'{'||string_agg('"'||l."uuid"::varchar||'"":'|| split_part(val,':',2) , ', ')||'}' as new_val
--split_part(val,':',1), split_part(val,':',2),*
from tab2 t
join external.corr_listitem l on split_part(val,':',1)=l.id::text
group by uuid_indicator_gender
)
update external.corr_indirect_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indirect_indicatorresult.uuid_indicator_gender;




with tab as (
select json_array_elements(value_origin::json) as elem, uuid_indicator_gender
from external.corr_indirect_indicatorresult
where value_type   in ('Sector')
--where uuid_indicator_gender='5237cd50-9475-751b-3364-c316529d4e6b'
)
, tab2 as (
select elem::json->>'sectorId' as sector, uuid_indicator_gender
, '{'||('"sectorId":"'||l."uuid"::varchar||'"}') as newsector
, elem::jsonb as elem, l."uuid"::varchar as uuid
from tab t
join external.corr_listitem l on elem::json->>'sectorId'=l.id::text
)
, fin as (
select uuid_indicator_gender, elem::jsonb || newsector::jsonb as new_val
--, elem[sector] = to_jsonb(uuid);
from tab2
)
update external.corr_indirect_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indirect_indicatorresult.uuid_indicator_gender;

/*
--TODO falta la question custom list
with tab as (
select string_to_array(replace(replace(value_origin,'[',''),']',''),',') as val, uuid_indicator_gender, value_origin
from external.corr_indirect_indicatorresult ir
join ec.question_custom_list qcl on ir.id_question = qcl.id_question
where value_type='Radio'
--and value='115'
--and id_entity =2809
)
, tab2 as (
select unnest(val) as val, uuid_indicator_gender, value_origin
from tab
)
, fin as (
select uuid_indicator_gender, string_agg(l."uuid"::varchar , ',') as new_val
--split_part(val,':',1), split_part(val,':',2),*
from tab2 t
join external.corr_listitem l on split_part(val,':',1)=l.id::text
group by uuid_indicator_gender
)
update external.corr_indirect_indicatorresult set value=f.new_val
from fin f
where f.uuid_indicator_gender=corr_indirect_indicatorresult.uuid_indicator_gender;
*/

insert into external.mig_methods_indicatorresult
select  uuid_in(md5(random()::text || random()::text)::cstring) as id, current_timestamp as created_at, current_timestamp as updated_at
, case when i.value_type in ('Gender', 'GenderDecimal') then i.answer_genders else null end as gender_id
, i.value, false
, i.created_by_id
, i.indicator_id
, i.survey_id
from external.corr_indirect_indicatorresult i
join external.mig_methods_survey ms on i.survey_id=ms.id
where value is not null;


------------------------------------------------
-- END METHODS_INDICATORRESULT INDIRECT --------
------------------------------------------------

---------------------------------------
-- START METHODS_SECTION --------------
---------------------------------------


drop table if exists external.corr_section;
create table external.corr_section as
select uuid_in(md5(random()::text || random()::text)::cstring) as uuid, mfb.*, fb.name, fb.description
from  ec.module_form_block mfb
	join  ec.form_blocks fb on mfb.id_form_block = fb."ID";


with forms as (
select *
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "ca").text') #>> '{}'  as ca
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "gl").text') #>> '{}' as gl
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "eu").text') #>> '{}' as eu
	, jsonb_path_query(q.name::jsonb, '$.texts[*] ? (@.la == "es").text') #>> '{}' as es
from external.corr_section q
)
insert into external.mig_methods_section
select f.uuid, current_timestamp, current_timestamp, left(f.ca,60), left(f.ca,60), left(f.ca,60), left(f.gl,60), left(f.eu,60), left(f.es,60), null, null,
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
select f.uuid, current_timestamp, current_timestamp, left(f.ca,60), left(f.ca,60), left(f.ca,60), left(f.gl,60), left(f.eu,60), left(f.es,60), null, null
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
join external.corr_indicator_key ci on q.id_question=ci.id
join ec.questions qu on q.id_question=qu."ID"
where  qu."QUESTION_KEY" not in ('q1204', 'q1203', 'q1201', 'q5302', 'q5306')
group by ci.uuid, ct.uuid
)
select -row_number()over(order by induuid, topuuid), coalesce(form_block_index, row_number() over (partition by id_module order by id_form_block))
, topuuid, induuid
from t;


insert into external.mig_methods_section_indicators
with t as (
select ci.uuid as induuid, ct.uuid as topuuid, min(fb.form_block_index) as form_block_index, min(fb.id_module) as id_module, min(fb.id_form_block) as id_form_block
from ec.module_form_block_question q
join ec.module_form_block fb on q.id_module_form_block = fb.id
join ec.indicators i on i.id_question=q.id_question
join external.corr_indicator_indirect ci on i."ID"=ci.id
join external.corr_section ct on fb.id =ct.id
group by ci.uuid, ct.uuid
)
select minid-row_number()over(order by induuid, topuuid), coalesce(form_block_index, row_number() over (partition by id_module order by id_form_block))
, topuuid, induuid
from t
,(select min(id)as minid from external.mig_methods_section_indicators) a;


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


--------------------------
-- START UPDATES FILES ---
--------------------------
update external.mig_organizations_organization set logo=a.logo
from (
select co."uuid" , bol.logo
from external.bak_organization_logo bol
join external.corr_organization co on bol.id = co.id
) a
where a.uuid=mig_organizations_organization.id;

update external.mig_methods_method set documentation=a.documentation
from (
select co."uuid" , bol.documentation
from external.bak_method_documentation bol
join external.corr_method co on bol.id = co.id
) a
where a.uuid=mig_methods_method.id;


------------------------
-- END UPDATES FILES ---
------------------------