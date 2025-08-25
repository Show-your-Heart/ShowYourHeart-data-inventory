drop foreign table if exists external.mig_auth_group;	create FOREIGN TABLE external.mig_auth_group("id" int4 NOT NULL
	,"name" varchar(150) NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'auth_group');
drop foreign table if exists external.mig_auth_group_permissions;	create FOREIGN TABLE external.mig_auth_group_permissions("id" int4 NOT NULL
	,"group_id" int4 NOT NULL
	,"permission_id" int4 NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'auth_group_permissions');
drop foreign table if exists external.mig_auth_permission;	create FOREIGN TABLE external.mig_auth_permission("id" int4 NOT NULL
	,"name" varchar(255) NOT NULL
	,"content_type_id" int4 NOT NULL
	,"codename" varchar(100) NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'auth_permission');
drop foreign table if exists external.mig_django_admin_log;	create FOREIGN TABLE external.mig_django_admin_log("id" int4 NOT NULL
	,"action_time" timestamptz NOT NULL
	,"object_id" text
	,"object_repr" varchar(200) NOT NULL
	,"action_flag" int2 NOT NULL
	,"change_message" text NOT NULL
	,"content_type_id" int4
	,"user_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'django_admin_log');
drop foreign table if exists external.mig_django_content_type;	create FOREIGN TABLE external.mig_django_content_type("id" int4 NOT NULL
	,"app_label" varchar(100) NOT NULL
	,"model" varchar(100) NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'django_content_type');
drop foreign table if exists external.mig_django_migrations;	create FOREIGN TABLE external.mig_django_migrations("id" int4 NOT NULL
	,"app" varchar(255) NOT NULL
	,"name" varchar(255) NOT NULL
	,"applied" timestamptz NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'django_migrations');
drop foreign table if exists external.mig_django_session;	create FOREIGN TABLE external.mig_django_session("session_key" varchar(40) NOT NULL
	,"session_data" text NOT NULL
	,"expire_date" timestamptz NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'django_session');
drop foreign table if exists external.mig_extra_settings_setting;	create FOREIGN TABLE external.mig_extra_settings_setting("id" int4 NOT NULL
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
	,"validator" varchar(255))SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'extra_settings_setting');
drop foreign table if exists external.mig_geodata_autonomouscommunity;	create FOREIGN TABLE external.mig_geodata_autonomouscommunity("id" int8 NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"country_id" int8 NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'geodata_autonomouscommunity');
drop foreign table if exists external.mig_geodata_city;	create FOREIGN TABLE external.mig_geodata_city("id" int8 NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"province_id" int8
	,"region_id" int8)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'geodata_city');
drop foreign table if exists external.mig_geodata_country;	create FOREIGN TABLE external.mig_geodata_country("id" int8 NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100))SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'geodata_country');
drop foreign table if exists external.mig_geodata_province;	create FOREIGN TABLE external.mig_geodata_province("id" int8 NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"community_id" int8
	,"country_id" int8)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'geodata_province');
drop foreign table if exists external.mig_geodata_region;	create FOREIGN TABLE external.mig_geodata_region("id" int8 NOT NULL
	,"name" varchar(100) NOT NULL
	,"name_en" varchar(100)
	,"name_ca" varchar(100)
	,"name_gl" varchar(100)
	,"name_eu" varchar(100)
	,"name_es" varchar(100)
	,"name_nl" varchar(100)
	,"community_id" int8
	,"province_id" int8)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'geodata_region');
drop foreign table if exists external.mig_geodata_zipcode;	create FOREIGN TABLE external.mig_geodata_zipcode("id" int8 NOT NULL
	,"code" varchar(10) NOT NULL
	,"city_id" int8)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'geodata_zipcode');
