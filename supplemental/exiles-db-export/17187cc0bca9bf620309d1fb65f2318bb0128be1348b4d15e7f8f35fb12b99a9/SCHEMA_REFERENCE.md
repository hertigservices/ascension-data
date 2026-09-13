# coa_db — schema and data reference (shareable snapshot, 2026-09-13)

Source: `db.exil.es` PostgreSQL 17 database `coa_db`. This document describes the **public game-data
catalog** as delivered in `coa-public-2026-09-13.sql.gz`. It says nothing about the ingest side
(uploaders, submissions, change tracking) — those tables are not part of the dump.

## Global conventions

- `id` is the game entry id (TrinityCore `item_template.entry` style). Ascension reuses ids > 900,000 for custom content; several tables use `BIGINT` to allow LootCollector pseudo-ids such as `-300017`.

- `*_loc` columns are JSONB maps keyed by `locale.id` (`{"2": "Item name in frFR"}`). `locale` lists 0=enUS, 2=frFR, 3=deDE, 4=zhCN, 6=esES, 8=ruRU.

- `*_search` tables are precomputed, normalised search projections (name / description / effects) with `pg_trgm` GIN indexes. They exist for lookups only; the canonical data is in the base table.

- Wide denormalised JSONB columns: `items.stats`, `items.damage`, `items.spells`, `items.sockets`, `quest.reward_items`, `creature.spells`. Shapes are documented by column comments below.

- Extensions required: `citext` (`class.slug`, `realm.slug`, `mind_of_ascension_tree.slug`) and `pg_trgm` (name/description search).

- No triggers, no SQL functions, no views in this snapshot: it is data plus table/index/constraint DDL only.

- Totals: 97 tables, ~2218 MB in the live cluster, ~1.3 GB after a clean restore, 6,190,916 rows.

## Table inventory

### Items & equipment

| table | rows | live size | purpose |
|---|---:|---:|---|
| `items` | 117,092 | 375.70 MB | Master item table: item_template-shaped row plus Ascension fields (phase, worldforged, socket/spell jsonb, source labels, raw ingest payload). |
| `affixed_item` | 13,296 | 46.48 MB | Worldforged (Ascension) affixed drops: one row per observed rolled item, with prefix/suffix, rolled stats and confirmation count. |
| `item_dbc` | 612,871 | 42.91 MB | Item.dbc projection (class, subclass, display, inventory type, sheath) - the client-side item ids. |
| `item_display_info` | 243,170 | 35.63 MB | ItemDisplayInfo.dbc projection (models and textures per display id). |
| `item_stats` | 29,382 | 13.75 MB | Denormalised stat projection of items (stats plus damage) for filter and sort UIs. |
| `icon` | 72,304 | 11.02 MB | Icon catalogue: Ascension interface icon names and where each came from. |
| `mystic_enchant` | 825 | 3.18 MB | Ascension Mystic Scroll catalogue: scroll items, effects, tier, prerequisites. |
| `random_property_pool` | 10,087 | 2.66 MB | ItemRandomProperties.dbc - fixed-stat random suffix pool. |
| `item_crafted_by` | 4,915 | 1.02 MB | Inverse index: item to crafting spell(s). |
| `item_loot` | 6,945 | 0.93 MB | Loot contained inside items (containers, lockboxes). |
| `craft_recipe` | 1,299 | 0.68 MB | Profession recipes: spell, result item, reagent list (jsonb), profession, source label. |
| `itemset` | 163 | 0.26 MB | Item sets: pieces, bonus thresholds, bonus spells. |
| `random_suffix_pool` | 275 | 0.14 MB | ItemRandomSuffix.dbc - pooled-stat suffix pool (Ascension expands these). |
| `item_character_creation` | 75 | 0.07 MB | Starting and character-creation items per race and class (Ascension creation kits). |
| `items_search` | 0 | 0.06 MB | Precomputed item search rows per locale (name, description, effects) used by trigram search. |
| `itemenchantment` | 0 | 0.02 MB | ItemEnchantment.dbc - enchant ids, types, effect points. |

### Spells & talents

| table | rows | live size | purpose |
|---|---:|---:|---|
| `spell` | 240,858 | 931.44 MB | Master spell table: DBC fields plus TrinityCore-style attributes, effects/reagents jsonb, tooltips, Mind of Ascension description. |
| `skill_line_ability` | 44,060 | 8.44 MB | SkillLineAbility.dbc - spell to skill-line mapping, complements spell.skill_line_id. |
| `mind_of_ascension_talent` | 8,532 | 5.67 MB | Ascension classless talent grid node: description, rank count, spell ids per rank. |
| `spell_icon` | 16,714 | 3.96 MB | Resolved icon per spell (from DBC or from sibling spells). |
| `class_spell` | 2,755 | 1.09 MB | Per-class ability/passive list from the CoA skill exporter; complements npc_trainer, which only covers vanilla classes. |
| `talent` | 4,753 | 0.66 MB | Classic Talent.dbc entries. |
| `skillline` | 887 | 0.34 MB | SkillLine.dbc - professions and weapon/armor skills. |
| `spell_duration` | 866 | 0.21 MB | Derived duration buckets and DBC durations per spell. |
| `mind_of_ascension_tree` | 153 | 0.16 MB | Mind of Ascension talent tree (one row per class-tree / spec). |
| `spell_range` | 323 | 0.13 MB | SpellRange.dbc - range values per spell. |
| `spell_radius` | 318 | 0.11 MB | SpellRadius.dbc - radius values per spell. |
| `spell_bonus_data` | 216 | 0.07 MB | TrinityCore-authored spell coefficient overrides. |
| `spell_cast_times` | 71 | 0.05 MB | Derived cast-time buckets per spell (scaling hints). |
| `talent_tab` | 37 | 0.05 MB | TalentTab.dbc - tab, spec mask and background. |
| `spell_search` | 0 | 0.03 MB | Precomputed spell search rows (name, tooltip, buff text, trigram indexed). |
| `shapeshiftform` | 0 | 0.02 MB | ShapeshiftForm.dbc - form metadata. |
| `spell_difficulty` | 0 | 0.01 MB | SpellDifficulty.dbc - difficulty slots. |
| `glyphproperties` | 0 | 0.01 MB | GlyphProperties.dbc - glyph spell and type flags. |

### Quests

| table | rows | live size | purpose |
|---|---:|---:|---|
| `quest` | 18,625 | 35.34 MB | Master quest table: requirements, rewards (jsonb arrays), text fields, POI, XP curve. |
| `quest_startend` | 10,616 | 1.16 MB | Quest start/end links to NPCs, objects and zones. |
| `quest_objective_hotspot` | 2,715 | 0.48 MB | Map hotspots for quest objectives. |
| `quest_xp` | 1,000 | 0.17 MB | Quest XP per level (Ascension curve). |
| `quest_search` | 0 | 0.03 MB | Precomputed quest text search rows (objectives and body, trigram indexed). |

### Creatures, NPCs & vendors

