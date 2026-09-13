# Exiles database supplemental catalog

This dataset preserves a reviewed offline mirror of **`db.exil.es`** — "coa-db", a
Conquest of Azeroth database site — as parsed records, a change log, the original
bytes of the pages whose markup is the data, and a SHA-256 index of every
mirrored file. Website values are source-attributed claims and remain separate
from captured WDB data.

**The site's data backend was unreachable when this catalog was built.** Its root
and asset host answered from cache while every entity page and every `/api/v1/`
path returned `503 Backend fetch failed`. This mirror is therefore treated as
difficult or impossible to re-collect, and impossible to re-verify against the
live site.

## Preserved snapshot

[Open the snapshot](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/).

- 517,758 mirrored files, 13.75 GB, crawled 2026-08-29; every file identified by SHA-256.
- 493,029 recorded routes, of which 493,003 are HTML pages and all were parsed; 485,149 indexed entity names.
- **Creature spawn tables for 17,902 of the 41,817 NPCs** — 63,419 rows of map, area, coordinates and spawn count, declaring 88,558 spawn points across 185 named areas.
- 155 talent trees and 8,610 talent cells, each with spell id, icon, position and maximum rank.
- 540 daily change-log pages covering 2026-06-11 to 2026-08-29, as field-level diffs.
- Loot and pickpocket tables carrying the site's own stated drop chances; no probability is derived from them.
- Item tooltips retain their raw marker codes (`stat7`, `rtg32`) uninterpreted.
- No live realm has been changed and no WDB payload has been produced.

| Download | Purpose |
| --- | --- |
| [Mirror index](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/mirror.index.tsv.gz) | Path, size and SHA-256 of every mirrored file, so a reader holding the upstream archive can prove they have the same bytes. 517,760 rows: the archive's 517,758 files plus two SQLite sidecars created by opening the crawler's own database read-only. |
| [Names](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/names.tsv.gz) | The crawler's whole search index: page type, key, name and URL. |
| [Spells](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/spells.jsonl.gz) | Spell pages: info table, effects, icon, school and casting NPCs. |
| [Items](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/items.jsonl.gz) | Item pages: tooltip lines with marker codes, drop sources, change history. |
| [NPCs](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/npcs.jsonl.gz) | NPC pages: meta, display id, loot and pickpocket tables, cast lists. |
| [Quests](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/quests.jsonl.gz) · [Achievements](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/achievements.jsonl.gz) | Quest and achievement pages, including reward blocks. |
| [Other entities](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/entities.jsonl.gz) | Area, dungeon, map, skill, currency, pet, gameobject, class and listing pages. |
| [Talent trees](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/talents.jsonl.gz) | Every tree and cell, in both the positioned and flat layouts. |
| [Change log](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/changes.jsonl.gz) · [Per-entity history](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/histories.jsonl.gz) | Field-level changes with old value, new value, significance and source label. |
| [Tree and class pages](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/structural-pages.tar.gz) | Byte-exact original HTML of the pages whose markup carries CoA-only structure. |
| [API specification](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/openapi.json.gz) | The site's own OpenAPI document, its contact redacted in place. |
| [SQLite database](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/catalog.sqlite.gz) | Decompress and open read-only to query entities, trees and talents. |
| [Comparison report](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/comparison.json.gz) | Every name conflict, missing candidate and stub-named entity, listed by name and id. |
| [Manifest](6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/manifest.json) | Source and baseline hashes, counts, interpretation limits and artifact checksums. |
| [Icon assets](assets/) | The 21 CoA class icons, and the 16,733 icons a stock 3.3.5a client cannot supply, each verified against the mirror index. |

