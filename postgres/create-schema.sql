CREATE SCHEMA IF NOT EXISTS dawa_replication;
CREATE TABLE dawa_replication.transactions(
  txid integer PRIMARY KEY,
  ts timestamptz);
CREATE TABLE dawa_replication.source_transactions(
  source_txid integer,
  local_txid integer NOT NULL,
  entity text NOT NULL,
  type text NOT NULL,
  PRIMARY KEY (source_txid, entity));
CREATE TYPE dawa_replication.operation_type AS ENUM ('insert', 'update', 'delete');
create table adgangsadresse(
id uuid,
status integer,
oprettet timestamp,
ændret timestamp,
ikrafttrædelsesdato timestamp,
kommunekode text,
vejkode text,
husnr text,
supplerendebynavn text,
postnr text,
ejerlavkode integer,
matrikelnr text,
esrejendomsnr text,
etrs89koordinat_øst double precision,
etrs89koordinat_nord double precision,
nøjagtighed text,
kilde integer,
husnummerkilde integer,
tekniskstandard text,
tekstretning double precision,
adressepunktændringsdato timestamp,
esdhreference text,
journalnummer text,
højde double precision,
adgangspunktid uuid,
supplerendebynavn_dagi_id text,
vejpunkt_id uuid,
navngivenvej_id uuid,
PRIMARY KEY(id)
);
CREATE TABLE adgangsadresse_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, adgangsadresse.* FROM adgangsadresse WHERE false);
CREATE INDEX ON adgangsadresse_changes(txid);
CREATE INDEX ON adgangsadresse_changes(id);


create table adresse(
id uuid,
status integer,
oprettet timestamp,
ændret timestamp,
ikrafttrædelsesdato timestamp,
adgangsadresseid uuid,
etage text,
dør text,
kilde integer,
esdhreference text,
journalnummer text,
PRIMARY KEY(id)
);
CREATE TABLE adresse_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, adresse.* FROM adresse WHERE false);
CREATE INDEX ON adresse_changes(txid);
CREATE INDEX ON adresse_changes(id);