| table | rows | live size | purpose |
|---|---:|---:|---|
| `creature` | 43,213 | 48.45 MB | Creature template (TrinityCore creature_template shape): levels, faction, damage, health, loot ids, spells[], flags, immunities. |
| `creature_spawn` | 153,064 | 45.48 MB | Observed creature spawn points: guid, position, area, respawn timer, phase. |
| `achievement` | 22,637 | 9.15 MB | Achievement catalogue (DBC-derived): points, category, chain position, rewards. |
| `npc_vendor` | 62,977 | 7.30 MB | Vendor NPC to item stock. |
| `npc_trainer` | 76,213 | 6.79 MB | Trainer NPC to spell list (vanilla class trainers). |
| `creature_quest_ends` | 7,859 | 0.78 MB | Quest to credit NPC (turn-in) links. |
| `creature_quest_starts` | 7,430 | 0.73 MB | Quest to quest-giver NPC links. |
| `creature_onkill_reputation` | 2,724 | 0.30 MB | Reputation awarded for killing a creature. |
| `creature_family` | 399 | 0.20 MB | CreatureFamily.dbc lookup. |
| `creature_spell_data` | 803 | 0.20 MB | TrinityCore spell coefficient/bonus data for creature spells. |
| `creature_difficulty` | 1,813 | 0.16 MB | Per-difficulty creature stat overrides. |
| `achievement_category` | 245 | 0.11 MB | Achievement category tree and names. |
| `creature_search` | 0 | 0.03 MB | Precomputed creature name search rows (trigram indexed). |
| `pet` | 0 | 0.02 MB | Hunter pet catalogue: family, diet, stat scaling, spells. |
| `creature_waypoint` | 0 | 0.01 MB | Waypoint paths for scripted creatures. |

### Loot

| table | rows | live size | purpose |
|---|---:|---:|---|
| `creature_loot` | 4,268,812 | 547.80 MB | Creature id to loot_template (loot_id) attribution. Largest table by row count. |
| `gameobject_loot` | 19,283 | 2.23 MB | GameObject id to loot_template (loot_id) attribution. |
| `reference_loot` | 13,976 | 1.69 MB | Reference loot tables pointed at by loot_template.reference_id. |
| `pickpocket_loot` | 10,891 | 1.18 MB | Rogue pickpocket loot tables. |
| `item_loot` | 6,945 | 0.93 MB | Loot contained inside items (containers, lockboxes). |
| `skinning_loot` | 693 | 0.13 MB | Skinning loot per creature or loot id. |
| `disenchant_loot` | 123 | 0.05 MB | Disenchant results per item or quality. |
| `fishing_loot` | 65 | 0.05 MB | Fishing loot tables keyed by zone / loot id. |
| `loot_template` | 0 | 0.05 MB | Canonical loot template: loot_id to item, chance, reference-loot mechanic. |
| `source` | 0 | 0.03 MB | Curated item-source rows (aowow style drop/quest/vendor provenance). |
| `loot_link` | 0 | 0.02 MB | Curated NPC/object to encounter/difficulty loot links used for boss loot attribution. |

### World, maps & objects

| table | rows | live size | purpose |
|---|---:|---:|---|
| `gameobject` | 25,965 | 13.70 MB | GameObject template: name, type, loot id, spawn-related fields. |
| `area` | 2,853 | 4.66 MB | Flattened AreaTable.dbc - zones AND subzones live here (no separate subzone table). |
| `faction` | 417 | 0.34 MB | Faction.dbc enriched with base reputation rules and quartermaster NPC ids. |
| `faction_template` | 843 | 0.30 MB | FactionTemplate.dbc - alliance/horde friendliness masks. |
| `lfg_dungeon` | 439 | 0.24 MB | LFGDungeons.dbc - unified dungeon and raid LFG entries (level bracket, map, difficulty). |
| `map` | 375 | 0.17 MB | Map.dbc - continents and instances. |
| `world_map_area` | 300 | 0.17 MB | Flattened WorldMapArea.dbc - bounding box per zone, used for spawn to area classification. |
| `title` | 190 | 0.09 MB | CharTitles.dbc - player titles (male/female, side, expansion). |
| `currency` | 69 | 0.09 MB | Ascension currencies (badges, marks): cap, icon, linked item, description. |
| `locale` | 6 | 0.05 MB | Client locales (0 enUS, 2 frFR, 3 deDE, 4 zhCN, 6 esES, 8 ruRU). Keys of every *_loc jsonb column. |
| `class` | 32 | 0.05 MB | ChrClasses.dbc lookup used by filter UIs. In Ascension classless mode characters mix classes via talents. |
| `realm` | 6 | 0.05 MB | Realms whose data is ingested (Bronzebeard = 1). |
| `spawn` | 0 | 0.04 MB | Unified spawn table for creatures and gameobjects: guid, position, phase, path. |
| `objectdifficulty` | 0 | 0.04 MB | Object (chest, door) difficulty-gated spawn data. |
| `areatrigger` | 0 | 0.03 MB | AreaTrigger.dbc - trigger zones with their map and quest. |
| `gameobject_search` | 0 | 0.03 MB | Precomputed gameobject name search rows. |
| `gameobject_spawn` | 0 | 0.03 MB | Observed gameobject spawn points (chests, herbs, ore, mining nodes). |
| `taxipath` | 0 | 0.02 MB | TaxiPath.dbc - flight connections between nodes. |
| `event` | 0 | 0.02 MB | Game event schedule (holiday link, start/end time, occurrence interval). |
| `dungeon_boss_extra` | 2 | 0.02 MB | Curated extra bosses per dungeon or raid map (sort order, optional flag). |
| `gameobject_quest_starts` | 0 | 0.02 MB | Quest to quest-giver gameobject links. |
| `gameobject_quest_ends` | 0 | 0.02 MB | Quest to credit gameobject (turn-in) links. |
| `taxinode` | 0 | 0.02 MB | TaxiNode.dbc - flight master nodes. |
| `holiday` | 0 | 0.02 MB | Holiday.dbc plus curated boss/achievement linkage. |
| `sound` | 0 | 0.02 MB | SoundEntries.dbc - sound kit ids and contained files. |
| `sound_file` | 0 | 0.02 MB | Sound file list and formats per sound kit. |
| `race` | 0 | 0.02 MB | ChrRaces.dbc lookup plus class mask (informational in Ascension classless mode). |
| `quickfact` | 0 | 0.02 MB | Short quick-fact blurbs shown next to an entity (item, spell, quest). |
| `dbversion` | 1 | 0.02 MB | Ingest ledger: which DB part and version was applied and when. |
| `spawn_override` | 0 | 0.01 MB | Spawn position overrides used for phasing and revisions. |

### Ingest-staging (empty; kept for foreign-key fidelity)

| table | rows | live size | purpose |
|---|---:|---:|---|
| `world_discovery` | 0 | 0.05 MB |  |
| `blackmarket_vendor` | 0 | 0.04 MB |  |
| `blackmarket_listing` | 0 | 0.03 MB | Black Market AH listing placeholders (item ids, including LootCollector pseudo-ids in the -300xxx range). |

## Full column reference

### `affixed_item` — 13,296 rows, 46.48 MB

_Ascension worldforged drops. One row per observed rolled item; counts merge._

| column | type | null | note |
|---|---|---|---|
| `id` | bigint | no |  |
| `base_item_id` | integer | yes |  |
| `item_id_observed` | integer | yes |  |
| `name` | text | yes |  |
| `icon_id` | integer | yes |  |
| `item_level` | smallint | no |  |
| `quality` | USER-DEFINED | no |  |
| `inventory_type` | USER-DEFINED | no |  |
| `prefix` | text | yes |  |
| `suffix` | text | yes |  |
| `rolled_stats` | jsonb | no |  |
| `source_label` | text | yes |  |
| `drop_zone_id` | integer | yes |  |
| `raw_payload` | jsonb | yes |  |
| `first_seen_at` | timestamp with time zone | no |  |
| `confirmation_count` | integer | no |  |
| `bisbeard_id` | text | yes |  |
| `name_norm` | text | yes |  |
| `last_seen_at` | timestamp with time zone | no |  |

### `craft_recipe` — 1,299 rows, 0.68 MB

| column | type | null | note |
|---|---|---|---|
| `spell_id` | integer | no |  |
| `item_id` | integer | yes |  |
| `num_result` | smallint | no |  |
| `profession` | text | yes |  |
| `reagents` | jsonb | no |  |
| `source` | text | no |  |
| `updated_at` | timestamp with time zone | no |  |

