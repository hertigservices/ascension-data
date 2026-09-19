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
claims. Regenerate the compressed file with:

```console
python tools/ascension-db/make_npc_zone_claims.py \
  --spawns creature_spawn.csv.gz \
  --reviewed supplemental/npc-zone-claims/reviewed.json \
  --out supplemental/npc-zone-claims/npc-zone-claims.tsv.gz
```

The source export contains 153,064 spawn rows. Claims with an absent/non-positive
`area_id` are intentionally left unknown; map IDs and coordinates are not guessed into
areas.
