--
----SELECT case when ordinal_position=1 then concat('drop foreign table if exists ','external.mig','_' ,c.table_name,';') else '' end AS strdrop,
----case when ordinal_position=1 then concat('create FOREIGN TABLE ','external.mig','_' ,c.table_name,'(') else '' end ||
--SELECT case when ordinal_position=1 then concat('drop foreign table if exists ','syh','_' ,c.table_name,';') else '' end AS strdrop,
--case when ordinal_position=1 then concat('create FOREIGN TABLE ','syh','_' ,c.table_name,'(') else '' end ||
--concat(
--        case when ordinal_position=1 then '' else ',' end,
--        '"',column_name,'"'
--        ' ',
--        case udt_name
--                when 'varchar' then
--                        case
--                                when character_maximum_length is not null then concat(udt_name,'(',character_maximum_length,')')
--                                else udt_name
--                        end
--                when 'numeric' then
--                        case
--                                when numeric_precision is not null  then concat(udt_name,'(',numeric_precision,',' ,numeric_scale,')' )
--                                else udt_name
--                        end
--                else udt_name
--        end,
--        case when is_nullable='NO' then ' NOT NULL' else '' end
--)
--||
----case when ordinal_position=ma.mo then concat(')SERVER postgres_fdw_syh_migration OPTIONS (schema_name ''',c.table_schema,''', table_name ''',c.table_name,''');')  else '' end as strend
--case when ordinal_position=ma.mo then concat(')SERVER postgres_fdw_syh OPTIONS (schema_name ''',c.table_schema,''', table_name ''',c.table_name,''');')  else '' end as strend
--  FROM information_schema.columns c
--        join (
--                select table_catalog, table_schema, table_name, max(ordinal_position) mo
--                FROM information_schema.columns
--                group by table_catalog, table_schema, table_name
--        ) ma on c.table_catalog =ma.table_catalog and c.table_schema =ma.table_schema and c.table_name =ma.table_name
--  where c.table_schema ='public'
--  order by c.table_catalog , c.table_schema , c.table_name, c.ordinal_position






drop foreign table if exists syh_auth_group;	create FOREIGN TABLE syh_auth_group("id" int4 NOT NULL
	,"name" varchar(150) NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'auth_group');
drop foreign table if exists syh_auth_group_permissions;	create FOREIGN TABLE syh_auth_group_permissions("id" int4 NOT NULL
	,"group_id" int4 NOT NULL
	,"permission_id" int4 NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'auth_group_permissions');
drop foreign table if exists syh_auth_permission;	create FOREIGN TABLE syh_auth_permission("id" int4 NOT NULL
	,"name" varchar(255) NOT NULL
	,"content_type_id" int4 NOT NULL
	,"codename" varchar(100) NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'auth_permission');
drop foreign table if exists syh_django_admin_log;	create FOREIGN TABLE syh_django_admin_log("id" int4 NOT NULL
	,"action_time" timestamptz NOT NULL
	,"object_id" text
	,"object_repr" varchar(200) NOT NULL
	,"action_flag" int2 NOT NULL
	,"change_message" text NOT NULL
	,"content_type_id" int4
	,"user_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'django_admin_log');
drop foreign table if exists syh_django_content_type;	create FOREIGN TABLE syh_django_content_type("id" int4 NOT NULL
	,"app_label" varchar(100) NOT NULL
	,"model" varchar(100) NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'django_content_type');
drop foreign table if exists syh_django_migrations;	create FOREIGN TABLE syh_django_migrations("id" int4 NOT NULL
	,"app" varchar(255) NOT NULL
	,"name" varchar(255) NOT NULL
	,"applied" timestamptz NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'django_migrations');
drop foreign table if exists syh_django_session;	create FOREIGN TABLE syh_django_session("session_key" varchar(40) NOT NULL
	,"session_data" text NOT NULL
	,"expire_date" timestamptz NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'django_session');
drop foreign table if exists syh_extra_settings_setting;	create FOREIGN TABLE syh_extra_settings_setting("id" int4 NOT NULL
	,"name" varchar(255) NOT NULL
	,"value_type" varchar(20) NOT NULL
	,"value_bool" bool NOT NULL
	,"value_date" date
	,"value_datetime" timestamptz
	,"value_decimal" numeric(19,10) NOT NULL
	,"value_email" varchar(254) NOT NULL
	,"value_file" varchar(100) NOT NULL
	,"value_float" float8 NOT NULL
	,"value_image" varchar(100) NOT NULL
	,"value_int" int4 NOT NULL
	,"value_string" varchar(255) NOT NULL
	,"value_text" text NOT NULL
	,"value_time" time
	,"value_url" varchar(200) NOT NULL
	,"value_duration" interval
	,"description" text
	,"value_json" text NOT NULL
	,"validator" varchar(255))SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'extra_settings_setting');
drop foreign table if exists syh_geodata_city;	create FOREIGN TABLE syh_geodata_city("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"name_fr" varchar(100)
	,"created_by_id" uuid
	,"country_id" uuid
	,"region2_id" uuid
	,"region3_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'geodata_city');
drop foreign table if exists syh_geodata_country;	create FOREIGN TABLE syh_geodata_country("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"name_fr" varchar(100)
	,"created_by_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'geodata_country');
drop foreign table if exists syh_geodata_region1;	create FOREIGN TABLE syh_geodata_region1("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"name_fr" varchar(100)
	,"country_id" uuid NOT NULL
	,"created_by_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'geodata_region1');
drop foreign table if exists syh_geodata_region2;	create FOREIGN TABLE syh_geodata_region2("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"name_fr" varchar(100)
	,"country_id" uuid
	,"created_by_id" uuid
	,"region1_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'geodata_region2');
drop foreign table if exists syh_geodata_region3;	create FOREIGN TABLE syh_geodata_region3("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"name_fr" varchar(100)
	,"created_by_id" uuid
	,"region1_id" uuid
	,"region2_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'geodata_region3');
drop foreign table if exists syh_geodata_zipcode;	create FOREIGN TABLE syh_geodata_zipcode("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"code" varchar(10) NOT NULL
	,"city_id" uuid
	,"created_by_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'geodata_zipcode');
drop foreign table if exists syh_methods_campaign;	create FOREIGN TABLE syh_methods_campaign("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(400) NOT NULL
	,"name_en" varchar(400)
	,"name_ca" varchar(400)
	,"name_gl" varchar(400)
	,"name_eu" varchar(400)
	,"name_es" varchar(400)
	,"name_nl" varchar(400)
	,"name_fr" varchar(400)
	,"year" varchar(4) NOT NULL
	,"status" bool NOT NULL
	,"start_date" date
	,"end_date" date
	,"created_by_id" uuid
	,"previous_campaign_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_campaign');
drop foreign table if exists syh_methods_campaign_methods;	create FOREIGN TABLE syh_methods_campaign_methods("id" int4 NOT NULL
	,"campaign_id" uuid NOT NULL
	,"method_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_campaign_methods');
drop foreign table if exists syh_methods_externalsurveyinvitation;	create FOREIGN TABLE syh_methods_externalsurveyinvitation("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(400) NOT NULL
	,"campaign_id" uuid NOT NULL
	,"created_by_id" uuid
	,"external_survey_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_externalsurveyinvitation');
drop foreign table if exists syh_methods_indicator;	create FOREIGN TABLE syh_methods_indicator("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"code" varchar(50) NOT NULL
	,"version" varchar(4) NOT NULL
	,"name" varchar(1000) NOT NULL
	,"name_en" varchar(1000)
	,"name_ca" varchar(1000)
	,"name_gl" varchar(1000)
	,"name_eu" varchar(1000)
	,"name_es" varchar(1000)
	,"name_nl" varchar(1000)
	,"name_fr" varchar(1000)
	,"description" varchar(2500) NOT NULL
	,"description_en" varchar(2500)
	,"description_ca" varchar(2500)
	,"description_gl" varchar(2500)
	,"description_eu" varchar(2500)
	,"description_es" varchar(2500)
	,"description_nl" varchar(2500)
	,"description_fr" varchar(2500)
	,"is_direct_indicator" bool NOT NULL
	,"category" varchar NOT NULL
	,"data_type" varchar NOT NULL
	,"unit" varchar NOT NULL
	,"condition" varchar(400) NOT NULL
	,"formula" varchar(400) NOT NULL
	,"validation" varchar(50) NOT NULL
	,"dependant_indicators" jsonb
	,"mandatory" bool NOT NULL
	,"message" varchar(400) NOT NULL
	,"message_en" varchar(400)
	,"message_ca" varchar(400)
	,"message_gl" varchar(400)
	,"message_eu" varchar(400)
	,"message_es" varchar(400)
	,"message_nl" varchar(400)
	,"message_fr" varchar(400)
	,"created_by_id" uuid
	,"list_options_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_indicator');
drop foreign table if exists syh_methods_indicator_topics;	create FOREIGN TABLE syh_methods_indicator_topics("id" int4 NOT NULL
	,"indicator_id" uuid NOT NULL
	,"topic_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_indicator_topics');
drop foreign table if exists syh_methods_indicatorresult;	create FOREIGN TABLE syh_methods_indicatorresult("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"gender" int2
	,"value" varchar NOT NULL
	,"not_applicable" bool
	,"created_by_id" uuid
	,"indicator_id" uuid NOT NULL
	,"survey_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_indicatorresult');
drop foreign table if exists syh_methods_invitation;	create FOREIGN TABLE syh_methods_invitation("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(400) NOT NULL
	,"email" varchar(255) NOT NULL
	,"status" int2 NOT NULL
	,"token" varchar(32) NOT NULL
	,"created_by_id" uuid
	,"external_survey_invitation_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_invitation');
drop foreign table if exists syh_methods_list;	create FOREIGN TABLE syh_methods_list("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"title" varchar(50) NOT NULL
	,"title_en" varchar(50)
	,"title_ca" varchar(50)
	,"title_gl" varchar(50)
	,"title_eu" varchar(50)
	,"title_es" varchar(50)
	,"title_nl" varchar(50)
	,"title_fr" varchar(50)
	,"enable_others" bool NOT NULL
	,"created_by_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_list');
drop foreign table if exists syh_methods_list_items;	create FOREIGN TABLE syh_methods_list_items("id" int4 NOT NULL
	,"list_id" uuid NOT NULL
	,"listitem_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_list_items');
drop foreign table if exists syh_methods_listitem;	create FOREIGN TABLE syh_methods_listitem("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"title" varchar(300) NOT NULL
	,"title_en" varchar(300)
	,"title_ca" varchar(300)
	,"title_gl" varchar(300)
	,"title_eu" varchar(300)
	,"title_es" varchar(300)
	,"title_nl" varchar(300)
	,"title_fr" varchar(300)
	,"formula" varchar(50) NOT NULL
	,"value" int2 NOT NULL
	,"active" bool NOT NULL
	,"created_by_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_listitem');
drop foreign table if exists syh_methods_method;	create FOREIGN TABLE syh_methods_method("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"active" bool NOT NULL
	,"name" varchar(150) NOT NULL
	,"name_en" varchar(150)
	,"name_ca" varchar(150)
	,"name_gl" varchar(150)
	,"name_eu" varchar(150)
	,"name_es" varchar(150)
	,"name_nl" varchar(150)
	,"name_fr" varchar(150)
	,"description" varchar(1000) NOT NULL
	,"description_en" varchar(1000)
	,"description_ca" varchar(1000)
	,"description_gl" varchar(1000)
	,"description_eu" varchar(1000)
	,"description_es" varchar(1000)
	,"description_nl" varchar(1000)
	,"description_fr" varchar(1000)
	,"unit_of_analysis" varchar(3) NOT NULL
	,"documentation" varchar(100)
	,"created_by_id" uuid
	,"network_owner_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_method');
drop foreign table if exists syh_methods_method_external_surveys;	create FOREIGN TABLE syh_methods_method_external_surveys("id" int4 NOT NULL
	,"from_method_id" uuid NOT NULL
	,"to_method_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_method_external_surveys');
drop foreign table if exists syh_methods_method_indicators;	create FOREIGN TABLE syh_methods_method_indicators("id" int4 NOT NULL
	,"method_id" uuid NOT NULL
	,"indicator_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_method_indicators');
drop foreign table if exists syh_methods_method_legal_structures;	create FOREIGN TABLE syh_methods_method_legal_structures("id" int4 NOT NULL
	,"method_id" uuid NOT NULL
	,"legalstructure_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_method_legal_structures');
drop foreign table if exists syh_methods_method_sectors;	create FOREIGN TABLE syh_methods_method_sectors("id" int4 NOT NULL
	,"method_id" uuid NOT NULL
	,"sector_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_method_sectors');
drop foreign table if exists syh_methods_section;	create FOREIGN TABLE syh_methods_section("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"title" varchar(60) NOT NULL
	,"title_en" varchar(60)
	,"title_ca" varchar(60)
	,"title_gl" varchar(60)
	,"title_eu" varchar(60)
	,"title_es" varchar(60)
	,"title_nl" varchar(60)
	,"title_fr" varchar(60)
	,"order" int4 NOT NULL
	,"created_by_id" uuid
	,"method_id" uuid NOT NULL
	,"parent_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_section');
drop foreign table if exists syh_methods_section_indicators;	create FOREIGN TABLE syh_methods_section_indicators("id" int4 NOT NULL
	,"sort_value" int4 NOT NULL
	,"section_id" uuid NOT NULL
	,"indicator_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_section_indicators');
drop foreign table if exists syh_methods_survey;	create FOREIGN TABLE syh_methods_survey("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"token" varchar(32) NOT NULL
	,"status" int2 NOT NULL
	,"campaign_id" uuid NOT NULL
	,"created_by_id" uuid
	,"method_id" uuid NOT NULL
	,"organization_id" uuid
	,"project_id" uuid
	,"user_id" uuid
	,"closed_date" timestamptz
	,"evaluated_date" timestamptz
	,"modified_date" timestamptz
	,"start_date" timestamptz
	,"validated_date" timestamptz)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_survey');
drop foreign table if exists syh_methods_topic;	create FOREIGN TABLE syh_methods_topic("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"name_fr" varchar(100)
	,"description" varchar(400) NOT NULL
	,"description_en" varchar(400)
	,"description_ca" varchar(400)
	,"description_gl" varchar(400)
	,"description_eu" varchar(400)
	,"description_es" varchar(400)
	,"description_nl" varchar(400)
	,"description_fr" varchar(400)
	,"created_by_id" uuid
	,"parent_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'methods_topic');
drop foreign table if exists syh_organizations_organization;	create FOREIGN TABLE syh_organizations_organization("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(150) NOT NULL
	,"logo" varchar(100)
	,"vat_number" varchar(30) NOT NULL
	,"website" varchar(300) NOT NULL
	,"address" varchar(100) NOT NULL
	,"status" int2 NOT NULL
	,"privacy_policy_accepted" timestamptz
	,"city_id" uuid
	,"country_id" uuid
	,"created_by_id" uuid
	,"legal_structure_id" uuid NOT NULL
	,"region3_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'organizations_organization');
drop foreign table if exists syh_organizations_organization_methods;	create FOREIGN TABLE syh_organizations_organization_methods("id" int4 NOT NULL
	,"organization_id" uuid NOT NULL
	,"method_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'organizations_organization_methods');
drop foreign table if exists syh_organizations_project;	create FOREIGN TABLE syh_organizations_project("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"vat_number" varchar(30) NOT NULL
	,"name" varchar(150) NOT NULL
	,"description" varchar(400) NOT NULL
	,"contact_name" varchar(150) NOT NULL
	,"contact_email" varchar(255) NOT NULL
	,"contact_telephone" varchar(20) NOT NULL
	,"main_action_scope" varchar NOT NULL
	,"secondary_action_scope" varchar NOT NULL
	,"main_legal_entity_type" varchar NOT NULL
	,"secondary_legal_entity_type" varchar NOT NULL
	,"start_date" date
	,"end_date" date
	,"publish_results" bool
	,"authorize" bool NOT NULL
	,"city_id" uuid
	,"created_by_id" uuid
	,"organization_id" uuid NOT NULL
	,"region3_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'organizations_project');
drop foreign table if exists syh_organizations_project_methods;	create FOREIGN TABLE syh_organizations_project_methods("id" int4 NOT NULL
	,"project_id" uuid NOT NULL
	,"method_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'organizations_project_methods');
drop foreign table if exists syh_post_office_attachment;	create FOREIGN TABLE syh_post_office_attachment("id" int4 NOT NULL
	,"file" varchar(100) NOT NULL
	,"name" varchar(255) NOT NULL
	,"mimetype" varchar(255) NOT NULL
	,"headers" jsonb)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'post_office_attachment');
drop foreign table if exists syh_post_office_attachment_emails;	create FOREIGN TABLE syh_post_office_attachment_emails("id" int4 NOT NULL
	,"attachment_id" int4 NOT NULL
	,"email_id" int4 NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'post_office_attachment_emails');
drop foreign table if exists syh_post_office_email;	create FOREIGN TABLE syh_post_office_email("id" int4 NOT NULL
	,"from_email" varchar(254) NOT NULL
	,"to" text NOT NULL
	,"cc" text NOT NULL
	,"bcc" text NOT NULL
	,"subject" varchar(989) NOT NULL
	,"message" text NOT NULL
	,"html_message" text NOT NULL
	,"status" int2
	,"priority" int2
	,"created" timestamptz NOT NULL
	,"last_updated" timestamptz NOT NULL
	,"scheduled_time" timestamptz
	,"headers" jsonb
	,"context" jsonb
	,"template_id" int4
	,"backend_alias" varchar(64) NOT NULL
	,"number_of_retries" int4
	,"expires_at" timestamptz
	,"message_id" varchar(255))SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'post_office_email');
drop foreign table if exists syh_post_office_emailtemplate;	create FOREIGN TABLE syh_post_office_emailtemplate("id" int4 NOT NULL
	,"name" varchar(255) NOT NULL
	,"description" text NOT NULL
	,"subject" varchar(255) NOT NULL
	,"content" text NOT NULL
	,"html_content" text NOT NULL
	,"created" timestamptz NOT NULL
	,"last_updated" timestamptz NOT NULL
	,"default_template_id" int4
	,"language" varchar(12) NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'post_office_emailtemplate');
drop foreign table if exists syh_post_office_log;	create FOREIGN TABLE syh_post_office_log("id" int4 NOT NULL
	,"date" timestamptz NOT NULL
	,"status" int2 NOT NULL
	,"exception_type" varchar(255) NOT NULL
	,"message" text NOT NULL
	,"email_id" int4 NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'post_office_log');
drop foreign table if exists syh_settings_legalstructure;	create FOREIGN TABLE syh_settings_legalstructure("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(50) NOT NULL
	,"name_en" varchar(50)
	,"name_ca" varchar(50)
	,"name_gl" varchar(50)
	,"name_eu" varchar(50)
	,"name_es" varchar(50)
	,"name_nl" varchar(50)
	,"name_fr" varchar(50)
	,"created_by_id" uuid
	,"parent_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'settings_legalstructure');
drop foreign table if exists syh_settings_network;	create FOREIGN TABLE syh_settings_network("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"created_by_id" uuid
	,"network_admin_id" uuid NOT NULL
	,"parent_network_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'settings_network');
drop foreign table if exists syh_settings_sector;	create FOREIGN TABLE syh_settings_sector("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(150) NOT NULL
	,"name_en" varchar(150)
	,"name_ca" varchar(150)
	,"name_gl" varchar(150)
	,"name_eu" varchar(150)
	,"name_es" varchar(150)
	,"name_nl" varchar(150)
	,"name_fr" varchar(150)
	,"created_by_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'settings_sector');
drop foreign table if exists syh_users_user;	create FOREIGN TABLE syh_users_user("password" varchar(128) NOT NULL
	,"last_login" timestamptz
	,"is_superuser" bool NOT NULL
	,"id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"surnames" varchar(100) NOT NULL
	,"email" varchar(255) NOT NULL
	,"email_verification_code" varchar NOT NULL
	,"email_verified" bool NOT NULL
	,"is_active" bool NOT NULL
	,"is_staff" bool NOT NULL
	,"created_by_id" uuid)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'users_user');
drop foreign table if exists syh_users_user_groups;	create FOREIGN TABLE syh_users_user_groups("id" int4 NOT NULL
	,"user_id" uuid NOT NULL
	,"group_id" int4 NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'users_user_groups');
drop foreign table if exists syh_users_user_user_permissions;	create FOREIGN TABLE syh_users_user_user_permissions("id" int4 NOT NULL
	,"user_id" uuid NOT NULL
	,"permission_id" int4 NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'users_user_user_permissions');
drop foreign table if exists syh_users_userprofile;	create FOREIGN TABLE syh_users_userprofile("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"telephone" varchar(20) NOT NULL
	,"created_by_id" uuid
	,"organization_id" uuid NOT NULL
	,"user_id" uuid NOT NULL)SERVER postgres_fdw_syh OPTIONS (schema_name 'public', table_name 'users_userprofile');