create table afstemningsomraade(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nummer text,
navn text,
afstemningsstednavn text,
afstemningsstedadresse text,
kommunekode text,
opstillingskreds_dagi_id text,
PRIMARY KEY(kommunekode, nummer)
);
CREATE TABLE afstemningsomraade_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, afstemningsomraade.* FROM afstemningsomraade WHERE false);
CREATE INDEX ON afstemningsomraade_changes(txid);
CREATE INDEX ON afstemningsomraade_changes(kommunekode,nummer);
create table afstemningsomraadetilknytning(
adgangsadresseid uuid,
kommunekode text,
afstemningsområdenummer text,
PRIMARY KEY(adgangsadresseid, kommunekode, afstemningsområdenummer)
);
CREATE TABLE afstemningsomraadetilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, afstemningsomraadetilknytning.* FROM afstemningsomraadetilknytning WHERE false);
CREATE INDEX ON afstemningsomraadetilknytning_changes(txid);
CREATE INDEX ON afstemningsomraadetilknytning_changes(adgangsadresseid,kommunekode,afstemningsområdenummer);
create table brofasthed(
stedid uuid,
brofast boolean,
PRIMARY KEY(stedid)
);
CREATE TABLE brofasthed_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, brofasthed.* FROM brofasthed WHERE false);
CREATE INDEX ON brofasthed_changes(txid);
CREATE INDEX ON brofasthed_changes(stedid);
create table bygning(
id text,
bygningstype text,
metode3d text,
målested text,
bbrbygning_id uuid,
synlig boolean,
overlap boolean,
geometri geometry(geometryz, 25832),
PRIMARY KEY(id)
);
CREATE TABLE bygning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, bygning.* FROM bygning WHERE false);
CREATE INDEX ON bygning_changes(txid);
CREATE INDEX ON bygning_changes(id);
create table bygningtilknytning(
bygningid integer,
adgangsadresseid uuid,
PRIMARY KEY(bygningid, adgangsadresseid)
);
CREATE TABLE bygningtilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, bygningtilknytning.* FROM bygningtilknytning WHERE false);
CREATE INDEX ON bygningtilknytning_changes(txid);
CREATE INDEX ON bygningtilknytning_changes(bygningid,adgangsadresseid);
create table dagi_postnummer(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nr text,
navn text,
PRIMARY KEY(nr)
);
CREATE TABLE dagi_postnummer_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dagi_postnummer.* FROM dagi_postnummer WHERE false);
CREATE INDEX ON dagi_postnummer_changes(txid);
CREATE INDEX ON dagi_postnummer_changes(nr);
create table dar_adresse_aktuel(
id uuid,
status integer,
dørbetegnelse text,
dørpunkt_id uuid,
etagebetegnelse text,
fk_bbr_bygning_bygning uuid,
husnummer_id uuid,
PRIMARY KEY(id)
);
CREATE TABLE dar_adresse_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_adresse_aktuel.* FROM dar_adresse_aktuel WHERE false);
CREATE INDEX ON dar_adresse_aktuel_changes(txid);
CREATE INDEX ON dar_adresse_aktuel_changes(id);
create table dar_adresse_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
dørbetegnelse text,
dørpunkt_id uuid,
etagebetegnelse text,
fk_bbr_bygning_bygning uuid,
husnummer_id uuid,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_adresse_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_adresse_historik.* FROM dar_adresse_historik WHERE false);
CREATE INDEX ON dar_adresse_historik_changes(txid);
CREATE INDEX ON dar_adresse_historik_changes(rowkey);
create table dar_adressepunkt_aktuel(
id uuid,
status integer,
oprindelse_kilde text,
oprindelse_nøjagtighedsklasse text,
oprindelse_registrering timestamptz,
oprindelse_tekniskstandard text,
position geometry(point, 25832),
PRIMARY KEY(id)
);
CREATE TABLE dar_adressepunkt_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_adressepunkt_aktuel.* FROM dar_adressepunkt_aktuel WHERE false);
CREATE INDEX ON dar_adressepunkt_aktuel_changes(txid);
CREATE INDEX ON dar_adressepunkt_aktuel_changes(id);
create table dar_adressepunkt_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
oprindelse_kilde text,
oprindelse_nøjagtighedsklasse text,
oprindelse_registrering timestamptz,
oprindelse_tekniskstandard text,
position geometry(point, 25832),
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_adressepunkt_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_adressepunkt_historik.* FROM dar_adressepunkt_historik WHERE false);
CREATE INDEX ON dar_adressepunkt_historik_changes(txid);
CREATE INDEX ON dar_adressepunkt_historik_changes(rowkey);
create table dar_darafstemningsomraade_aktuel(
id uuid,
status integer,
afstemningsområde text,
afstemningsområdenummer integer,
navn text,
PRIMARY KEY(id)
);
CREATE TABLE dar_darafstemningsomraade_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darafstemningsomraade_aktuel.* FROM dar_darafstemningsomraade_aktuel WHERE false);
CREATE INDEX ON dar_darafstemningsomraade_aktuel_changes(txid);
CREATE INDEX ON dar_darafstemningsomraade_aktuel_changes(id);
create table dar_darafstemningsomraade_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
afstemningsområde text,
afstemningsområdenummer integer,
navn text,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_darafstemningsomraade_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darafstemningsomraade_historik.* FROM dar_darafstemningsomraade_historik WHERE false);
CREATE INDEX ON dar_darafstemningsomraade_historik_changes(txid);
CREATE INDEX ON dar_darafstemningsomraade_historik_changes(rowkey);
create table dar_darkommuneinddeling_aktuel(
id uuid,
status integer,
kommuneinddeling text,
kommunekode text,
navn text,
PRIMARY KEY(id)
);
CREATE TABLE dar_darkommuneinddeling_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darkommuneinddeling_aktuel.* FROM dar_darkommuneinddeling_aktuel WHERE false);
CREATE INDEX ON dar_darkommuneinddeling_aktuel_changes(txid);
CREATE INDEX ON dar_darkommuneinddeling_aktuel_changes(id);
create table dar_darkommuneinddeling_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
kommuneinddeling text,
kommunekode text,
navn text,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_darkommuneinddeling_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darkommuneinddeling_historik.* FROM dar_darkommuneinddeling_historik WHERE false);
CREATE INDEX ON dar_darkommuneinddeling_historik_changes(txid);
CREATE INDEX ON dar_darkommuneinddeling_historik_changes(rowkey);
create table dar_darmenighedsraadsafstemningsomraade_aktuel(
id uuid,
status integer,
mrafstemningsområde text,
mrafstemningsområdenummer integer,
navn text,
PRIMARY KEY(id)
);
CREATE TABLE dar_darmenighedsraadsafstemningsomraade_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darmenighedsraadsafstemningsomraade_aktuel.* FROM dar_darmenighedsraadsafstemningsomraade_aktuel WHERE false);
CREATE INDEX ON dar_darmenighedsraadsafstemningsomraade_aktuel_changes(txid);
CREATE INDEX ON dar_darmenighedsraadsafstemningsomraade_aktuel_changes(id);
create table dar_darmenighedsraasafstemningsomraade_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
mrafstemningsområde text,
mrafstemningsområdenummer integer,
navn text,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_darmenighedsraasafstemningsomraade_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darmenighedsraasafstemningsomraade_historik.* FROM dar_darmenighedsraasafstemningsomraade_historik WHERE false);
CREATE INDEX ON dar_darmenighedsraasafstemningsomraade_historik_changes(txid);
CREATE INDEX ON dar_darmenighedsraasafstemningsomraade_historik_changes(rowkey);
create table dar_darsogneinddeling_aktuel(
id uuid,
status integer,
navn text,
sogneinddeling text,
sognekode text,
PRIMARY KEY(id)
);
CREATE TABLE dar_darsogneinddeling_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darsogneinddeling_aktuel.* FROM dar_darsogneinddeling_aktuel WHERE false);
CREATE INDEX ON dar_darsogneinddeling_aktuel_changes(txid);
CREATE INDEX ON dar_darsogneinddeling_aktuel_changes(id);
create table dar_darsogneinddeling_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navn text,
sogneinddeling text,
sognekode text,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_darsogneinddeling_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_darsogneinddeling_historik.* FROM dar_darsogneinddeling_historik WHERE false);
CREATE INDEX ON dar_darsogneinddeling_historik_changes(txid);
CREATE INDEX ON dar_darsogneinddeling_historik_changes(rowkey);
create table dar_husnummer_aktuel(
id uuid,
status integer,
adgangspunkt_id uuid,
darafstemningsområde_id uuid,
darkommune_id uuid,
darmenighedsrådsafstemningsområde_id uuid,
darsogneinddeling_id uuid,
fk_bbr_bygning_adgangtilbygning text,
fk_bbr_tekniskanlæg_adgangtiltekniskanlæg text,
fk_geodk_bygning_geodanmarkbygning text,
fk_geodk_vejmidte_vejmidte text,
fk_mu_jordstykke_foreløbigtplaceretpåjordstykke text,
fk_mu_jordstykke_jordstykke text,
husnummerretning geometry(point, 25832),
husnummertekst text,
navngivenvej_id uuid,
postnummer_id uuid,
supplerendebynavn_id uuid,
vejpunkt_id uuid,
PRIMARY KEY(id)
);
CREATE TABLE dar_husnummer_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_husnummer_aktuel.* FROM dar_husnummer_aktuel WHERE false);
CREATE INDEX ON dar_husnummer_aktuel_changes(txid);
CREATE INDEX ON dar_husnummer_aktuel_changes(id);
create table dar_husnummer_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
adgangspunkt_id uuid,
darafstemningsområde_id uuid,
darkommune_id uuid,
darmenighedsrådsafstemningsområde_id uuid,
darsogneinddeling_id uuid,
fk_bbr_bygning_adgangtilbygning text,
fk_bbr_tekniskanlæg_adgangtiltekniskanlæg text,
fk_geodk_bygning_geodanmarkbygning text,
fk_geodk_vejmidte_vejmidte text,
fk_mu_jordstykke_foreløbigtplaceretpåjordstykke text,
fk_mu_jordstykke_jordstykke text,
husnummerretning geometry(point, 25832),
husnummertekst text,
navngivenvej_id uuid,
postnummer_id uuid,
supplerendebynavn_id uuid,
vejpunkt_id uuid,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_husnummer_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_husnummer_historik.* FROM dar_husnummer_historik WHERE false);
CREATE INDEX ON dar_husnummer_historik_changes(txid);
CREATE INDEX ON dar_husnummer_historik_changes(rowkey);
create table dar_navngivenvej_aktuel(
id uuid,
status integer,
administreresafkommune text,
beskrivelse text,
retskrivningskontrol text,
udtaltvejnavn text,
vejadresseringsnavn text,
vejnavn text,
vejnavnebeliggenhed_oprindelse_kilde text,
vejnavnebeliggenhed_oprindelse_nøjagtighedsklasse text,
vejnavnebeliggenhed_oprindelse_registrering timestamptz,
vejnavnebeliggenhed_oprindelse_tekniskstandard text,
vejnavnebeliggenhed_vejnavnelinje geometry(geometry, 25832),
vejnavnebeliggenhed_vejnavneområde geometry(geometry, 25832),
vejnavnebeliggenhed_vejtilslutningspunkter geometry(geometry, 25832),
PRIMARY KEY(id)
);
CREATE TABLE dar_navngivenvej_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvej_aktuel.* FROM dar_navngivenvej_aktuel WHERE false);
CREATE INDEX ON dar_navngivenvej_aktuel_changes(txid);
CREATE INDEX ON dar_navngivenvej_aktuel_changes(id);
create table dar_navngivenvej_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
administreresafkommune text,
beskrivelse text,
retskrivningskontrol text,
udtaltvejnavn text,
vejadresseringsnavn text,
vejnavn text,
vejnavnebeliggenhed_oprindelse_kilde text,
vejnavnebeliggenhed_oprindelse_nøjagtighedsklasse text,
vejnavnebeliggenhed_oprindelse_registrering timestamptz,
vejnavnebeliggenhed_oprindelse_tekniskstandard text,
vejnavnebeliggenhed_vejnavnelinje geometry(geometry, 25832),
vejnavnebeliggenhed_vejnavneområde geometry(geometry, 25832),
vejnavnebeliggenhed_vejtilslutningspunkter geometry(geometry, 25832),
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_navngivenvej_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvej_historik.* FROM dar_navngivenvej_historik WHERE false);
CREATE INDEX ON dar_navngivenvej_historik_changes(txid);
CREATE INDEX ON dar_navngivenvej_historik_changes(rowkey);
create table dar_navngivenvejkommunedel_aktuel(
id uuid,
status integer,
kommune text,
navngivenvej_id uuid,
vejkode text,
PRIMARY KEY(id)
);
CREATE TABLE dar_navngivenvejkommunedel_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvejkommunedel_aktuel.* FROM dar_navngivenvejkommunedel_aktuel WHERE false);
CREATE INDEX ON dar_navngivenvejkommunedel_aktuel_changes(txid);
CREATE INDEX ON dar_navngivenvejkommunedel_aktuel_changes(id);
create table dar_navngivenvejkommunedel_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
kommune text,
navngivenvej_id uuid,
vejkode text,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_navngivenvejkommunedel_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvejkommunedel_historik.* FROM dar_navngivenvejkommunedel_historik WHERE false);
CREATE INDEX ON dar_navngivenvejkommunedel_historik_changes(txid);
CREATE INDEX ON dar_navngivenvejkommunedel_historik_changes(rowkey);