drop foreign table if exists external.mig_methods_campaign;	create FOREIGN TABLE external.mig_methods_campaign("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(400) NOT NULL
	,"name_en" varchar(400)
	,"name_ca" varchar(400)
	,"name_gl" varchar(400)
	,"name_eu" varchar(400)
	,"name_es" varchar(400)
	,"name_nl" varchar(400)
	,"year" varchar(4) NOT NULL
	,"status" bool NOT NULL
	,"start_date" date
	,"end_date" date
	,"created_by_id" uuid
	,"previous_campaign_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_campaign');
drop foreign table if exists external.mig_methods_campaign_methods;	create FOREIGN TABLE external.mig_methods_campaign_methods("id" int4 NOT NULL
	,"campaign_id" uuid NOT NULL
	,"method_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_campaign_methods');
drop foreign table if exists external.mig_methods_externalsurveyinvitation;	create FOREIGN TABLE external.mig_methods_externalsurveyinvitation("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(400) NOT NULL
	,"campaign_id" uuid NOT NULL
	,"created_by_id" uuid
	,"external_survey_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_externalsurveyinvitation');
drop foreign table if exists external.mig_methods_indicator;	create FOREIGN TABLE external.mig_methods_indicator("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"project_id" varchar(50) NOT NULL
	,"version" varchar(4) NOT NULL
	,"name" varchar(1000) NOT NULL
	,"name_en" varchar(1000)
	,"name_ca" varchar(1000)
	,"name_gl" varchar(1000)
	,"name_eu" varchar(1000)
	,"name_es" varchar(1000)
	,"name_nl" varchar(1000)
	,"description" varchar(2500) NOT NULL
	,"description_en" varchar(2500)
	,"description_ca" varchar(2500)
	,"description_gl" varchar(2500)
	,"description_eu" varchar(2500)
	,"description_es" varchar(2500)
	,"description_nl" varchar(2500)
	,"is_direct_indicator" bool NOT NULL
	,"category" varchar NOT NULL
	,"data_type" varchar NOT NULL
	,"sub_data_type" varchar NOT NULL
	,"unit" varchar NOT NULL
	,"condition" varchar(400) NOT NULL
	,"formula" varchar(400) NOT NULL
	,"validation" varchar(50) NOT NULL
	,"message" varchar(400) NOT NULL
	,"message_en" varchar(400)
	,"message_ca" varchar(400)
	,"message_gl" varchar(400)
	,"message_eu" varchar(400)
	,"message_es" varchar(400)
	,"message_nl" varchar(400)
	,"created_by_id" uuid
	,"list_options_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_indicator');
drop foreign table if exists external.mig_methods_indicator_topics;	create FOREIGN TABLE external.mig_methods_indicator_topics("id" int4 NOT NULL
	,"indicator_id" uuid NOT NULL
	,"topic_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_indicator_topics');
drop foreign table if exists external.mig_methods_indicatorresult;	create FOREIGN TABLE external.mig_methods_indicatorresult("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"value" varchar NOT NULL
	,"created_by_id" uuid
	,"gender_id" uuid NOT NULL
	,"indicator_id" uuid NOT NULL
	,"survey_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_indicatorresult');
drop foreign table if exists external.mig_methods_invitation;	create FOREIGN TABLE external.mig_methods_invitation("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(400) NOT NULL
	,"email" varchar(255) NOT NULL
	,"status" int2 NOT NULL
	,"token" varchar(32) NOT NULL
	,"created_by_id" uuid
	,"external_survey_invitation_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_invitation');
drop foreign table if exists external.mig_methods_list;	create FOREIGN TABLE external.mig_methods_list("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"title" varchar(50) NOT NULL
	,"title_en" varchar(50)
	,"title_ca" varchar(50)
	,"title_gl" varchar(50)
	,"title_eu" varchar(50)
	,"title_es" varchar(50)
	,"title_nl" varchar(50)
	,"enable_others" bool NOT NULL
	,"created_by_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_list');
drop foreign table if exists external.mig_methods_list_items;	create FOREIGN TABLE external.mig_methods_list_items("id" int4 NOT NULL
	,"list_id" uuid NOT NULL
	,"listitem_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_list_items');
drop foreign table if exists external.mig_methods_listitem;	create FOREIGN TABLE external.mig_methods_listitem("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"title" varchar(300) NOT NULL
	,"title_en" varchar(300)
	,"title_ca" varchar(300)
	,"title_gl" varchar(300)
	,"title_eu" varchar(300)
	,"title_es" varchar(300)
	,"title_nl" varchar(300)
	,"formula" varchar(50) NOT NULL
	,"value" int2 NOT NULL
	,"active" bool NOT NULL
	,"created_by_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_listitem');
drop foreign table if exists external.mig_methods_method;	create FOREIGN TABLE external.mig_methods_method("id" uuid NOT NULL
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
	,"description" varchar(1000) NOT NULL
	,"description_en" varchar(1000)
	,"description_ca" varchar(1000)
	,"description_gl" varchar(1000)
	,"description_eu" varchar(1000)
	,"description_es" varchar(1000)
	,"description_nl" varchar(1000)
	,"unit_of_analysis" varchar(3) NOT NULL
	,"documentation" varchar(100)
	,"created_by_id" uuid
	,"network_owner_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_method');
drop foreign table if exists external.mig_methods_method_external_surveys;	create FOREIGN TABLE external.mig_methods_method_external_surveys("id" int4 NOT NULL
	,"from_method_id" uuid NOT NULL
	,"to_method_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_method_external_surveys');
drop foreign table if exists external.mig_methods_method_indicators;	create FOREIGN TABLE external.mig_methods_method_indicators("id" int4 NOT NULL
	,"method_id" uuid NOT NULL
	,"indicator_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_method_indicators');
drop foreign table if exists external.mig_methods_method_legal_structures;	create FOREIGN TABLE external.mig_methods_method_legal_structures("id" int4 NOT NULL
	,"method_id" uuid NOT NULL
	,"legalstructure_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_method_legal_structures');
drop foreign table if exists external.mig_methods_method_sectors;	create FOREIGN TABLE external.mig_methods_method_sectors("id" int4 NOT NULL
	,"method_id" uuid NOT NULL
	,"sector_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_method_sectors');
drop foreign table if exists external.mig_methods_survey;	create FOREIGN TABLE external.mig_methods_survey("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"token" varchar(32) NOT NULL
	,"status" int2 NOT NULL
	,"campaign_id" uuid NOT NULL
	,"created_by_id" uuid
	,"method_id" uuid NOT NULL
	,"organization_id" uuid NOT NULL
	,"user_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_survey');
drop foreign table if exists external.mig_methods_topic;	create FOREIGN TABLE external.mig_methods_topic("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(50) NOT NULL
	,"name_en" varchar(50)
	,"name_ca" varchar(50)
	,"name_gl" varchar(50)
	,"name_eu" varchar(50)
	,"name_es" varchar(50)
	,"name_nl" varchar(50)
	,"description" varchar(400) NOT NULL
	,"description_en" varchar(400)
	,"description_ca" varchar(400)
	,"description_gl" varchar(400)
	,"description_eu" varchar(400)
	,"description_es" varchar(400)
	,"description_nl" varchar(400)
	,"created_by_id" uuid
	,"parent_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'methods_topic');
drop foreign table if exists external.mig_organizations_organization;	create FOREIGN TABLE external.mig_organizations_organization("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(150) NOT NULL
	,"vat_number" varchar(30) NOT NULL
	,"website" varchar(300) NOT NULL
	,"status" int2 NOT NULL
	,"city_id" int8
	,"contact_id" uuid NOT NULL
	,"country_id" int8
	,"created_by_id" uuid
	,"legal_structure_id" uuid NOT NULL
	,"region_id" int8)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'organizations_organization');
drop foreign table if exists external.mig_organizations_organization_methods;	create FOREIGN TABLE external.mig_organizations_organization_methods("id" int4 NOT NULL
	,"organization_id" uuid NOT NULL
	,"method_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'organizations_organization_methods');
drop foreign table if exists external.mig_post_office_attachment;	create FOREIGN TABLE external.mig_post_office_attachment("id" int4 NOT NULL
	,"file" varchar(100) NOT NULL
	,"name" varchar(255) NOT NULL
	,"mimetype" varchar(255) NOT NULL
	,"headers" jsonb)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'post_office_attachment');
drop foreign table if exists external.mig_post_office_attachment_emails;	create FOREIGN TABLE external.mig_post_office_attachment_emails("id" int4 NOT NULL
	,"attachment_id" int4 NOT NULL
	,"email_id" int4 NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'post_office_attachment_emails');
drop foreign table if exists external.mig_post_office_email;	create FOREIGN TABLE external.mig_post_office_email("id" int4 NOT NULL
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
	,"message_id" varchar(255))SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'post_office_email');
drop foreign table if exists external.mig_post_office_emailtemplate;	create FOREIGN TABLE external.mig_post_office_emailtemplate("id" int4 NOT NULL
	,"name" varchar(255) NOT NULL
	,"description" text NOT NULL
	,"subject" varchar(255) NOT NULL
	,"content" text NOT NULL
	,"html_content" text NOT NULL
	,"created" timestamptz NOT NULL
	,"last_updated" timestamptz NOT NULL
	,"default_template_id" int4
	,"language" varchar(12) NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'post_office_emailtemplate');
drop foreign table if exists external.mig_post_office_log;	create FOREIGN TABLE external.mig_post_office_log("id" int4 NOT NULL
	,"date" timestamptz NOT NULL
	,"status" int2 NOT NULL
	,"exception_type" varchar(255) NOT NULL
	,"message" text NOT NULL
	,"email_id" int4 NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'post_office_log');
drop foreign table if exists external.mig_settings_gender;	create FOREIGN TABLE external.mig_settings_gender("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar NOT NULL
	,"created_by_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'settings_gender');
drop foreign table if exists external.mig_settings_legalstructure;	create FOREIGN TABLE external.mig_settings_legalstructure("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(50) NOT NULL
	,"name_en" varchar(50)
	,"name_ca" varchar(50)
	,"name_gl" varchar(50)
	,"name_eu" varchar(50)
	,"name_es" varchar(50)
	,"name_nl" varchar(50)
	,"created_by_id" uuid
	,"parent_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'settings_legalstructure');
drop foreign table if exists external.mig_settings_network;	create FOREIGN TABLE external.mig_settings_network("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(100) NOT NULL
	,"created_by_id" uuid
	,"network_admin_id" uuid NOT NULL
	,"parent_network_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'settings_network');
drop foreign table if exists external.mig_settings_sector;	create FOREIGN TABLE external.mig_settings_sector("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"name" varchar(150) NOT NULL
	,"name_en" varchar(150)
	,"name_ca" varchar(150)
	,"name_gl" varchar(150)
	,"name_eu" varchar(150)
	,"name_es" varchar(150)
	,"name_nl" varchar(150)
	,"created_by_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'settings_sector');
drop foreign table if exists external.mig_users_user;	create FOREIGN TABLE external.mig_users_user("password" varchar(128) NOT NULL
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
	,"created_by_id" uuid)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'users_user');
drop foreign table if exists external.mig_users_user_groups;	create FOREIGN TABLE external.mig_users_user_groups("id" int4 NOT NULL
	,"user_id" uuid NOT NULL
	,"group_id" int4 NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'users_user_groups');
drop foreign table if exists external.mig_users_user_user_permissions;	create FOREIGN TABLE external.mig_users_user_user_permissions("id" int4 NOT NULL
	,"user_id" uuid NOT NULL
	,"permission_id" int4 NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'users_user_user_permissions');
drop foreign table if exists external.mig_users_userprofile;	create FOREIGN TABLE external.mig_users_userprofile("id" uuid NOT NULL
	,"created_at" timestamptz NOT NULL
	,"updated_at" timestamptz NOT NULL
	,"telephone" varchar(20) NOT NULL
	,"created_by_id" uuid
	,"organization_id" uuid NOT NULL
	,"user_id" uuid NOT NULL)SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public', table_name 'users_userprofile');