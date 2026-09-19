# NPC zone claims

`npc-zone-claims.tsv.gz` is a compact, separately attributed input for the catalog's
zone facet. It contains exact creature-entry to `area_id` claims; it does not alter
the preserved NPC pages or client cache records.

The `direct-spawn-area` rows are deduplicated from `creature_spawn.area_id` in the
published [2026-09-13 Exiles database export](../exiles-db-export/README.md). The
catalog joins these rows only to NPC pages from the companion Exiles DB crawl, which
uses the same provider ID namespace. It does not copy them to client captures,
different sources, or modes.

`reviewed.json` records narrowly reviewed additions that the export cannot supply.
They remain visibly attributed as reports instead of being represented as spawn-table
claims. `npc-zone-relation-audit.tsv.gz` is the fail-closed review queue made from
quest objective targets, quest starters/enders, and high-signal same-zone quest prose.
Quest relationships never become live claims by themselves: an accepted pair must
also be present in `reviewed.json`.

Regenerate the claims with:

```console
python tools/ascension-db/make_npc_zone_claims.py \
  --spawns creature_spawn.csv.gz \
  --reviewed supplemental/npc-zone-claims/reviewed.json \
  --out supplemental/npc-zone-claims/npc-zone-claims.tsv.gz
```

Regenerate the relationship audit from a resolved cache dataset and the matching
Exiles export with:

```console
python tools/ascension-db/audit_npc_zone_relations.py \
  --quest-cache cachedata/union/questcache.tsv.gz \
  --npcs supplemental/exiles-db/<snapshot>/npcs.jsonl.gz \
  --areas area.csv.gz \
  --spawns creature_spawn.csv.gz \
  --reviewed supplemental/npc-zone-claims/reviewed.json \
  --quest-starts creature_quest_starts.csv.gz \
  --quest-ends creature_quest_ends.csv.gz \
  --out supplemental/npc-zone-claims/npc-zone-relation-audit.tsv.gz
```

The 2026-09-19 audit contains 7,212 relationship rows representing 2,848 unique
NPC/area pairs. Sixteen pairs were accepted after review. Another 857 pairs concern
currently unzoned NPCs and 1,975 conflict with at least one existing area; those stay
in the queue and do not affect the catalog.

The source export contains 153,064 spawn rows. Claims with an absent/non-positive
`area_id` are intentionally left unknown; map IDs and coordinates are not guessed into
areas.