create table dar_navngivenvejpostnummerrelation_aktuel(
id uuid,
status integer,
navngivenvej_id uuid,
postnummer_id uuid,
PRIMARY KEY(id)
);
CREATE TABLE dar_navngivenvejpostnummerrelation_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvejpostnummerrelation_aktuel.* FROM dar_navngivenvejpostnummerrelation_aktuel WHERE false);
CREATE INDEX ON dar_navngivenvejpostnummerrelation_aktuel_changes(txid);
CREATE INDEX ON dar_navngivenvejpostnummerrelation_aktuel_changes(id);


create table dar_navngivenvejpostnummerrelation_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navngivenvej_id uuid,
postnummer_id uuid,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_navngivenvejpostnummerrelation_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvejpostnummerrelation_historik.* FROM dar_navngivenvejpostnummerrelation_historik WHERE false);
CREATE INDEX ON dar_navngivenvejpostnummerrelation_historik_changes(txid);
CREATE INDEX ON dar_navngivenvejpostnummerrelation_historik_changes(rowkey);


create table dar_navngivenvejsupplerendebynavnrelation_aktuel(
id uuid,
status integer,
navngivenvej_id uuid,
supplerendebynavn_id uuid,
PRIMARY KEY(id)
);
CREATE TABLE dar_navngivenvejsupplerendebynavnrelation_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvejsupplerendebynavnrelation_aktuel.* FROM dar_navngivenvejsupplerendebynavnrelation_aktuel WHERE false);
CREATE INDEX ON dar_navngivenvejsupplerendebynavnrelation_aktuel_changes(txid);
CREATE INDEX ON dar_navngivenvejsupplerendebynavnrelation_aktuel_changes(id);