The 406,560,614-byte source archive is preserved in the
[`exiles-db-mirror-2026-08-29`](https://github.com/hertigservices/ascension-data/releases/tag/exiles-db-mirror-2026-08-29)
release, together with the mirrored assets not republished in the tree. Creature
portrait renders and dungeon floor maps are attached there as separate tarballs
so they can be taken without extracting 13.75 GB; the icons a client already has
are not attached at all.

**The archive contains a working offline server.** Extract it, run
`START_EXILES_DB.bat` (or `py -3 offline_exiles.py serve --port 8080 --open`)
from the `ExilesOfflineDB` folder, and the whole site comes back up at
`http://localhost:8080` — search, browsing and every internal link — served from
`data/offline_site.sqlite` and the mirrored pages. For reading the data rather
than processing it, that is far easier than anything in this directory.

## Creature spawn coordinates

NPC pages carry a `Map | Area | Coords | Spawns` table, preserved in each record's
`structure.tables`. This is the only creature placement data in the catalog and
the only source of its kind in this repository.

| | |
|---|---:|
| NPCs with a spawn table | 17,902 of 41,817 |
| spawn rows | 63,419 |
| spawn points declared (sum of the count column) | 88,558 |
| distinct creatures with parsed coordinates | 17,897 |
| distinct named areas | 185 |

**The coordinates are not server world positions.** 62,062 of the 63,411 parsed
rows (97.9%) fall within 0–100 on both axes: these are zone-map percentage
positions, the form a map pin uses, and they need a per-zone transform before
they mean anything to a server. The remaining 1,349 rows sit outside that range
on instance and transport maps and appear to be raw world units — for example
`Ulduar 2744.0, 2569.0` and `Deadmines -203.0, -454.0`. The two kinds are mixed
in one column and are **not** distinguished by the site, so anything consuming
this must branch on the range rather than assume a single space.

Coverage by map is led by Northrend (13,858 rows), Eastern Kingdoms (12,720),
Outland (12,305) and Kalimdor (12,029). Gameobject pages carry no spawn table at
all — object placement still comes only from the separately contributed
GameObject dumps.

## How it compares with the captured baseline

By id and case-insensitive name only, against `cachedata/union` at revision
`52c0c78`. No stat, loot source or probability is verified.

| | item | npc | gameobject | quest | total |
|---|---:|---:|---:|---:|---:|
| name-match | 92,656 | 17,005 | 1,165 | 10,177 | **121,003** |
| name-conflict | 592 | 248 | 3 | 96 | **939** |
| candidate-missing | 14,328 | 24,564 | 505 | 503 | **39,900** |
| unnamed-in-mirror | 7,797 | — | — | — | **7,797** |

`candidate-missing` rows are research candidates, not proven game entities; the
NPC share is dominated by upstream test and placeholder content. **`unnamed-in-mirror`
is a safety rail:** for 7,797 items the site renders a stub such as `Item #40753`
where the captured baseline holds a real name (`Emblem of Valor`). Those stubs
must never be written back over captured names.

The site appends a trailing `#id` to some genuine names for disambiguation
(`Ice Chest #188192`); that suffix is removed before comparing, so it is not
counted as a conflict.

## Source and attribution

The source is `ExilesOfflineDB_Baseline.7z.001`, published as
[Duff-SPP/AcensionOfflineDatabase](https://github.com/Duff-SPP/AcensionOfflineDatabase).
Original SHA-256:
`6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b`.
The mirrored site's own footer attributes it to the Project Ascension guild
*Exiles*. Neither the crawl nor the site's accuracy has been independently
authenticated, and the crawl date is the publisher's label rather than a verified
collection date.

The site's OpenAPI document declares `AGPL-3.0-or-later`. That licence describes
the API the document specifies; **it is not a grant covering the mirrored database
content**, and no licensing status for that content is asserted here. The document
arrived carrying a contact: a named individual's email address, and an organisation
that identifies the site's operator, who has asked to remain anonymous. The
published copy is byte-identical except that addresses are replaced with
`<redacted: contact address>` and the organisation with `<redacted: operator>`; the
unmodified file's SHA-256 is recorded in the manifest.

The upstream archive itself is not republished here — 13.75 GB of mirrored bytes
does not belong in a Git repository. `mirror.index.tsv.gz` identifies every file
in it by hash, so a reader who obtains the archive can confirm it is the one
these records were parsed from.

## Interpretation limits

Website values are attributed claims; captured WDB data remains authoritative
where the two disagree. Drop percentages are the site's own stated figures, not
observations made here. The crawl recorded 39,858 failed asset fetches, but they
are not missing icons: 22,151 asked for a `/coa/static/icons/` path the site never
served, 16,702 were creature renders that were never made, and 498 were
`icons-clean` files. The operator's complete icon set is served one file at a time
as `https://ascension-public-data.ascension-archive.workers.dev/images/icons/<name>.png`.
IDs are Ascension's renumbered space. Rendered pages give display
strings — `"Instant"`, not `cast_time_ms` — because only two of the site's JSON
API responses were captured.

The importer, tests and full format guide live in the canonical
[Ascension preservation repository](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator):
`tools/import_exiles.py`, `tools/exiles_parse.py`, `tools/test_exiles.py` and
`docs/EXILES-DB.md` beneath that component. It uses only Python's standard library.
