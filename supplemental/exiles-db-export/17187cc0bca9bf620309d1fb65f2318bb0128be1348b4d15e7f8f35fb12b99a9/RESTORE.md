# Restore the sanitized database

## Requirements

- PostgreSQL 17 is recommended.
- The PostgreSQL `citext` and `pg_trgm` extensions must be available.
- Start with an empty database.

## Restore the complete export

```bash
createdb coa_public
gzip -dc coa-public-2026-09-13.sql.gz \
  | psql --set ON_ERROR_STOP=1 --dbname coa_public
```

The compressed SQL is self-contained: it creates the required extensions, enum types, 97 public gameplay tables, indexes, constraints, sequences, and data. Do not apply `schema.sql` first when using this route.

## Schema only

For inspection or an empty implementation database:

```bash
createdb coa_public
psql --set ON_ERROR_STOP=1 --dbname coa_public --file schema.sql
```

## Expected verification results

```sql
SELECT count(*) FROM items;         -- 117092
SELECT count(*) FROM spell;         -- 240858
SELECT count(*) FROM creature;      -- 43213
SELECT count(*) FROM creature_loot; -- 4268812
```

`TABLE_INDEX.csv` records exact counts for all 97 tables. The restored database contains 6,190,916 rows in total, no operational/privacy-sensitive tables, no user-defined SQL functions, and no user triggers.
