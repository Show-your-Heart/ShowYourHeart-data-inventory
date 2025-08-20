-- Al server de SYH
GRANT SELECT ON ALL TABLES IN SCHEMA public TO migration;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO migration;
CREATE VIEW seq_view_geodata_country AS SELECT nextval('geodata_country_id_seq') as seq;
CREATE VIEW seq_view_geodata_autonomouscommunity AS SELECT nextval('geodata_autonomouscommunity_id_seq') as seq;
CREATE VIEW seq_view_geodata_province AS SELECT nextval('geodata_province_id_seq') as seq;
CREATE VIEW seq_view_geodata_region AS SELECT nextval('geodata_region_id_seq') as seq;
CREATE VIEW seq_view_geodata_city AS SELECT nextval('geodata_city_id_seq') as seq;
--



-- A la bbdd DWH
drop FOREIGN TABLE if exists external.mig_seq_view_geodata_country;
CREATE FOREIGN TABLE external.mig_seq_view_geodata_country (seq bigint)
SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public',table_name 'seq_view_geodata_country');
CREATE or replace FUNCTION external.mig_seq_view_geodata_country_nextval() RETURNS bigint AS
'SELECT seq FROM external.mig_seq_view_geodata_country;' LANGUAGE SQL;


drop FOREIGN TABLE if exists external.mig_seq_view_geodata_autonomouscommunity;
CREATE FOREIGN TABLE external.mig_seq_view_geodata_autonomouscommunity (seq bigint)
SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public',table_name 'seq_view_geodata_autonomouscommunity');
CREATE or replace FUNCTION external.mig_seq_view_geodata_autonomouscommunity_nextval() RETURNS bigint AS
'SELECT seq FROM external.mig_seq_view_geodata_autonomouscommunity;' LANGUAGE SQL;



drop FOREIGN TABLE if exists external.mig_seq_view_geodata_province;
CREATE FOREIGN TABLE external.mig_seq_view_geodata_province (seq bigint)
SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public',table_name 'seq_view_geodata_province');
CREATE or replace FUNCTION external.mig_seq_view_geodata_province_nextval() RETURNS bigint AS
'SELECT seq FROM external.mig_seq_view_geodata_province;' LANGUAGE SQL;



drop FOREIGN TABLE if exists external.mig_seq_view_geodata_region;
CREATE FOREIGN TABLE external.mig_seq_view_geodata_region (seq bigint)
SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public',table_name 'seq_view_geodata_region');
CREATE or replace FUNCTION external.mig_seq_view_geodata_region_nextval() RETURNS bigint AS
'SELECT seq FROM external.mig_seq_view_geodata_region;' LANGUAGE SQL;


drop FOREIGN TABLE if exists external.mig_seq_view_geodata_city;
CREATE FOREIGN TABLE external.mig_seq_view_geodata_city (seq bigint)
SERVER postgres_fdw_syh_migration OPTIONS (schema_name 'public',table_name 'seq_view_geodata_city');
CREATE or replace FUNCTION external.mig_seq_view_geodata_city_nextval() RETURNS bigint AS
'SELECT seq FROM external.mig_seq_view_geodata_city;' LANGUAGE SQL;