### `icon` — 72,304 rows, 11.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `name` | text | no |  |
| `name_source` | text | yes |  |

### `item_character_creation` — 75 rows, 0.07 MB

| column | type | null | note |
|---|---|---|---|
| `item_id` | integer | no |  |
| `class_id` | smallint | no |  |

### `item_crafted_by` — 4,915 rows, 1.02 MB

| column | type | null | note |
|---|---|---|---|
| `recipe_item_id` | integer | yes |  |
| `spell_id` | integer | no |  |
| `crafted_item_id` | integer | no |  |

### `item_dbc` — 612,871 rows, 42.91 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `class` | smallint | no |  |
| `sub_class` | smallint | no |  |
| `display_id` | integer | no |  |
| `inventory_type` | smallint | no |  |
| `sheath` | smallint | no |  |

### `item_display_info` — 243,170 rows, 35.63 MB

| column | type | null | note |
|---|---|---|---|
| `display_id` | integer | no |  |
| `icon_name` | text | no |  |

### `item_loot` — 6,945 rows, 0.93 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |
| `quest_required` | boolean | no |  |
| `reference_id` | integer | no |  |

### `item_stats` — 29,382 rows, 13.75 MB

_Denormalised stat projection for filter/sort UIs. Built from items.stats + items.damage._

| column | type | null | note |
|---|---|---|---|
| `item_id` | integer | no |  |
| `nsockets` | smallint | no |  |
| `dps` | real | yes |  |
| `speed` | real | yes |  |
| `damage_type` | smallint | yes |  |
| `str` | integer | no |  |
| `agi` | integer | no |  |
| `sta` | integer | no |  |
| `int_` | integer | no |  |
| `spi` | integer | no |  |
| `crit_rating` | integer | no |  |
| `hit_rating` | integer | no |  |
| `haste_rating` | integer | no |  |
| `expertise` | integer | no |  |
| `armor_pen` | integer | no |  |
| `mastery_rating` | integer | no |  |
| `resilience` | integer | no |  |
| `armor` | integer | no |  |
| `defense` | integer | no |  |
| `dodge_rating` | integer | no |  |
| `parry_rating` | integer | no |  |
| `block_rating` | integer | no |  |
| `block_value` | integer | no |  |
| `attack_power` | integer | no |  |
| `spell_power` | integer | no |  |
| `spell_pen` | integer | no |  |
| `mp5` | integer | no |  |
| `hp5` | integer | no |  |
| `res_holy` | integer | no |  |
| `res_fire` | integer | no |  |
| `res_nature` | integer | no |  |
| `res_frost` | integer | no |  |
| `res_shadow` | integer | no |  |
| `res_arcane` | integer | no |  |
| `spell_power_holy` | integer | no |  |
| `spell_power_fire` | integer | no |  |
| `spell_power_nature` | integer | no |  |
| `spell_power_frost` | integer | no |  |
| `spell_power_shadow` | integer | no |  |
| `spell_power_arcane` | integer | no |  |

### `itemenchantment` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `charges` | smallint | no |  |
| `proc_chance` | smallint | no |  |
| `ppm_rate` | real | no |  |
| `types` | ARRAY | no |  |
| `amounts` | ARRAY | no |  |
| `objects` | ARRAY | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `condition_id` | smallint | yes |  |
| `skill_line_id` | integer | yes |  |
| `skill_level` | smallint | no |  |
| `required_level` | smallint | no |  |

### `items` — 117,092 rows, 375.70 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `class` | smallint | no |  |
| `sub_class` | smallint | no |  |
| `sub_sub_class` | smallint | no |  |
| `sound_override_subclass` | smallint | yes |  |
| `quality` | USER-DEFINED | no |  |
| `flags` | integer | no |  |
| `flags_extra` | integer | no |  |
| `flags_custom` | integer | no |  |
| `cu_flags` | integer | no |  |
| `inventory_type` | USER-DEFINED | no |  |
| `bonding` | USER-DEFINED | no |  |
| `item_level` | smallint | no |  |
| `required_level` | smallint | no |  |
| `required_class` | integer | no |  |
| `required_race` | integer | no |  |
| `required_skill` | integer | yes |  |
| `required_skill_rank` | smallint | no |  |
| `required_spell` | integer | yes |  |
| `required_honor_rank` | integer | no |  |
| `required_city_rank` | integer | no |  |
| `required_faction_id` | integer | yes |  |
| `required_faction_rank` | smallint | no |  |
| `required_disenchant_skill` | smallint | no |  |
| `max_count` | integer | no |  |
| `stackable` | integer | no |  |
| `container_slots` | smallint | no |  |
| `bag_family` | integer | no |  |
| `totem_category` | integer | no |  |
| `icon_id` | integer | yes |  |
| `display_id` | integer | no |  |
| `spell_visual_id` | integer | no |  |
| `material` | smallint | no |  |
| `sheath` | smallint | no |  |
| `page_text_id` | integer | no |  |
| `language_id` | smallint | no |  |
| `food_type` | smallint | no |  |
| `duration` | integer | no |  |
| `item_limit_category` | smallint | no |  |
| `holiday_id` | integer | yes |  |
| `script_name` | text | no |  |
| `model` | text | yes |  |
| `buy_count` | smallint | no |  |
| `buy_price` | integer | no |  |
| `sell_price` | integer | no |  |
| `repair_price` | integer | no |  |
| `stats` | jsonb | no |  |
| `scaling_stat_distribution` | smallint | no |  |
| `scaling_stat_value` | integer | no |  |
| `damage` | jsonb | no |  |
| `delay_ms` | integer | no |  |
| `armor` | integer | no |  |
| `armor_damage_modifier` | real | no |  |
| `block` | integer | no |  |
| `res_holy` | smallint | no |  |
| `res_fire` | smallint | no |  |
| `res_nature` | smallint | no |  |
| `res_frost` | smallint | no |  |
| `res_shadow` | smallint | no |  |
| `res_arcane` | smallint | no |  |
| `ammo_type` | smallint | no |  |
| `ranged_mod_range` | real | no |  |
| `durability` | smallint | no |  |
| `spells` | jsonb | no |  |
| `sockets` | jsonb | no |  |
| `socket_bonus` | integer | no |  |
| `gem_color_mask` | integer | no |  |
| `gem_enchantment_id` | integer | yes |  |
| `disenchant_id` | integer | no |  |
| `random_property_id` | integer | yes |  |
| `random_suffix_id` | integer | yes |  |
| `random_enchant` | integer | no |  |
| `itemset` | integer | yes |  |
| `area_id` | integer | yes |  |
| `map_id` | integer | yes |  |
| `start_quest_id` | integer | yes |  |
| `lock_id` | integer | no |  |
| `pick_up_sound_id` | integer | yes |  |
| `drop_down_sound_id` | integer | yes |  |
| `sheathe_sound_id` | integer | yes |  |
| `unsheathe_sound_id` | integer | yes |  |
| `min_money_loot` | integer | no |  |
| `max_money_loot` | integer | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |
| `version_tag` | USER-DEFINED | no |  |
| `phase` | smallint | yes |  |
| `drop_rate` | text | yes |  |
| `source_label` | text | yes |  |
| `source_category` | text | yes |  |
| `classes` | ARRAY | no |  |
| `raw_payload` | jsonb | yes |  |
| `first_seen_at` | timestamp with time zone | no |  |
| `last_updated_at` | timestamp with time zone | no |  |
| `name_norm` | text | yes |  |
| `worldforged` | boolean | no |  |
| `taught_spell_id` | integer | yes |  |
| `wf_base_item_id` | integer | yes |  |
| `worldforged_tier` | smallint | yes |  |