create table dar_navngivenvejsupplerendebynavnrelation_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navngivenvej_id uuid,
supplerendebynavn_id uuid,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_navngivenvejsupplerendebynavnrelation_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_navngivenvejsupplerendebynavnrelation_historik.* FROM dar_navngivenvejsupplerendebynavnrelation_historik WHERE false);
CREATE INDEX ON dar_navngivenvejsupplerendebynavnrelation_historik_changes(txid);
CREATE INDEX ON dar_navngivenvejsupplerendebynavnrelation_historik_changes(rowkey);


create table dar_postnummer_aktuel(
id uuid,
status integer,
navn text,
postnr integer,
postnummerinddeling integer,
PRIMARY KEY(id)
);
CREATE TABLE dar_postnummer_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_postnummer_aktuel.* FROM dar_postnummer_aktuel WHERE false);
CREATE INDEX ON dar_postnummer_aktuel_changes(txid);
CREATE INDEX ON dar_postnummer_aktuel_changes(id);
create table dar_postnummer_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navn text,
postnr integer,
postnummerinddeling integer,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_postnummer_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_postnummer_historik.* FROM dar_postnummer_historik WHERE false);
CREATE INDEX ON dar_postnummer_historik_changes(txid);
CREATE INDEX ON dar_postnummer_historik_changes(rowkey);
create table dar_reserveretvejnavn_aktuel(
id uuid,
status integer,
navneområde text,
reservationudløbsdato timestamptz,
reserveretafkommune text,
reserveretnavn text,
reserveretudtaltnavn text,
reserveretvejadresseringsnavn text,
retskrivningskontrol text,
PRIMARY KEY(id)
);
CREATE TABLE dar_reserveretvejnavn_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_reserveretvejnavn_aktuel.* FROM dar_reserveretvejnavn_aktuel WHERE false);
CREATE INDEX ON dar_reserveretvejnavn_aktuel_changes(txid);
CREATE INDEX ON dar_reserveretvejnavn_aktuel_changes(id);
create table dar_reserveretvejnavn_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navneområde text,
reservationudløbsdato timestamptz,
reserveretafkommune text,
reserveretnavn text,
reserveretudtaltnavn text,
reserveretvejadresseringsnavn text,
retskrivningskontrol text,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_reserveretvejnavn_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_reserveretvejnavn_historik.* FROM dar_reserveretvejnavn_historik WHERE false);
CREATE INDEX ON dar_reserveretvejnavn_historik_changes(txid);
CREATE INDEX ON dar_reserveretvejnavn_historik_changes(rowkey);
create table dar_supplerendebynavn_aktuel(
id uuid,
status integer,
navn text,
supplerendebynavn1 text,
PRIMARY KEY(id)
);
CREATE TABLE dar_supplerendebynavn_aktuel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_supplerendebynavn_aktuel.* FROM dar_supplerendebynavn_aktuel WHERE false);
CREATE INDEX ON dar_supplerendebynavn_aktuel_changes(txid);
CREATE INDEX ON dar_supplerendebynavn_aktuel_changes(id);
create table dar_supplerendebynavn_historik(
rowkey integer,
virkningstart timestamptz,
virkningslut timestamptz,
id uuid,
status integer,
navn text,
supplerendebynavn1 text,
PRIMARY KEY(rowkey)
);
CREATE TABLE dar_supplerendebynavn_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, dar_supplerendebynavn_historik.* FROM dar_supplerendebynavn_historik WHERE false);
CREATE INDEX ON dar_supplerendebynavn_historik_changes(txid);
CREATE INDEX ON dar_supplerendebynavn_historik_changes(rowkey);
create table ejerlav(
kode integer,
navn text,
geo_version integer,
geo_ændret timestamptz,
ændret timestamptz,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
PRIMARY KEY(kode)
);
CREATE TABLE ejerlav_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, ejerlav.* FROM ejerlav WHERE false);
CREATE INDEX ON ejerlav_changes(txid);
CREATE INDEX ON ejerlav_changes(kode);
create table hoejde(
husnummerid uuid,
højde double precision,
PRIMARY KEY(husnummerid)
);
CREATE TABLE hoejde_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, hoejde.* FROM hoejde WHERE false);
CREATE INDEX ON hoejde_changes(txid);
CREATE INDEX ON hoejde_changes(husnummerid);
create table ikke_brofast_husnummer(
husnummerid uuid,
PRIMARY KEY(husnummerid)
);
CREATE TABLE ikke_brofast_husnummer_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, ikke_brofast_husnummer.* FROM ikke_brofast_husnummer WHERE false);
CREATE INDEX ON ikke_brofast_husnummer_changes(txid);
CREATE INDEX ON ikke_brofast_husnummer_changes(husnummerid);
create table jordstykke(
ejerlavkode integer,
matrikelnr text,
kommunekode text,
regionskode text,
sognekode text,
retskredskode text,
esrejendomsnr text,
udvidet_esrejendomsnr text,
sfeejendomsnr text,
bfenummer integer,
geometri geometry(geometry, 25832),
featureid text,
fælleslod boolean,
moderjordstykke integer,
registreretareal integer,
arealberegningsmetode text,
vejareal integer,
vejarealberegningsmetode text,
vandarealberegningsmetode text,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
PRIMARY KEY(ejerlavkode, matrikelnr)
);
CREATE TABLE jordstykke_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, jordstykke.* FROM jordstykke WHERE false);
CREATE INDEX ON jordstykke_changes(txid);
CREATE INDEX ON jordstykke_changes(ejerlavkode,matrikelnr);
create table jordstykketilknytning(
ejerlavkode integer,
matrikelnr text,
adgangsadresseid uuid,
PRIMARY KEY(ejerlavkode, matrikelnr, adgangsadresseid)
);
CREATE TABLE jordstykketilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, jordstykketilknytning.* FROM jordstykketilknytning WHERE false);
CREATE INDEX ON jordstykketilknytning_changes(txid);
CREATE INDEX ON jordstykketilknytning_changes(ejerlavkode,matrikelnr,adgangsadresseid);
create table kommune(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
regionskode text,
udenforkommuneinddeling boolean,
PRIMARY KEY(kode)
);
CREATE TABLE kommune_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, kommune.* FROM kommune WHERE false);
CREATE INDEX ON kommune_changes(txid);
CREATE INDEX ON kommune_changes(kode);
create table kommunetilknytning(
adgangsadresseid uuid,
kommunekode text,
PRIMARY KEY(adgangsadresseid, kommunekode)
);
CREATE TABLE kommunetilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, kommunetilknytning.* FROM kommunetilknytning WHERE false);
CREATE INDEX ON kommunetilknytning_changes(txid);
CREATE INDEX ON kommunetilknytning_changes(adgangsadresseid,kommunekode);
create table landpostnummer(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
nr text,
navn text,
PRIMARY KEY(nr)
);
CREATE TABLE landpostnummer_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, landpostnummer.* FROM landpostnummer WHERE false);
CREATE INDEX ON landpostnummer_changes(txid);
CREATE INDEX ON landpostnummer_changes(nr);
create table landsdel(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
nuts3 text,
dagi_id text,
navn text,
regionskode text,
PRIMARY KEY(nuts3)
);
CREATE TABLE landsdel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, landsdel.* FROM landsdel WHERE false);
CREATE INDEX ON landsdel_changes(txid);
CREATE INDEX ON landsdel_changes(nuts3);
create table landsdelstilknytning(
adgangsadresseid uuid,
nuts3 text,
PRIMARY KEY(adgangsadresseid, nuts3)
);
CREATE TABLE landsdelstilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, landsdelstilknytning.* FROM landsdelstilknytning WHERE false);
CREATE INDEX ON landsdelstilknytning_changes(txid);
CREATE INDEX ON landsdelstilknytning_changes(adgangsadresseid,nuts3);
create table menighedsraadsafstemningsomraade(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nummer text,
navn text,
afstemningsstednavn text,
kommunekode text,
sognekode text,
PRIMARY KEY(kommunekode, nummer)
);
CREATE TABLE menighedsraadsafstemningsomraade_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, menighedsraadsafstemningsomraade.* FROM menighedsraadsafstemningsomraade WHERE false);
CREATE INDEX ON menighedsraadsafstemningsomraade_changes(txid);
CREATE INDEX ON menighedsraadsafstemningsomraade_changes(kommunekode,nummer);
create table menighedsraadsafstemningsomraadetilknytning(
adgangsadresseid uuid,
kommunekode text,
menighedsrådsafstemningsområdenummer text,
PRIMARY KEY(adgangsadresseid, kommunekode, menighedsrådsafstemningsområdenummer)
);
CREATE TABLE menighedsraadsafstemningsomraadetilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, menighedsraadsafstemningsomraadetilknytning.* FROM menighedsraadsafstemningsomraadetilknytning WHERE false);
CREATE INDEX ON menighedsraadsafstemningsomraadetilknytning_changes(txid);
CREATE INDEX ON menighedsraadsafstemningsomraadetilknytning_changes(adgangsadresseid,kommunekode,menighedsrådsafstemningsområdenummer);
create table navngivenvej(
id uuid,
darstatus text,
oprettet timestamptz,
ændret timestamptz,
navn text,
adresseringsnavn text,
administrerendekommune text,
beskrivelse text,
retskrivningskontrol text,
udtaltvejnavn text,
beliggenhed_oprindelse_kilde text,
beliggenhed_oprindelse_nøjagtighedsklasse text,
beliggenhed_oprindelse_registrering timestamptz,
beliggenhed_oprindelse_tekniskstandard text,
PRIMARY KEY(id)
);
CREATE TABLE navngivenvej_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, navngivenvej.* FROM navngivenvej WHERE false);
CREATE INDEX ON navngivenvej_changes(txid);
CREATE INDEX ON navngivenvej_changes(id);
create table opstillingskreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
nummer text,
kode text,
navn text,
valgkredsnummer text,
storkredsnummer text,
kredskommunekode text,
PRIMARY KEY(kode)
);
CREATE TABLE opstillingskreds_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, opstillingskreds.* FROM opstillingskreds WHERE false);
CREATE INDEX ON opstillingskreds_changes(txid);
CREATE INDEX ON opstillingskreds_changes(kode);
create table opstillingskredstilknytning(
adgangsadresseid uuid,
opstillingskredskode text,
PRIMARY KEY(adgangsadresseid, opstillingskredskode)
);
CREATE TABLE opstillingskredstilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, opstillingskredstilknytning.* FROM opstillingskredstilknytning WHERE false);
CREATE INDEX ON opstillingskredstilknytning_changes(txid);
CREATE INDEX ON opstillingskredstilknytning_changes(adgangsadresseid,opstillingskredskode);
create table politikreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
PRIMARY KEY(kode)
);
CREATE TABLE politikreds_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, politikreds.* FROM politikreds WHERE false);
CREATE INDEX ON politikreds_changes(txid);
CREATE INDEX ON politikreds_changes(kode);
create table politikredstilknytning(
adgangsadresseid uuid,
politikredskode text,
PRIMARY KEY(adgangsadresseid, politikredskode)
);
CREATE TABLE politikredstilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, politikredstilknytning.* FROM politikredstilknytning WHERE false);
CREATE INDEX ON politikredstilknytning_changes(txid);
CREATE INDEX ON politikredstilknytning_changes(adgangsadresseid,politikredskode);
create table postnummer(
nr text,
navn text,
stormodtager boolean,
PRIMARY KEY(nr)
);
CREATE TABLE postnummer_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, postnummer.* FROM postnummer WHERE false);
CREATE INDEX ON postnummer_changes(txid);
CREATE INDEX ON postnummer_changes(nr);
create table postnummertilknytning(
adgangsadresseid uuid,
postnummer text,
PRIMARY KEY(adgangsadresseid, postnummer)
);
CREATE TABLE postnummertilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, postnummertilknytning.* FROM postnummertilknytning WHERE false);
CREATE INDEX ON postnummertilknytning_changes(txid);
CREATE INDEX ON postnummertilknytning_changes(adgangsadresseid,postnummer);
create table region(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
nuts2 text,
PRIMARY KEY(kode)
);
CREATE TABLE region_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, region.* FROM region WHERE false);
CREATE INDEX ON region_changes(txid);
CREATE INDEX ON region_changes(kode);
create table regionstilknytning(
adgangsadresseid uuid,
regionskode text,
PRIMARY KEY(adgangsadresseid, regionskode)
);
CREATE TABLE regionstilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, regionstilknytning.* FROM regionstilknytning WHERE false);
CREATE INDEX ON regionstilknytning_changes(txid);
CREATE INDEX ON regionstilknytning_changes(adgangsadresseid,regionskode);
create table retskreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
PRIMARY KEY(kode)
);
CREATE TABLE retskreds_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, retskreds.* FROM retskreds WHERE false);
CREATE INDEX ON retskreds_changes(txid);
CREATE INDEX ON retskreds_changes(kode);
create table retskredstilknytning(
adgangsadresseid uuid,
retskredskode text,
PRIMARY KEY(adgangsadresseid, retskredskode)
);
CREATE TABLE retskredstilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, retskredstilknytning.* FROM retskredstilknytning WHERE false);
CREATE INDEX ON retskredstilknytning_changes(txid);
CREATE INDEX ON retskredstilknytning_changes(adgangsadresseid,retskredskode);
create table sogn(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
kode text,
navn text,
PRIMARY KEY(kode)
);
CREATE TABLE sogn_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, sogn.* FROM sogn WHERE false);
CREATE INDEX ON sogn_changes(txid);
CREATE INDEX ON sogn_changes(kode);
create table sognetilknytning(
adgangsadresseid uuid,
sognekode text,
PRIMARY KEY(adgangsadresseid, sognekode)
);
CREATE TABLE sognetilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, sognetilknytning.* FROM sognetilknytning WHERE false);
CREATE INDEX ON sognetilknytning_changes(txid);
CREATE INDEX ON sognetilknytning_changes(adgangsadresseid,sognekode);
create table sted(
id uuid,
hovedtype text,
undertype text,
bebyggelseskode integer,
indbyggerantal integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
PRIMARY KEY(id)
);
CREATE TABLE sted_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, sted.* FROM sted WHERE false);
CREATE INDEX ON sted_changes(txid);
CREATE INDEX ON sted_changes(id);
create table stednavn(
stedid uuid,
navn text,
navnestatus text,
brugsprioritet text,
PRIMARY KEY(stedid, navn)
);
CREATE TABLE stednavn_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, stednavn.* FROM stednavn WHERE false);
CREATE INDEX ON stednavn_changes(txid);
CREATE INDEX ON stednavn_changes(stedid,navn);
create table stednavntilknytning(
stednavn_id uuid,
adgangsadresse_id uuid,
PRIMARY KEY(stednavn_id, adgangsadresse_id)
);
CREATE TABLE stednavntilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, stednavntilknytning.* FROM stednavntilknytning WHERE false);
CREATE INDEX ON stednavntilknytning_changes(txid);
CREATE INDEX ON stednavntilknytning_changes(stednavn_id,adgangsadresse_id);
create table stedtilknytning(
stedid uuid,
adgangsadresseid uuid,
PRIMARY KEY(stedid, adgangsadresseid)
);
CREATE TABLE stedtilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, stedtilknytning.* FROM stedtilknytning WHERE false);
CREATE INDEX ON stedtilknytning_changes(txid);
CREATE INDEX ON stedtilknytning_changes(stedid,adgangsadresseid);
create table storkreds(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
nummer text,
navn text,
regionskode text,
valglandsdelsbogstav text,
PRIMARY KEY(nummer)
);
CREATE TABLE storkreds_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, storkreds.* FROM storkreds WHERE false);
CREATE INDEX ON storkreds_changes(txid);
CREATE INDEX ON storkreds_changes(nummer);
create table storkredstilknytning(
adgangsadresseid uuid,
storkredsnummer text,
PRIMARY KEY(adgangsadresseid, storkredsnummer)
);
CREATE TABLE storkredstilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, storkredstilknytning.* FROM storkredstilknytning WHERE false);
CREATE INDEX ON storkredstilknytning_changes(txid);
CREATE INDEX ON storkredstilknytning_changes(adgangsadresseid,storkredsnummer);
create table supplerendebynavn(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
dagi_id text,
navn text,
kommunekode text,
PRIMARY KEY(dagi_id)
);
CREATE TABLE supplerendebynavn_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, supplerendebynavn.* FROM supplerendebynavn WHERE false);
CREATE INDEX ON supplerendebynavn_changes(txid);
CREATE INDEX ON supplerendebynavn_changes(dagi_id);
create table supplerendebynavntilknytning(
adgangsadresseid uuid,
dagi_id text,
PRIMARY KEY(adgangsadresseid, dagi_id)
);
CREATE TABLE supplerendebynavntilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, supplerendebynavntilknytning.* FROM supplerendebynavntilknytning WHERE false);
CREATE INDEX ON supplerendebynavntilknytning_changes(txid);
CREATE INDEX ON supplerendebynavntilknytning_changes(adgangsadresseid,dagi_id);
create table valglandsdel(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
bogstav text,
navn text,
PRIMARY KEY(bogstav)
);
CREATE TABLE valglandsdel_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, valglandsdel.* FROM valglandsdel WHERE false);
CREATE INDEX ON valglandsdel_changes(txid);
CREATE INDEX ON valglandsdel_changes(bogstav);
create table valglandsdelstilknytning(
adgangsadresseid uuid,
valglandsdelsbogstav text,
PRIMARY KEY(adgangsadresseid, valglandsdelsbogstav)
);
CREATE TABLE valglandsdelstilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, valglandsdelstilknytning.* FROM valglandsdelstilknytning WHERE false);
CREATE INDEX ON valglandsdelstilknytning_changes(txid);
CREATE INDEX ON valglandsdelstilknytning_changes(adgangsadresseid,valglandsdelsbogstav);
create table vask_adresse_historik(
husnummerid uuid,
etage text,
dør text,
rowkey integer,
id uuid,
adgangspunkt_status integer,
husnummer_status integer,
kommunekode text,
vejkode text,
vejnavn text,
adresseringsvejnavn text,
husnr text,
supplerendebynavn text,
postnr text,
postnrnavn text,
virkningstart timestamptz,
virkningslut timestamptz,
PRIMARY KEY(rowkey)
);
CREATE TABLE vask_adresse_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, vask_adresse_historik.* FROM vask_adresse_historik WHERE false);
CREATE INDEX ON vask_adresse_historik_changes(txid);
CREATE INDEX ON vask_adresse_historik_changes(rowkey);
create table vask_husnummer_historik(
rowkey integer,
id uuid,
adgangspunkt_status integer,
husnummer_status integer,
kommunekode text,
vejkode text,
vejnavn text,
adresseringsvejnavn text,
husnr text,
supplerendebynavn text,
postnr text,
postnrnavn text,
virkningstart timestamptz,
virkningslut timestamptz,
PRIMARY KEY(rowkey)
);
CREATE TABLE vask_husnummer_historik_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, vask_husnummer_historik.* FROM vask_husnummer_historik WHERE false);
CREATE INDEX ON vask_husnummer_historik_changes(txid);
CREATE INDEX ON vask_husnummer_historik_changes(rowkey);
create table vejmidte(
kommunekode text,
vejkode text,
geometri geometry(geometryz, 25832),
PRIMARY KEY(kommunekode, vejkode)
);
CREATE TABLE vejmidte_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, vejmidte.* FROM vejmidte WHERE false);
CREATE INDEX ON vejmidte_changes(txid);
CREATE INDEX ON vejmidte_changes(kommunekode,vejkode);
create table vejpunkt(
id uuid,
kilde text,
tekniskstandard text,
nøjagtighedsklasse text,
position geometry(geometry, 25832),
PRIMARY KEY(id)
);
CREATE TABLE vejpunkt_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, vejpunkt.* FROM vejpunkt WHERE false);
CREATE INDEX ON vejpunkt_changes(txid);
CREATE INDEX ON vejpunkt_changes(id);
create table vejstykke(
id text,
kommunekode text,
kode text,
oprettet timestamp,
ændret timestamp,
navn text,
adresseringsnavn text,
navngivenvej_id uuid,
PRIMARY KEY(kommunekode, kode)
);
CREATE TABLE vejstykke_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, vejstykke.* FROM vejstykke WHERE false);
CREATE INDEX ON vejstykke_changes(txid);
CREATE INDEX ON vejstykke_changes(kommunekode,kode);
create table vejstykkepostnummerrelation(
kommunekode text,
vejkode text,
postnr text,
PRIMARY KEY(kommunekode, vejkode, postnr)
);
CREATE TABLE vejstykkepostnummerrelation_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, vejstykkepostnummerrelation.* FROM vejstykkepostnummerrelation WHERE false);
CREATE INDEX ON vejstykkepostnummerrelation_changes(txid);
CREATE INDEX ON vejstykkepostnummerrelation_changes(kommunekode,vejkode,postnr);
create table zone(
ændret text,
geo_ændret text,
geo_version integer,
visueltcenter geometry(geometry, 25832),
bbox geometry(geometry, 25832),
geometri geometry(geometry, 25832),
zone text,
PRIMARY KEY(zone)
);
CREATE TABLE zone_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, zone.* FROM zone WHERE false);
CREATE INDEX ON zone_changes(txid);
CREATE INDEX ON zone_changes(zone);
create table zonetilknytning(
adgangsadresseid uuid,
zone text,
PRIMARY KEY(adgangsadresseid, zone)
);
CREATE TABLE zonetilknytning_changes AS (SELECT NULL::integer as txid, NULL::dawa_replication.operation_type as operation, zonetilknytning.* FROM zonetilknytning WHERE false);
CREATE INDEX ON zonetilknytning_changes(txid);
CREATE INDEX ON zonetilknytning_changes(adgangsadresseid,zone)
