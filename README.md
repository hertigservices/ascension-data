# Ascension Data

Recovered Ascension datasets, provenance, manifests and immutable supplemental
catalogs. This repository was previously named **ascension-cache-consolidator**;
its history is retained; downloaded cache files retain their original paths.

**[Download the complete cache collection or selected folders](DOWNLOADS.md).** Large files are in Releases; this checkout holds the manifest and small upload receipts.

**Tool source now lives in [Ascension Preservation](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator).**
See the [unified setup guide](https://github.com/hertigservices/Ascension_preservation/blob/main/docs/SETUP.md).

| Data | Purpose |
|---|---|
| [Cache downloads](DOWNLOADS.md) | Captured WDB records, valid variants, per-mode views and provenance; verified Release packs with original filenames |
| [manifests/](manifests/) | SHA-256 and size of every file in a named cache snapshot |
| [supplemental/bisbeard/](supplemental/bisbeard/) | Separately attributed planner export, all original rows, queryable catalog and comparison report |
| [supplemental/exiles-db/](supplemental/exiles-db/) | Separately attributed mirror of a CoA database site, parsed into spell, item, NPC, quest, achievement and talent-tree records, with a change log and a hash index of every mirrored file |
| [supplemental/exiles-db-export/](supplemental/exiles-db-export/) | The PostgreSQL database behind that site, provided by its anonymous operator: 97 gameplay tables and 6.19M rows as SQL and CSV, untruncated loot and raw spawn coordinates, an icon map, and the site's 80,721 images served individually |
| [supplemental/worldforged/](supplemental/worldforged/) | Separately attributed Worldforged pickup locations and upgrade ladders ([Tareksoh/Worldforged-data](https://github.com/Tareksoh/Worldforged-data)), republished with the author's permission |
| [supplemental/coa-databank/](supplemental/coa-databank/) | Separately attributed CoA reference data ([f3rr311/CoA-Databank](https://github.com/f3rr311/CoA-Databank)): a coabuildhub.com scrape of talents, skills and community builds, MPQ-derived spell and asset indexes, and harvest provenance. Republished with the author's permission, with community identities and local paths removed |
| [supplemental/client-dbc-snapshots/](supplemental/client-dbc-snapshots/) | Client DBC dumps kept as their difference from the public client package: every member named with its hash, and only the DBCs whose bytes differ republished, each with a record-level report |

| Guide | What it covers |
|---|---|
| [Using the data](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/USING-THE-DATA.md) | Installing these caches into a client, importing them into a server's world database, and checking the result in game |
| [Verifying the data](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/VERIFYING-THE-DATA.md) | How to satisfy yourself a merged record matches what a client really wrote |
| [The WDB format](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/WDB-FORMAT.md) | The layout of a `.wdb` cache file, including the parts still unread |
| [The GameObject dumps](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/GAMEOBJECT-DUMPS.md) | What the donated object and creature dumps are, and why they are not a spawn table |
| [The Exiles database mirror](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/EXILES-DB.md) | What the `db.exil.es` mirror holds, what its rendered values can and cannot tell you, and how the catalog is built and checked |

Those guides live beside the tools whose commands they contain, so that a flag
and its documentation change together. The matching paths under [docs/](docs/)
in this repository are signposts to them, kept so older links still land
somewhere useful.

Captured cache variants remain separate by source and game mode. The supplemental
planner catalog does not replace captured values or claim that a candidate ID,
loot source, or probability is authoritative. Each supplemental snapshot records
its exact source hash and interpretation limits.

The cache publisher operates from the preservation source or a recorded deployment
in an intake installation. This repository's `.ascension-data.json` marker prevents
it from copying source code here. Private submissions, intake ledgers, credentials,
character backups and live database dumps stay outside this repository.

The pre-migration code is retained in history and the `pre-consolidation-2026-09-10`
tag. Existing old GitHub URLs redirect to this repository after the rename.