### `items_search` — 0 rows, 0.06 MB

| column | type | null | note |
|---|---|---|---|
| `item_id` | integer | no |  |
| `locale` | smallint | no |  |
| `n_name` | text | yes |  |
| `n_description` | text | yes |  |
| `n_effects` | text | yes |  |

### `itemset` — 163 rows, 0.26 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `ref_set_id` | integer | yes |  |
| `quality` | USER-DEFINED | no |  |
| `type` | smallint | no |  |
| `content_group` | smallint | no |  |
| `npieces` | smallint | no |  |
| `min_level` | smallint | no |  |
| `max_level` | smallint | no |  |
| `req_level` | smallint | no |  |
| `class_mask` | integer | no |  |
| `skill_id` | integer | yes |  |
| `skill_level` | smallint | no |  |
| `heroic` | boolean | no |  |
| `event_id` | integer | yes |  |
| `item_ids` | ARRAY | no |  |
| `bonus_spells` | ARRAY | no |  |
| `bonus_thresholds` | ARRAY | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `bonus_text` | text | yes |  |
| `bonus_text_loc` | jsonb | no |  |

### `mystic_enchant` — 825 rows, 3.18 MB

_Ascension Mystic Scroll catalog. Sourced from Harvia's mystic-enchants-db._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `item_id` | integer | yes |  |
| `spell_id` | integer | yes |  |
| `scroll_name` | text | no |  |
| `class_filter` | text | yes |  |
| `quality` | USER-DEFINED | no |  |
| `tier` | text | yes |  |
| `req_level` | smallint | no |  |
| `effect_text` | text | yes |  |
| `tooltip_text` | text | yes |  |
| `prerequisites` | ARRAY | no |  |
| `is_crossover` | boolean | no |  |
| `is_collected_default` | boolean | no |  |
| `raw_payload` | jsonb | yes |  |
| `fetched_at` | timestamp with time zone | no |  |

### `random_property_pool` — 10,087 rows, 2.66 MB

_ItemRandomProperties.dbc — fixed-stat random suffix pool (e.g. "of Power")._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `internal_name` | text | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `enchant_ids` | ARRAY | no |  |
| `allocation_pct` | ARRAY | no |  |

### `random_suffix_pool` — 275 rows, 0.14 MB

_ItemRandomSuffix.dbc — pooled-stat suffix (Ascension expands these)._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `internal_name` | text | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `enchant_ids` | ARRAY | no |  |
| `allocation_pct` | ARRAY | no |  |
| `item_level_min` | smallint | yes |  |
| `item_level_max` | smallint | yes |  |

### `class_spell` — 2,755 rows, 1.09 MB

_Per-class abilities/passives from CoA_SkillExporter; complements npc_trainer which only covers vanilla classes._

| column | type | null | note |
|---|---|---|---|
| `class_id` | smallint | no |  |
| `spell_id` | integer | no |  |
| `advancement_id` | integer | yes |  |
| `kind` | text | no |  |
| `tab` | text | yes |  |
| `tier` | smallint | no |  |
| `col` | smallint | no |  |
| `req_level` | smallint | yes |  |

### `glyphproperties` — 0 rows, 0.01 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `spell_id` | integer | yes |  |
| `type_flags` | smallint | no |  |
| `icon_id` | integer | yes |  |

### `mind_of_ascension_talent` — 8,532 rows, 5.67 MB

_Ascension's classless talent grid; replaces Talent.dbc/aowow_talents._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `tree_id` | smallint | no |  |
| `row` | smallint | no |  |
| `col` | smallint | no |  |
| `max_rank` | smallint | no |  |
| `spell_ids` | ARRAY | no |  |
| `parent_talent_id` | integer | yes |  |
| `parent_required_rank` | smallint | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |
| `icon_id` | integer | yes |  |
| `raw_payload` | jsonb | yes |  |

### `mind_of_ascension_tree` — 153 rows, 0.16 MB

| column | type | null | note |
|---|---|---|---|
| `id` | smallint | no |  |
| `slug` | USER-DEFINED | no |  |
| `name` | text | no |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |
| `icon_id` | integer | yes |  |
| `role_hint` | text | yes |  |

### `shapeshiftform` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `bonus_action_bar` | smallint | no |  |
| `flags` | integer | no |  |
| `creature_type` | smallint | no |  |
| `attack_icon_id` | integer | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |

### `skill_line_ability` — 44,060 rows, 8.44 MB

_SkillLineAbility.dbc — N:M map between spells and skill lines. Complements spell.skill_line_id._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `skill_line_id` | integer | no |  |
| `spell_id` | integer | no |  |
| `race_mask` | integer | no |  |
| `class_mask` | integer | no |  |
| `exclude_race` | integer | no |  |
| `exclude_class` | integer | no |  |
| `min_skill_rank` | smallint | no |  |
| `superceded_by_spell` | integer | yes |  |
| `acquire_method` | smallint | no |  |

### `skillline` — 887 rows, 0.34 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `type_cat` | smallint | no |  |
| `category_id` | smallint | no |  |
| `profession_mask` | smallint | no |  |
| `icon_id` | integer | yes |  |
| `recipe_subclass` | smallint | yes |  |
| `specializations` | ARRAY | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |

