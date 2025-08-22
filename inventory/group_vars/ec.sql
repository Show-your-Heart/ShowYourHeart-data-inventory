create schema ec;
IMPORT FOREIGN SCHEMA balanc_social_xes FROM SERVER mysql_fdw_ensenyaelcor INTO ec;



DROP FOREIGN TABLE ec.campaigns;

CREATE FOREIGN TABLE ec.campaigns (
	"ID" int8 NOT NULL,
	"ACTIVE" int2 NULL,
	end_date varchar NULL,
	start_date varchar NULL,
	"version" int8 NULL,
	id_previous_campaign int8 NULL,
	"name" varchar(1000) NULL,
	"year" int4 NOT NULL
)
SERVER mysql_fdw_ensenyaelcor
OPTIONS (dbname 'balanc_social_xes', table_name 'campaigns');