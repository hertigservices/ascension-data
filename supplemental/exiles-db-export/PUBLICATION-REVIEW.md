# Publication review

**Source:** `coa-rebuild-2026-09-13.tar.zst`, 969,663,875 bytes, SHA-256
`17187cc0bca9bf620309d1fb65f2318bb0128be1348b4d15e7f8f35fb12b99a9`. It was transferred
over SSH and checked with `sha256sum -c` against the operator's own checksum file before
anything was extracted.

**Permission:** the operator provided the export for preservation. They approved its
publication in this repository on condition that identifying information is removed and
their anonymity kept; James Hertig relayed the approval on 2026-09-12. They separately
approved use and publication of the icons and class portraits.

## What was published

**Byte-identical to the export:**
- The SQL dump, as a release asset.
- `schema.sql`, `SCHEMA_REFERENCE.md`, `TABLE_INDEX.csv`, `COLUMN_INDEX.csv` and
  `RESTORE.md`.
- `ASSET_INDEX.csv`, gzipped with a zeroed timestamp. The manifest records the
  uncompressed file's hash.

**Derived:**
- **Per-table CSV.** The dump was restored into a fresh PostgreSQL 18.6 cluster with
  `ON_ERROR_STOP`. All 97 tables matched `TABLE_INDEX.csv` exactly: 6,190,916 rows, 0
  mismatches. The extensions were `citext`, `pg_trgm` and `plpgsql`, with 0 user functions
  and 0 user triggers. None of the excluded operational tables exists. Each table was
  exported ordered by its primary key, or by every column where it has none, then gzipped
  with a zeroed timestamp and packed into a tar with zeroed metadata.
- **`icon-map.csv.gz`.** One query over the restored database. Items and currencies join
  `icon_id` to `icon.id`; spells join to `icon.id` at 10,000,000 and above and to
  `spell_icon.id` below. Blank names are skipped. No id maps to two icons.
- **Images.** 80,700 of the export's files: every PNG, WebP and JPEG. Each was checked
  against `ASSET_INDEX.csv` on size and SHA-256, with 0 mismatches. The 21 class portraits
  the operator supplied separately were added.

**Not published:**
- The export's `README.md`, `CLAUDE_CONTEXT.md`, `SECURITY.md`, `PROVENANCE.md`,
  `ASSET_GUIDE.md` and `CHECKSUMS.sha256`. These are handoff documents addressed to their
  recipient. The facts that matter here are restated in the README: the exclusion list,
  the verification counts and the provenance.
- The site's `robots.txt`, its `llms*.txt` guides, a 20 kB JSON file, and a zip that
  duplicates the creature renders.
- The archive itself.

## Identity screening

The operator asked to remain anonymous. Everything published was screened against a
private list of patterns for their organisation, handles and network identifiers. The
list is kept out of this repository, because publishing it would identify them.

| Screened | Identity hits |
| --- | ---: |
| All 97 table exports, as CSV bytes | 0 |
| The whole SQL dump, streamed: 6,197,203 lines | 0 |
| `schema.sql`, the four schema documents and `ASSET_INDEX.csv` | 0 |
| All 80,721 staged images | 0 |

The same sweeps found:
- **E-mail-shaped strings:** exactly one distinct, `techbot@gnome.mail`, twice in spell
  text. It is the flavour line of the GM "BAN Hammer" spell, at a TLD that does not exist.
  The [Exiles mirror review](../exiles-db/PUBLICATION-REVIEW.md) found the same string.
- **IPv4-shaped strings in the dump:** none.
- **URL hosts in the data:** `ascension.gg` (4) and `teron.faldorn.net` (4). The second is
  in-game text linking to a Teron Gorefiend practice minigame.
- **Statements:** no `GRANT`, `REVOKE`, `COMMENT` or `OWNER TO`. The dump holds only
  `CREATE` 308, `ALTER` 221, `COPY` 97, `SET` 12 and `SELECT` 9.

Every free-text or people-shaped column was reviewed by its distinct values:
- `blackmarket_vendor.found_by_player` and `.originator` are empty, as are
  `world_discovery.found_by_player`, `.originator` and `.source`. So is
  `loot_template.comment`.
- `craft_recipe.source` holds only `tsm`.
- `items.source_label` holds source names such as `AQ40 - C'Thun`.
- `spell_bonus_data.comments` holds spell names.
- `realm.notes` describes realms.
- `dbversion.notes` describes the schema.

No player names, accounts or submitter records appear. The `items.raw_payload` keys are
game fields: `itemName`, `stats`, `tooltip`, `fetchedAt` and the like.

## Standing limits

These are a third-party site's values, not independently verified. `creature_loot` is an
aggregated view and must not be loaded into a server as it stands; the README explains how
to read it. Custom-NPC spawns carry map percentages, not world coordinates. No live realm
was changed, and no WDB payload was produced from this export. No licence is asserted for
the game-derived material.