### `spell` — 240,858 rows, 931.44 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `category` | integer | no |  |
| `type_cat` | smallint | no |  |
| `dispel_type` | smallint | no |  |
| `mechanic` | smallint | no |  |
| `attributes` | ARRAY | no |  |
| `cu_flags` | integer | no |  |
| `stance_mask` | integer | no |  |
| `stance_mask_not` | integer | no |  |
| `targets` | integer | no |  |
| `spell_focus_object` | integer | yes |  |
| `cast_time_ms` | integer | no |  |
| `recovery_time_ms` | integer | no |  |
| `recovery_category` | integer | no |  |
| `gcd_ms` | integer | no |  |
| `gcd_category` | integer | no |  |
| `proc_chance` | smallint | no |  |
| `proc_charges` | integer | no |  |
| `proc_custom` | real | no |  |
| `proc_cooldown_ms` | integer | no |  |
| `duration_ms` | integer | no |  |
| `base_level` | smallint | no |  |
| `spell_level` | smallint | no |  |
| `max_level` | smallint | no |  |
| `talent_level` | smallint | no |  |
| `power_type` | smallint | no |  |
| `power_cost` | integer | no |  |
| `power_cost_per_level` | integer | no |  |
| `power_cost_percent` | integer | no |  |
| `power_per_second` | integer | no |  |
| `power_per_second_level` | integer | no |  |
| `range_id` | integer | no |  |
| `stack_amount` | integer | no |  |
| `equipped_item_class` | smallint | no |  |
| `equipped_item_subclass_mask` | integer | no |  |
| `equipped_item_inventory_mask` | integer | no |  |
| `school_mask` | smallint | no |  |
| `damage_class` | smallint | no |  |
| `spell_family_id` | smallint | no |  |
| `spell_family_flags` | ARRAY | no |  |
| `icon_id` | integer | yes |  |
| `spell_visual_id` | integer | yes |  |
| `rank_no` | smallint | no |  |
| `skill_line_id` | integer | yes |  |
| `req_race_mask` | integer | no |  |
| `req_class_mask` | integer | no |  |
| `req_spell_id` | integer | yes |  |
| `req_skill_level` | smallint | no |  |
| `learned_at` | smallint | no |  |
| `skill_level_grey` | smallint | no |  |
| `skill_level_yellow` | smallint | no |  |
| `training_cost` | integer | no |  |
| `reagents` | jsonb | no |  |
| `effects` | jsonb | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `rank_text` | text | yes |  |
| `rank_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |
| `buff_text` | text | yes |  |
| `buff_loc` | jsonb | no |  |
| `name_norm` | text | yes |  |
| `max_targets` | smallint | no |  |
| `moa_description` | text | yes |  |

### `spell_bonus_data` — 216 rows, 0.07 MB

_TrinityCore-authored coefficient overrides. Tier-4 input for the scaling-hint detector._

| column | type | null | note |
|---|---|---|---|
| `spell_id` | integer | no |  |
| `direct_bonus` | real | yes |  |
| `dot_bonus` | real | yes |  |
| `ap_bonus` | real | yes |  |
| `ap_dot_bonus` | real | yes |  |
| `comments` | text | yes |  |

### `spell_cast_times` — 71 rows, 0.05 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `base_time_ms` | integer | no |  |
| `per_level` | integer | no |  |
| `min_time_ms` | integer | no |  |

### `spell_difficulty` — 0 rows, 0.01 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `normal_10` | integer | yes |  |
| `normal_25` | integer | yes |  |
| `heroic_10` | integer | yes |  |
| `heroic_25` | integer | yes |  |
| `map_type` | smallint | no |  |

### `spell_duration` — 866 rows, 0.21 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `duration` | integer | no |  |
| `duration_per_level` | integer | no |  |
| `max_duration` | integer | no |  |

### `spell_icon` — 16,714 rows, 3.96 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `name` | text | no |  |

### `spell_radius` — 318 rows, 0.11 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `radius` | real | no |  |
| `radius_per_level` | real | no |  |
| `radius_max` | real | no |  |

### `spell_range` — 323 rows, 0.13 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `range_min` | real | no |  |
| `range_max` | real | no |  |
| `range_min_2` | real | no |  |
| `range_max_2` | real | no |  |
| `flags` | integer | no |  |
| `name` | text | yes |  |

### `spell_search` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `spell_id` | integer | no |  |
| `locale` | smallint | no |  |
| `n_name` | text | yes |  |
| `n_description` | text | yes |  |
| `n_buff` | text | yes |  |

### `talent` — 4,753 rows, 0.66 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `rank` | smallint | no |  |
| `class_id` | smallint | no |  |
| `pet_type_mask` | smallint | no |  |
| `tab` | smallint | no |  |
| `row` | smallint | no |  |
| `col` | smallint | no |  |
| `spell_id` | integer | no |  |

### `talent_tab` — 37 rows, 0.05 MB

| column | type | null | note |
|---|---|---|---|
| `id` | smallint | no |  |
| `class_id` | smallint | yes |  |
| `name` | text | no |  |
| `name_loc` | jsonb | no |  |
| `spell_icon_id` | integer | yes |  |
| `pet_talent_mask` | integer | no |  |
| `order_index` | smallint | no |  |
| `raw_class_mask` | integer | no |  |

### `quest` — 18,625 rows, 35.34 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `quest_type` | USER-DEFINED | no |  |
| `level` | smallint | no |  |
| `min_level` | smallint | no |  |
| `max_level` | smallint | no |  |
| `quest_sort_id` | smallint | no |  |
| `quest_info_id` | smallint | no |  |
| `suggested_players` | smallint | no |  |
| `time_limit_secs` | integer | no |  |
| `event_id` | integer | yes |  |
| `prev_quest_id` | integer | yes |  |
| `next_quest_id` | integer | yes |  |
| `breadcrumb_for_quest_id` | integer | yes |  |
| `exclusive_group` | integer | no |  |
| `next_quest_id_chain` | integer | yes |  |
| `flags` | integer | no |  |
| `special_flags` | smallint | no |  |
| `cu_flags` | integer | no |  |
| `req_class_mask` | integer | no |  |
| `req_race_mask` | integer | no |  |
| `req_skill_id` | integer | yes |  |
| `req_skill_points` | smallint | no |  |
| `req_min_rep` | jsonb | no |  |
| `req_max_rep` | jsonb | no |  |
| `req_player_kills` | smallint | no |  |
| `source_item_id` | integer | yes |  |
| `source_item_count` | smallint | no |  |
| `source_spell_id` | integer | yes |  |
| `reward_xp` | integer | no |  |
| `reward_money` | integer | no |  |
| `reward_money_max_level` | integer | no |  |
| `reward_spell_id` | integer | yes |  |
| `reward_spell_cast_id` | integer | yes |  |
| `reward_honor` | integer | no |  |
| `reward_arena_points` | smallint | no |  |
| `reward_title_id` | integer | yes |  |
| `reward_talents` | smallint | no |  |
| `reward_mail_template_id` | integer | yes |  |
| `reward_mail_delay_secs` | integer | yes |  |
| `reward_items` | jsonb | no |  |
| `reward_choice_items` | jsonb | no |  |
| `reward_factions` | jsonb | no |  |
| `req_npc_or_go` | jsonb | no |  |
| `req_source_items` | jsonb | no |  |
| `req_items` | jsonb | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `objectives` | text | yes |  |
| `objectives_loc` | jsonb | no |  |
| `details` | text | yes |  |
| `details_loc` | jsonb | no |  |
| `end_text` | text | yes |  |
| `end_loc` | jsonb | no |  |
| `offer_reward` | text | yes |  |
| `offer_reward_loc` | jsonb | no |  |
| `request_items` | text | yes |  |
| `request_items_loc` | jsonb | no |  |
| `completed_text` | text | yes |  |
| `completed_loc` | jsonb | no |  |
| `objective_texts` | jsonb | no |  |
| `name_norm` | text | yes |  |
| `reward_xp_difficulty` | smallint | no |  |
| `poi_map_id` | integer | yes |  |
| `poi_x` | real | yes |  |
| `poi_y` | real | yes |  |
| `poi_priority` | smallint | no |  |
| `xp_per_level` | double precision | yes |  |

### `quest_objective_hotspot` — 2,715 rows, 0.48 MB

| column | type | null | note |
|---|---|---|---|
| `quest_id` | integer | no |  |
| `objective_idx` | smallint | no |  |
| `target_kind` | smallint | no |  |
| `target_id` | integer | no |  |
| `target_name` | text | yes |  |
| `area_id` | integer | no |  |
| `map_id` | integer | yes |  |
| `cx_pct` | real | yes |  |
| `cy_pct` | real | yes |  |
| `spawn_count` | integer | no |  |
| `radius_pct` | real | yes |  |

### `quest_search` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `quest_id` | integer | no |  |
| `locale` | smallint | no |  |
| `n_name` | text | yes |  |
| `n_objectives` | text | yes |  |
| `n_details` | text | yes |  |

### `quest_startend` — 10,616 rows, 1.16 MB

| column | type | null | note |
|---|---|---|---|
| `type` | smallint | no |  |
| `type_id` | integer | no |  |
| `quest_id` | integer | no |  |
| `method` | smallint | no |  |
| `event_id` | integer | yes |  |

### `quest_xp` — 1,000 rows, 0.17 MB

| column | type | null | note |
|---|---|---|---|
| `level` | smallint | no |  |
| `difficulty` | smallint | no |  |
| `xp` | integer | no |  |

### `achievement` — 22,637 rows, 9.15 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `faction` | smallint | no |  |
| `map_id` | integer | yes |  |
| `chain_id` | smallint | no |  |
| `chain_pos` | smallint | no |  |
| `category_id` | integer | yes |  |
| `points` | smallint | no |  |
| `order_in_group` | smallint | no |  |
| `icon_id` | integer | yes |  |
| `flags` | integer | no |  |
| `req_criteria_count` | smallint | no |  |
| `ref_achievement_id` | integer | yes |  |
| `item_extra` | integer | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |
| `reward` | text | yes |  |
| `reward_loc` | jsonb | no |  |

### `achievement_category` — 245 rows, 0.11 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `parent_cat` | integer | yes |  |
| `parent_cat2` | integer | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |

### `creature` — 43,213 rows, 48.45 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `cu_flags` | integer | no |  |
| `difficulty_entries` | ARRAY | no |  |
| `kill_credits` | ARRAY | no |  |
| `display_ids` | ARRAY | no |  |
| `texture_string` | text | yes |  |
| `icon_string` | text | yes |  |
| `model_id` | integer | no |  |
| `is_humanoid` | boolean | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `sub_name` | text | yes |  |
| `sub_name_loc` | jsonb | no |  |
| `min_level` | smallint | no |  |
| `max_level` | smallint | no |  |
| `expansion` | smallint | no |  |
| `faction_id` | integer | yes |  |
| `npc_flags` | integer | no |  |
| `rank` | smallint | no |  |
| `type` | smallint | no |  |
| `type_flags` | integer | no |  |
| `family` | smallint | no |  |
| `unit_class` | smallint | no |  |
| `unit_flags` | integer | no |  |
| `unit_flags2` | integer | no |  |
| `dynamic_flags` | integer | no |  |
| `flags_extra` | integer | no |  |
| `racial_leader` | boolean | no |  |
| `mechanic_immune_mask` | integer | no |  |
| `school_immune_mask` | integer | no |  |
| `dmg_school` | smallint | no |  |
| `dmg_multiplier` | real | no |  |
| `atk_speed_ms` | integer | no |  |
| `rng_atk_speed_ms` | integer | no |  |
| `mle_variance` | real | no |  |
| `rng_variance` | real | no |  |
| `dmg_min` | real | no |  |
| `dmg_max` | real | no |  |
| `mle_atk_pwr_min` | integer | no |  |
| `mle_atk_pwr_max` | integer | no |  |
| `rng_atk_pwr_min` | integer | no |  |
| `rng_atk_pwr_max` | integer | no |  |
| `loot_id` | integer | yes |  |
| `pickpocket_loot_id` | integer | yes |  |
| `skin_loot_id` | integer | yes |  |
| `min_gold` | integer | no |  |
| `max_gold` | integer | no |  |
| `health_min` | integer | no |  |
| `health_max` | integer | no |  |
| `mana_min` | integer | no |  |
| `mana_max` | integer | no |  |
| `armor_min` | integer | no |  |
| `armor_max` | integer | no |  |
| `resistances` | ARRAY | no |  |
| `trainer_type` | smallint | no |  |
| `trainer_requirement` | integer | no |  |
| `spells` | ARRAY | no |  |
| `pet_spell_data_id` | integer | yes |  |
| `vehicle_id` | integer | yes |  |
| `script_or_ai` | text | yes |  |
| `string_id` | text | yes |  |
| `name_norm` | text | yes |  |
| `faction_template_id` | integer | no |  |
| `attack_power` | integer | no |  |

### `creature_difficulty` — 1,813 rows, 0.16 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `difficulty_1` | integer | yes |  |
| `difficulty_2` | integer | yes |  |
| `difficulty_3` | integer | yes |  |

### `creature_family` — 399 rows, 0.20 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `name` | text | yes |  |
| `skill_line` | integer | no |  |
| `skill_line_2` | integer | no |  |
| `pet_food_mask` | integer | no |  |
| `pet_talent_type` | integer | no |  |
| `category_enum_id` | integer | no |  |
| `icon` | text | yes |  |

### `creature_onkill_reputation` — 2,724 rows, 0.30 MB

| column | type | null | note |
|---|---|---|---|
| `creature_id` | integer | no |  |
| `faction_id` | integer | no |  |
| `rep_change` | smallint | no |  |

### `creature_quest_ends` — 7,859 rows, 0.78 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `quest_id` | integer | no |  |

### `creature_quest_starts` — 7,430 rows, 0.73 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `quest_id` | integer | no |  |

### `creature_search` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `creature_id` | integer | no |  |
| `locale` | smallint | no |  |
| `n_name` | text | yes |  |
| `n_subname` | text | yes |  |

### `creature_spawn` — 153,064 rows, 45.48 MB

| column | type | null | note |
|---|---|---|---|
| `guid` | bigint | no |  |
| `entry` | integer | no |  |
| `map_id` | integer | no |  |
| `zone_id` | integer | yes |  |
| `area_id` | integer | yes |  |
| `x` | double precision | yes |  |
| `y` | double precision | yes |  |
| `z` | double precision | yes |  |
| `spawnmask` | smallint | yes |  |
| `phasemask` | integer | yes |  |
| `zone_x_pct` | real | yes |  |
| `zone_y_pct` | real | yes |  |

### `creature_spell_data` — 803 rows, 0.20 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `spells` | ARRAY | no |  |

### `creature_waypoint` — 0 rows, 0.01 MB

| column | type | null | note |
|---|---|---|---|
| `creature_or_path` | integer | no |  |
| `point` | smallint | no |  |
| `area_id` | integer | no |  |
| `floor` | smallint | no |  |
| `pos_x` | real | no |  |
| `pos_y` | real | no |  |
| `wait_ms` | integer | no |  |

### `npc_trainer` — 76,213 rows, 6.79 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `spell_id` | integer | no |  |
| `money_cost` | integer | no |  |
| `req_skill` | integer | no |  |
| `req_skill_value` | smallint | no |  |
| `req_level` | smallint | no |  |

### `npc_vendor` — 62,977 rows, 7.30 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `maxcount` | integer | no |  |
| `incrtime` | integer | no |  |
| `extendedcost` | integer | no |  |

### `pet` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `category` | integer | no |  |
| `cu_flags` | integer | no |  |
| `min_level` | smallint | no |  |
| `max_level` | smallint | no |  |
| `food_mask` | integer | no |  |
| `type` | smallint | no |  |
| `exotic` | boolean | no |  |
| `expansion` | smallint | no |  |
| `icon_id` | integer | yes |  |
| `skill_line_id` | integer | yes |  |
| `spell_ids` | ARRAY | no |  |
| `armor` | integer | no |  |
| `damage` | integer | no |  |
| `health` | integer | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |

### `creature_loot` — 4,268,812 rows, 547.80 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | real | no |  |
| `mincountorref` | integer | no |  |
| `maxcount` | integer | no |  |
| `groupid` | smallint | no |  |
| `lootcondition_id` | integer | yes |  |
| `quest_required` | boolean | no |  |
| `reference_id` | integer | no |  |

### `disenchant_loot` — 123 rows, 0.05 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |

### `fishing_loot` — 65 rows, 0.05 MB

| column | type | null | note |
|---|---|---|---|
| `area_id` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |
| `reference_id` | integer | no |  |

### `gameobject_loot` — 19,283 rows, 2.23 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |
| `quest_required` | boolean | no |  |
| `reference_id` | integer | no |  |

### `item_loot` — 6,945 rows, 0.93 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |
| `quest_required` | boolean | no |  |
| `reference_id` | integer | no |  |

### `loot_link` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | bigint | no |  |
| `npc_id` | integer | no |  |
| `object_id` | integer | no |  |
| `difficulty` | USER-DEFINED | no |  |
| `priority` | smallint | no |  |
| `encounter_id` | integer | no |  |

### `loot_template` — 0 rows, 0.05 MB

| column | type | null | note |
|---|---|---|---|
| `id` | bigint | no |  |
| `loot_id` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | real | no |  |
| `quest_required` | boolean | no |  |
| `lootmode` | integer | no |  |
| `group_id` | smallint | no |  |
| `min_count` | integer | no |  |
| `max_count` | integer | no |  |
| `reference_id` | integer | no |  |
| `comment` | text | yes |  |

### `pickpocket_loot` — 10,891 rows, 1.18 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |

### `reference_loot` — 13,976 rows, 1.69 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |

### `skinning_loot` — 693 rows, 0.13 MB

| column | type | null | note |
|---|---|---|---|
| `entry` | integer | no |  |
| `item_id` | integer | no |  |
| `chance` | numeric | no |  |
| `mincount` | smallint | no |  |
| `maxcount` | smallint | no |  |
| `groupid` | smallint | no |  |

### `source` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `type` | smallint | no |  |
| `type_id` | integer | no |  |
| `more_type` | smallint | yes |  |
| `more_type_id` | integer | yes |  |
| `more_zone_id` | integer | yes |  |
| `more_mask` | integer | yes |  |
| `sources` | ARRAY | no |  |

### `area` — 2,853 rows, 4.66 MB

_Flattened AreaTable.dbc / aowow_zones — both zones and subzones live here._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `map_id` | integer | no |  |
| `parent_area_id` | integer | yes |  |
| `flags` | integer | no |  |
| `level_min` | smallint | yes |  |
| `level_max` | smallint | yes |  |
| `faction_side` | USER-DEFINED | no |  |
| `expansion` | smallint | no |  |
| `type` | smallint | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `exploration_level` | smallint | yes |  |
| `area_bit` | integer | no |  |
| `area_level` | smallint | yes |  |

### `areatrigger` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `cu_flags` | integer | no |  |
| `type` | smallint | no |  |
| `map_id` | integer | yes |  |
| `pos_x` | real | no |  |
| `pos_y` | real | no |  |
| `orientation` | real | no |  |
| `name` | text | yes |  |
| `quest_id` | integer | yes |  |

### `class` — 32 rows, 0.05 MB

_ChrClasses.dbc — kept for filter UIs; in Ascension, characters can mix classes via talents._

| column | type | null | note |
|---|---|---|---|
| `id` | smallint | no |  |
| `file_string` | text | yes |  |
| `icon_id` | integer | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `power_type` | smallint | no |  |
| `race_mask` | integer | no |  |
| `roles` | integer | no |  |
| `weapon_type_mask` | integer | no |  |
| `armor_type_mask` | integer | no |  |
| `expansion` | smallint | no |  |
| `flags` | integer | no |  |
| `slug` | USER-DEFINED | yes |  |
| `is_ascension_custom` | boolean | no |  |

### `currency` — 69 rows, 0.09 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `category` | integer | no |  |
| `icon_id` | integer | yes |  |
| `item_id` | integer | yes |  |
| `cap` | integer | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |

### `dbversion` — 1 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `applied_at` | timestamp with time zone | no |  |
| `part` | smallint | no |  |
| `version` | text | no |  |
| `notes` | text | yes |  |

### `dungeon_boss_extra` — 2 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `map_id` | integer | no |  |
| `creature_id` | integer | no |  |
| `sort_order` | integer | no |  |
| `optional` | boolean | no |  |

### `event` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `holiday_id` | integer | yes |  |
| `start_time` | timestamp with time zone | yes |  |
| `end_time` | timestamp with time zone | yes |  |
| `occurrence_secs` | integer | no |  |
| `length_secs` | integer | no |  |
| `requires` | text | yes |  |
| `description` | text | yes |  |

### `faction` — 417 rows, 0.34 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `rep_index` | smallint | no |  |
| `side` | USER-DEFINED | no |  |
| `expansion` | smallint | no |  |
| `parent_faction_id` | integer | yes |  |
| `base_rep` | jsonb | no |  |
| `spillover_in` | real | no |  |
| `spillover_out` | real | no |  |
| `spillover_max_rank` | smallint | no |  |
| `qm_npc_ids` | ARRAY | no |  |
| `template_ids` | ARRAY | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |

### `faction_template` — 843 rows, 0.30 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `faction_id` | integer | no |  |
| `alliance` | smallint | no |  |
| `horde` | smallint | no |  |
| `flags` | integer | no |  |
| `faction_group` | integer | no |  |
| `friend_group` | integer | no |  |
| `enemy_group` | integer | no |  |
| `enemies` | ARRAY | no |  |
| `friends` | ARRAY | no |  |

### `gameobject` — 25,965 rows, 13.70 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `type` | smallint | no |  |
| `type_cat` | smallint | no |  |
| `event_id` | integer | yes |  |
| `display_id` | integer | no |  |
| `faction_id` | integer | yes |  |
| `flags` | integer | no |  |
| `cu_flags` | integer | no |  |
| `loot_id` | integer | yes |  |
| `lock_id` | integer | no |  |
| `req_skill` | integer | yes |  |
| `page_text_id` | integer | yes |  |
| `linked_trap_id` | integer | yes |  |
| `req_quest_id` | integer | yes |  |
| `spell_focus_id` | integer | yes |  |
| `on_use_spell_id` | integer | yes |  |
| `on_success_spell_id` | integer | yes |  |
| `aura_spell_id` | integer | yes |  |
| `triggered_spell_id` | integer | yes |  |
| `misc_info` | text | yes |  |
| `script_or_ai` | text | yes |  |
| `string_id` | text | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `name_norm` | text | yes |  |

### `gameobject_quest_ends` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `quest_id` | integer | no |  |

### `gameobject_quest_starts` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `quest_id` | integer | no |  |

### `gameobject_search` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `gameobject_id` | integer | no |  |
| `locale` | smallint | no |  |
| `n_name` | text | yes |  |

### `gameobject_spawn` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `guid` | bigint | no |  |
| `entry` | integer | no |  |
| `map_id` | integer | no |  |
| `zone_id` | integer | yes |  |
| `area_id` | integer | yes |  |
| `x` | double precision | yes |  |
| `y` | double precision | yes |  |
| `z` | double precision | yes |  |
| `spawnmask` | smallint | yes |  |
| `phasemask` | integer | yes |  |
| `zone_x_pct` | real | yes |  |
| `zone_y_pct` | real | yes |  |

### `holiday` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `boss_creature_id` | integer | yes |  |
| `achievement_cat_or_id` | integer | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |
| `looping` | boolean | no |  |
| `schedule_type` | smallint | no |  |
| `icon_id` | integer | yes |  |
| `texture_string` | text | yes |  |

### `lfg_dungeon` — 439 rows, 0.24 MB

_LFGDungeons.dbc — unified dungeon/raid LFG entries (level bracket, map, difficulty)._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `name` | text | no |  |
| `name_loc` | jsonb | no |  |
| `min_level` | smallint | no |  |
| `max_level` | smallint | no |  |
| `target_level` | smallint | no |  |
| `map_id` | integer | yes |  |
| `difficulty` | smallint | no |  |
| `type_cat` | smallint | no |  |
| `faction` | smallint | no |  |
| `expansion` | smallint | no |  |
| `group_id` | integer | no |  |
| `description` | text | yes |  |
| `description_loc` | jsonb | no |  |
| `flags` | integer | no |  |

### `locale` — 6 rows, 0.05 MB

_WoW client locale ids (0=enUS, 2=frFR, 3=deDE, 4=zhCN, 6=esES, 8=ruRU)._

| column | type | null | note |
|---|---|---|---|
| `id` | smallint | no |  |
| `code` | text | no |  |
| `name` | text | no |  |

### `map` — 375 rows, 0.17 MB

_Map.dbc — continents and instances._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `directory` | text | yes |  |
| `type` | USER-DEFINED | no |  |
| `is_battleground` | boolean | no |  |
| `expansion` | smallint | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `instance_type` | smallint | yes |  |
| `flags` | integer | no |  |
| `max_players` | smallint | yes |  |

### `objectdifficulty` — 0 rows, 0.04 MB

| column | type | null | note |
|---|---|---|---|
| `id` | bigint | no |  |
| `normal_10` | integer | yes |  |
| `normal_25` | integer | yes |  |
| `heroic_10` | integer | yes |  |
| `heroic_25` | integer | yes |  |
| `map_type` | smallint | no |  |

### `quickfact` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `type` | smallint | no |  |
| `type_id` | integer | no |  |
| `order_idx` | smallint | no |  |
| `position` | USER-DEFINED | no |  |
| `body` | text | no |  |

### `race` — 0 rows, 0.02 MB

_PlayerRace lookup. In Ascension classless mode, class_mask is informational only._

| column | type | null | note |
|---|---|---|---|
| `id` | smallint | no |  |
| `class_mask` | integer | no |  |
| `flags` | integer | no |  |
| `faction_id` | integer | yes |  |
| `start_area_id` | integer | yes |  |
| `leader_npc_id` | integer | yes |  |
| `base_language` | smallint | yes |  |
| `side` | USER-DEFINED | no |  |
| `file_string` | text | yes |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |
| `expansion` | smallint | no |  |

### `realm` — 6 rows, 0.05 MB

_WoW realms whose data we ingest. Bronzebeard = 1._

| column | type | null | note |
|---|---|---|---|
| `id` | smallint | no |  |
| `slug` | USER-DEFINED | no |  |
| `display_name` | text | no |  |
| `region` | text | yes |  |
| `is_active` | boolean | no |  |
| `notes` | text | yes |  |

### `sound` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `cat` | smallint | no |  |
| `name` | text | no |  |
| `flags` | integer | no |  |
| `files` | ARRAY | no |  |

### `sound_file` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `file` | text | no |  |
| `path` | text | no |  |
| `format` | USER-DEFINED | no |  |

### `spawn` — 0 rows, 0.04 MB

| column | type | null | note |
|---|---|---|---|
| `guid` | bigint | no |  |
| `type` | smallint | no |  |
| `type_id` | integer | no |  |
| `respawn_secs` | integer | no |  |
| `spawn_mask` | smallint | no |  |
| `phase_mask` | integer | no |  |
| `area_id` | integer | yes |  |
| `floor` | smallint | no |  |
| `pos_x` | real | no |  |
| `pos_y` | real | no |  |
| `pos_z` | real | yes |  |
| `path_id` | integer | no |  |
| `script_name` | text | yes |  |
| `string_id` | text | yes |  |

### `spawn_override` — 0 rows, 0.01 MB

| column | type | null | note |
|---|---|---|---|
| `type` | smallint | no |  |
| `type_guid` | bigint | no |  |
| `area_id` | integer | yes |  |
| `floor` | smallint | no |  |
| `revision` | smallint | no |  |

### `taxinode` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `map_id` | integer | yes |  |
| `map_x` | real | no |  |
| `map_y` | real | no |  |
| `area_id` | integer | yes |  |
| `area_x` | real | no |  |
| `area_y` | real | no |  |
| `npc_or_go_kind` | text | no |  |
| `type_id` | integer | no |  |
| `react_a` | smallint | no |  |
| `react_h` | smallint | no |  |
| `name` | text | yes |  |
| `name_loc` | jsonb | no |  |

### `taxipath` — 0 rows, 0.02 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `start_node_id` | integer | no |  |
| `end_node_id` | integer | no |  |

### `title` — 190 rows, 0.09 MB

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `category` | smallint | no |  |
| `gender` | smallint | no |  |
| `side` | USER-DEFINED | no |  |
| `expansion` | smallint | no |  |
| `bit_idx` | smallint | no |  |
| `event_id` | integer | yes |  |
| `male_name` | text | yes |  |
| `male_name_loc` | jsonb | no |  |
| `female_name` | text | yes |  |
| `female_name_loc` | jsonb | no |  |

### `world_map_area` — 300 rows, 0.17 MB

_Flattened WorldMapArea.dbc — bounding-box rectangle for each zone in the world map. Used by the spawn-to-area classifier._

| column | type | null | note |
|---|---|---|---|
| `id` | integer | no |  |
| `map_id` | integer | no |  |
| `area_id` | integer | yes |  |
| `area_name` | text | yes |  |
| `loc_left` | real | yes |  |
| `loc_right` | real | yes |  |
| `loc_top` | real | yes |  |
| `loc_bottom` | real | yes |  |

### `blackmarket_listing` — 0 rows, 0.03 MB

| column | type | null | note |
|---|---|---|---|
| `id` | bigint | no |  |
| `vendor_id` | bigint | no |  |
| `slot_index` | smallint | no |  |
| `item_id` | integer | yes |  |
| `item_link` | text | yes |  |
| `item_name` | text | yes |  |
| `price_copper` | bigint | yes |  |
| `stack` | integer | no |  |
| `num_available` | integer | no |  |
| `extra_costs` | jsonb | no |  |
| `first_seen_at` | timestamp with time zone | no |  |
| `last_seen_at` | timestamp with time zone | no |  |

### `blackmarket_vendor` — 0 rows, 0.04 MB

| column | type | null | note |
|---|---|---|---|
| `id` | bigint | no |  |
| `realm_id` | smallint | yes |  |
| `guid` | text | no |  |
| `vendor_creature_id` | integer | yes |  |
| `vendor_name` | text | yes |  |
| `map_id` | integer | yes |  |
| `area_id` | integer | yes |  |
| `coord_x` | real | yes |  |
| `coord_y` | real | yes |  |
| `discovery_type` | smallint | yes |  |
| `status` | text | yes |  |
| `found_by_player` | text | yes |  |
| `originator` | text | yes |  |
| `first_seen_at` | timestamp with time zone | no |  |
| `last_seen_at` | timestamp with time zone | no |  |
| `raw_payload` | jsonb | yes |  |

### `world_discovery` — 0 rows, 0.05 MB

| column | type | null | note |
|---|---|---|---|
| `id` | bigint | no |  |
| `realm_id` | smallint | yes |  |
| `guid` | text | no |  |
| `discovery_type` | smallint | yes |  |
| `map_id` | integer | yes |  |
| `area_id` | integer | yes |  |
| `coord_x` | real | yes |  |
| `coord_y` | real | yes |  |
| `item_id` | integer | yes |  |
| `item_quality` | USER-DEFINED | yes |  |
| `item_type` | smallint | yes |  |
| `item_subtype` | smallint | yes |  |
| `creature_id` | integer | yes |  |
| `source` | text | yes |  |
| `status` | text | yes |  |
| `found_by_player` | text | yes |  |
| `originator` | text | yes |  |
| `announce_count` | integer | no |  |
| `merge_count` | integer | no |  |
| `first_seen_at` | timestamp with time zone | no |  |
| `last_seen_at` | timestamp with time zone | no |  |
| `raw_payload` | jsonb | yes |  |

## Privacy boundary

Only the 97 tables documented above are present. Uploader/submission records, source IP addresses, staged observations, moderation/merge history, migration history, change-tracking history, user-defined SQL functions, and user triggers are absent.

## Query starting points

- Item search: `select i.id, i.name, i.item_level, i.quality from items_search s join items i on i.id = s.item_id where s.n_name like '%sword%' limit 20;`

- Item full stat block: `select * from items where id = …` joined with `item_stats`, `itemset`, `loot_link`.

- Creature to loot: `select lt.item_id, lt.chance from creature_loot cl join loot_template lt on lt.loot_id = cl.loot_id where cl.creature_id = …;`

- Spell to class/tree: `select * from class_spell where spell_id = …` and `mind_of_ascension_talent` for the Ascension talent grid.

- Where an item comes from: `select * from loot_link where item_id = …` and `source` / `items.source_label`, `items.source_category`.

