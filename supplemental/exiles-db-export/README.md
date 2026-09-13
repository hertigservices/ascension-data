# Exiles database export (coa-db, 2026-09-13)

This is the PostgreSQL database behind **`db.exil.es`** ("coa-db"), a Conquest of Azeroth
database site, plus the site's complete image set. The site's operator provided both for
preservation and asked to remain anonymous; nothing here identifies them.

The [2026-08-29 offline mirror](../exiles-db/) is a crawl of the site's rendered pages. This
is the database those pages were rendered from, exported two weeks later. It has no
20-row cap on loot and vendor lists, no 10-row cap on spawns, and raw world coordinates
where the pages showed whole-percent map positions.

## Preserved export

[Open the export](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/).

- **97 gameplay tables, 6,190,916 rows**, restored and checked table by table against
  the export's own row counts.
- **Loot without the page cap:** 4,268,812 `creature_loot` rows over 15,251 loot entries,
  the largest with 3,357 rows.
- **153,064 creature spawns**, with raw world `x/y/z` on every spawn below guid 10,000,000.
- **240,858 spells, 117,092 items, 612,871 `item_dbc` rows, 243,170 item display rows,
  18,625 quests, 43,213 creatures, 62,977 vendor rows and 76,213 trainer rows.**
- **80,721 images**: 75,030 icons, 5,564 creature renders, 63 dungeon maps, 43 page
  images and 21 CoA class portraits. Each is served individually (see below).

| Download | Purpose |
| --- | --- |
| [SQL dump](https://github.com/hertigservices/ascension-data/releases/download/exiles-db-export-2026-09-13/coa-public-2026-09-13.sql.gz) | The complete export as self-contained PostgreSQL plain SQL: 69.2 MB, expanding to 710 MB. Restore it with the [restore guide](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/RESTORE.md). |
| [Tables as CSV](https://github.com/hertigservices/ascension-data/releases/download/exiles-db-export-2026-09-13/coa-public-2026-09-13-tables.tar) | One gzipped CSV per table, with a header row and sorted by primary key. For anyone without PostgreSQL. |
| [Schema reference](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/SCHEMA_REFERENCE.md) | Every table and column explained, with query starting points. |
| [schema.sql](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/schema.sql) · [TABLE_INDEX.csv](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/TABLE_INDEX.csv) · [COLUMN_INDEX.csv](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/COLUMN_INDEX.csv) | Exact DDL, per-table row counts, and a machine-readable column map. |
| [Icon map](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/icon-map.csv.gz) | `kind,id,icon` for 319,248 item, spell and currency ids, resolved through the icon tables. |
| [Asset index](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/ASSET_INDEX.csv.gz) | Path, size, SHA-256, media type, category, rights note and original URL of all 80,711 files the site served. |
| [Manifest](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/manifest.json) | Source hash, every file's size and SHA-256, per-table counts and hashes, screening results. |

## Images

Each image is available by URL, so nothing needs to be scraped:
`https://ascension-public-data.ascension-archive.workers.dev/images/<path>`

| Path | Files | Site path it came from |
| --- | ---: | --- |
| `images/icons/<name>.png` | 75,030 | `static/icons-clean/` |
| `images/creatures/<display id>.webp` | 5,564 | `static/creatures/` |
| `images/maps/<map>_floor<n>.webp` | 63 | `maps/` |
| `images/img/…` | 43 | `static/img/` (talent backgrounds and page art) |
| `images/class-portraits/<class>.png` | 21 | provided separately by the operator |
| `images/ASSET_INDEX.csv` | 1 | the asset index, with paths rewritten to these keys |

Icon names are lowercase, with the game's own spelling. For example, `inv_misc_food_02`
is at `…/images/icons/inv_misc_food_02.png`. Every image from the export matched the asset
index on size and SHA-256 before upload.

**Known issue:** 985 icons whose names contain `(`, `)`, `'`, `&` or `]` are stored but
currently return 404. The read service's path check does not yet accept those characters.

Not republished: the site's `robots.txt`, eight `llms*.txt` guide files, one 20 kB JSON
file, and a 144 MB zip that duplicates the creature renders.

## Reading the data correctly

**`creature_loot` is an aggregated drop view, not a server loot table.**
- Join `creature_loot.entry` to `creature.id`, not `creature.loot_id`. 15,242 of the
  15,251 loot entries match a creature id; only 7,607 match a `loot_id`. Joining on
  `loot_id` silently drops about half the loot.
- Many creatures carry flattened world-drop pools. Drakkari Frenzy (29834) has 893
  ungrouped rows whose chances sum to 722%. 1,255 of 15,181 creatures sum past 300%.
- 43,950 rows store a reference id in `item_id` (`reference_id = item_id`).
- Read the chances as the site's per-creature drop figures. Never load the table into a
  server as it stands.

**Spawns come in two kinds.**
- The 151,710 spawns below guid 10,000,000 carry raw world `x/y/z`: the stock-style base.
- The 1,354 at or above carry NULL `x/y/z` and only zone-map percentages, anchored on
  `area_id` rather than `zone_id`. These are Ascension's custom placements. Their
  percentages are at 0.1% resolution, ten times finer than the crawled pages.
- Maps 936 and 937 have no spawns. `gameobject_spawn` and `creature_waypoint` are empty.

**Icons.**
- `items.icon_id` and `currency.icon_id` point into `icon` (ids from 10,000,001).
- `spell.icon_id` points into `icon` at 10,000,000 and above, and into `spell_icon`
  below that.
- `achievement.icon_id` is empty on every row.
- `icon-map.csv.gz` has these joins done. 318,266 of its 319,248 ids name an icon that
  has a file. About 276 icon names used by the data have no file anywhere; most are
  generated spell-variant names such as `aether_blood_strike_913180`.

**Everything else.**
- IDs are Ascension's renumbered space. Item display ids in particular do not match
  stock 3.3.5a.
- `realm` lists six realms; its notes mark the side realms as "ingested as gap-fill
  only".
- `items.raw_payload` keeps upstream payload fields as delivered.
- Creature renders cover 2,781 of the 25,076 display ids creatures use.
- Values are the site's claims about the game. Captured WDB data elsewhere in this
  repository remains authoritative where the two disagree.

## Source and attribution

The export arrived on 2026-09-12 as `coa-rebuild-2026-09-13.tar.zst`: 969,663,875 bytes,
SHA-256 `17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9`. Its checksum
file was verified before extraction. The archive itself is not republished, because it
also holds handoff notes addressed to its recipient. Everything published here is
derived from it, and [the manifest](17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9/manifest.json)
records each file's hash.

The operator describes the database as Warcraft and Project Ascension game facts. It
is assembled from client data, server-provided cache data and public or permissioned
upstream references, in a table design influenced by the AGPL-3.0-or-later aowow
project. The export is an allow-list of 97 gameplay tables. Submitter, submission,
observation, moderation and change-tracking tables were left out of both schema and
data, along with every user-defined function and trigger.

Publication here was approved by the operator on condition of anonymity. That approval
is not a grant of rights in the game-derived material, and no licence is asserted. The
screening that preceded publication is described in
[PUBLICATION-REVIEW.md](PUBLICATION-REVIEW.md).
