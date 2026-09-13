--
-- PostgreSQL database dump
--

\restrict ucujrTGm8Ru5E4TstxP2hYo8J30O5pdmSKDIjsQu9B5rBjxAtbcQUWkz4lXc6DY

-- Dumped from database version 17.11 (Debian 17.11-0+deb13u1)
-- Dumped by pg_dump version 17.11 (Debian 17.11-0+deb13u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: change_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.change_kind AS ENUM (
    'added',
    'removed',
    'changed'
);


--
-- Name: entity_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.entity_kind AS ENUM (
    'spell',
    'item',
    'creature',
    'quest',
    'gameobject'
);


--
-- Name: faction_side; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.faction_side AS ENUM (
    'alliance',
    'horde',
    'both',
    'neutral'
);


--
-- Name: instance_difficulty; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.instance_difficulty AS ENUM (
    'normal',
    'normal_10',
    'normal_25',
    'heroic',
    'heroic_10',
    'heroic_25',
    'mythic',
    'lfr'
);


--
-- Name: inventory_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.inventory_type AS ENUM (
    'non_equip',
    'head',
    'neck',
    'shoulder',
    'body',
    'chest',
    'waist',
    'legs',
    'feet',
    'wrist',
    'hand',
    'finger',
    'trinket',
    'weapon',
    'shield',
    'ranged',
    'cloak',
    'two_hand',
    'bag',
    'tabard',
    'robe',
    'main_hand',
    'off_hand',
    'holdable',
    'ammo',
    'thrown',
    'ranged_right',
    'quiver',
    'relic'
);


--
-- Name: item_bonding; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.item_bonding AS ENUM (
    'none',
    'on_pickup',
    'on_equip',
    'on_use',
    'quest_item',
    'to_account',
    'to_realm'
);


--
-- Name: item_quality; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.item_quality AS ENUM (
    'poor',
    'common',
    'uncommon',
    'rare',
    'epic',
    'legendary',
    'artifact',
    'heirloom'
);


--
-- Name: item_version_tag; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.item_version_tag AS ENUM (
    'unspecified',
    'normal',
    'heroic',
    'mythic',
    'crafted',
    'phase_1',
    'phase_2',
    'phase_3',
    'phase_4',
    'phase_5'
);


--
-- Name: map_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.map_type AS ENUM (
    'world',
    'dungeon',
    'raid',
    'battleground',
    'arena',
    'transport',
    'scenario'
);


--
-- Name: observation_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.observation_kind AS ENUM (
    'item_tooltip',
    'item_drop',
    'item_loot',
    'object_loot',
    'vendor_listing',
    'blackmarket_vendor',
    'discovery',
    'creature_spawn',
    'gameobject_spawn',
    'quest_giver',
    'quest_turnin',
    'mystic_enchant_roll',
    'worldforged_observation',
    'spell_cast',
    'trainer_listing'
);


--
-- Name: observation_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.observation_status AS ENUM (
    'pending',
    'queued',
    'merged',
    'rejected',
    'duplicate',
    'conflict'
);


--
-- Name: quest_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.quest_type AS ENUM (
    'normal',
    'group',
    'pvp',
    'raid',
    'dungeon',
    'world_event',
    'legendary',
    'escort',
    'heroic',
    'daily',
    'weekly',
    'repeatable'
);


--
-- Name: quickfact_position; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.quickfact_position AS ENUM (
    'prepend',
    'append'
);


--
-- Name: sound_file_format; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sound_file_format AS ENUM (
    'OGG',
    'MP3'
);


--
-- Name: source_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.source_kind AS ENUM (
    'crafted',
    'drop_npc',
    'drop_object',
    'drop_item',
    'pvp',
    'quest',
    'vendor',
    'trainer',
    'discovery',
    'redemption',
    'talent',
    'starter',
    'event',
    'achievement',
    'misc',
    'black_market',
    'disenchanted',
    'fished',
    'gathered',
    'milled',
    'mined',
    'prospected',
    'pickpocketed',
    'salvaged',
    'skinned',
    'mystic_enchant',
    'worldforged',
    'random_suffix',
    'random_property'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievement (
    id integer NOT NULL,
    faction smallint DEFAULT 0 NOT NULL,
    map_id integer,
    chain_id smallint DEFAULT 0 NOT NULL,
    chain_pos smallint DEFAULT 0 NOT NULL,
    category_id integer,
    points smallint DEFAULT 0 NOT NULL,
    order_in_group smallint DEFAULT 0 NOT NULL,
    icon_id integer,
    flags integer DEFAULT 0 NOT NULL,
    req_criteria_count smallint DEFAULT 0 NOT NULL,
    ref_achievement_id integer,
    item_extra integer,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    reward text,
    reward_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: achievement_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievement_category (
    id integer NOT NULL,
    parent_cat integer,
    parent_cat2 integer,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: affixed_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.affixed_item (
    id bigint NOT NULL,
    base_item_id integer,
    item_id_observed integer,
    name text,
    icon_id integer,
    item_level smallint DEFAULT 0 NOT NULL,
    quality public.item_quality DEFAULT 'common'::public.item_quality NOT NULL,
    inventory_type public.inventory_type DEFAULT 'non_equip'::public.inventory_type NOT NULL,
    prefix text,
    suffix text,
    rolled_stats jsonb DEFAULT '[]'::jsonb NOT NULL,
    source_label text,
    drop_zone_id integer,
    raw_payload jsonb,
    first_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    confirmation_count integer DEFAULT 1 NOT NULL,
    bisbeard_id text,
    name_norm text GENERATED ALWAYS AS (lower(name)) STORED,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: affixed_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.affixed_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affixed_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.affixed_item_id_seq OWNED BY public.affixed_item.id;


--
-- Name: area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area (
    id integer NOT NULL,
    map_id integer NOT NULL,
    parent_area_id integer,
    flags integer DEFAULT 0 NOT NULL,
    level_min smallint,
    level_max smallint,
    faction_side public.faction_side DEFAULT 'neutral'::public.faction_side NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    exploration_level smallint,
    area_bit integer DEFAULT 0 NOT NULL,
    area_level smallint
);


--
-- Name: areatrigger; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.areatrigger (
    id integer NOT NULL,
    cu_flags integer DEFAULT 0 NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    map_id integer,
    pos_x real NOT NULL,
    pos_y real NOT NULL,
    orientation real DEFAULT 0 NOT NULL,
    name text,
    quest_id integer
);


--
-- Name: blackmarket_listing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blackmarket_listing (
    id bigint NOT NULL,
    vendor_id bigint NOT NULL,
    slot_index smallint NOT NULL,
    item_id integer,
    item_link text,
    item_name text,
    price_copper bigint,
    stack integer DEFAULT 1 NOT NULL,
    num_available integer DEFAULT '-1'::integer NOT NULL,
    extra_costs jsonb DEFAULT '{}'::jsonb NOT NULL,
    first_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: blackmarket_listing_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blackmarket_listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blackmarket_listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blackmarket_listing_id_seq OWNED BY public.blackmarket_listing.id;


--
-- Name: blackmarket_vendor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blackmarket_vendor (
    id bigint NOT NULL,
    realm_id smallint,
    guid text NOT NULL,
    vendor_creature_id integer,
    vendor_name text,
    map_id integer,
    area_id integer,
    coord_x real,
    coord_y real,
    discovery_type smallint,
    status text,
    found_by_player text,
    originator text,
    first_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    raw_payload jsonb
);


--
-- Name: blackmarket_vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blackmarket_vendor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blackmarket_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blackmarket_vendor_id_seq OWNED BY public.blackmarket_vendor.id;


--
-- Name: class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.class (
    id smallint NOT NULL,
    file_string text,
    icon_id integer,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    power_type smallint DEFAULT 0 NOT NULL,
    race_mask integer DEFAULT 0 NOT NULL,
    roles integer DEFAULT 0 NOT NULL,
    weapon_type_mask integer DEFAULT 0 NOT NULL,
    armor_type_mask integer DEFAULT 0 NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    slug public.citext,
    is_ascension_custom boolean DEFAULT false NOT NULL
);


--
-- Name: class_spell; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.class_spell (
    class_id smallint NOT NULL,
    spell_id integer NOT NULL,
    advancement_id integer,
    kind text DEFAULT 'ability'::text NOT NULL,
    tab text,
    tier smallint DEFAULT 0 NOT NULL,
    col smallint DEFAULT 0 NOT NULL,
    req_level smallint
);


--
-- Name: craft_recipe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.craft_recipe (
    spell_id integer NOT NULL,
    item_id integer,
    num_result smallint DEFAULT 1 NOT NULL,
    profession text,
    reagents jsonb DEFAULT '[]'::jsonb NOT NULL,
    source text DEFAULT 'tsm'::text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: creature; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature (
    id integer NOT NULL,
    cu_flags integer DEFAULT 0 NOT NULL,
    difficulty_entries integer[] DEFAULT '{}'::integer[] NOT NULL,
    kill_credits integer[] DEFAULT '{}'::integer[] NOT NULL,
    display_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    texture_string text,
    icon_string text,
    model_id integer DEFAULT 0 NOT NULL,
    is_humanoid boolean DEFAULT false NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    sub_name text,
    sub_name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    min_level smallint DEFAULT 1 NOT NULL,
    max_level smallint DEFAULT 1 NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    faction_id integer,
    npc_flags integer DEFAULT 0 NOT NULL,
    rank smallint DEFAULT 0 NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    type_flags integer DEFAULT 0 NOT NULL,
    family smallint DEFAULT 0 NOT NULL,
    unit_class smallint DEFAULT 0 NOT NULL,
    unit_flags integer DEFAULT 0 NOT NULL,
    unit_flags2 integer DEFAULT 0 NOT NULL,
    dynamic_flags integer DEFAULT 0 NOT NULL,
    flags_extra integer DEFAULT 0 NOT NULL,
    racial_leader boolean DEFAULT false NOT NULL,
    mechanic_immune_mask integer DEFAULT 0 NOT NULL,
    school_immune_mask integer DEFAULT 0 NOT NULL,
    dmg_school smallint DEFAULT 0 NOT NULL,
    dmg_multiplier real DEFAULT 1 NOT NULL,
    atk_speed_ms integer DEFAULT 0 NOT NULL,
    rng_atk_speed_ms integer DEFAULT 0 NOT NULL,
    mle_variance real DEFAULT 1 NOT NULL,
    rng_variance real DEFAULT 1 NOT NULL,
    dmg_min real DEFAULT 0 NOT NULL,
    dmg_max real DEFAULT 0 NOT NULL,
    mle_atk_pwr_min integer DEFAULT 0 NOT NULL,
    mle_atk_pwr_max integer DEFAULT 0 NOT NULL,
    rng_atk_pwr_min integer DEFAULT 0 NOT NULL,
    rng_atk_pwr_max integer DEFAULT 0 NOT NULL,
    loot_id integer,
    pickpocket_loot_id integer,
    skin_loot_id integer,
    min_gold integer DEFAULT 0 NOT NULL,
    max_gold integer DEFAULT 0 NOT NULL,
    health_min integer DEFAULT 1 NOT NULL,
    health_max integer DEFAULT 1 NOT NULL,
    mana_min integer DEFAULT 0 NOT NULL,
    mana_max integer DEFAULT 0 NOT NULL,
    armor_min integer DEFAULT 1 NOT NULL,
    armor_max integer DEFAULT 1 NOT NULL,
    resistances integer[] DEFAULT '{0,0,0,0,0,0}'::integer[] NOT NULL,
    trainer_type smallint DEFAULT 0 NOT NULL,
    trainer_requirement integer DEFAULT 0 NOT NULL,
    spells integer[] DEFAULT '{}'::integer[] NOT NULL,
    pet_spell_data_id integer,
    vehicle_id integer,
    script_or_ai text,
    string_id text,
    name_norm text GENERATED ALWAYS AS (lower(name)) STORED,
    faction_template_id integer DEFAULT 0 NOT NULL,
    attack_power integer DEFAULT 0 NOT NULL
);


--
-- Name: creature_difficulty; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_difficulty (
    entry integer NOT NULL,
    difficulty_1 integer,
    difficulty_2 integer,
    difficulty_3 integer
);


--
-- Name: creature_family; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_family (
    id integer NOT NULL,
    name text,
    skill_line integer DEFAULT 0 NOT NULL,
    skill_line_2 integer DEFAULT 0 NOT NULL,
    pet_food_mask integer DEFAULT 0 NOT NULL,
    pet_talent_type integer DEFAULT '-1'::integer NOT NULL,
    category_enum_id integer DEFAULT 0 NOT NULL,
    icon text
);


--
-- Name: creature_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_loot (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    chance real DEFAULT 100 NOT NULL,
    mincountorref integer DEFAULT 1 NOT NULL,
    maxcount integer DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL,
    lootcondition_id integer,
    quest_required boolean DEFAULT false NOT NULL,
    reference_id integer DEFAULT 0 NOT NULL
);


--
-- Name: creature_onkill_reputation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_onkill_reputation (
    creature_id integer NOT NULL,
    faction_id integer NOT NULL,
    rep_change smallint DEFAULT 0 NOT NULL
);


--
-- Name: creature_quest_ends; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_quest_ends (
    id integer NOT NULL,
    quest_id integer NOT NULL
);


--
-- Name: creature_quest_starts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_quest_starts (
    id integer NOT NULL,
    quest_id integer NOT NULL
);


--
-- Name: creature_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_search (
    creature_id integer NOT NULL,
    locale smallint NOT NULL,
    n_name text,
    n_subname text
);


--
-- Name: creature_spawn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_spawn (
    guid bigint NOT NULL,
    entry integer NOT NULL,
    map_id integer NOT NULL,
    zone_id integer,
    area_id integer,
    x double precision,
    y double precision,
    z double precision,
    spawnmask smallint,
    phasemask integer,
    zone_x_pct real,
    zone_y_pct real
);


--
-- Name: creature_spell_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_spell_data (
    id integer NOT NULL,
    spells integer[] DEFAULT '{}'::integer[] NOT NULL
);


--
-- Name: creature_waypoint; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creature_waypoint (
    creature_or_path integer NOT NULL,
    point smallint NOT NULL,
    area_id integer NOT NULL,
    floor smallint DEFAULT '-1'::integer NOT NULL,
    pos_x real NOT NULL,
    pos_y real NOT NULL,
    wait_ms integer DEFAULT 0 NOT NULL
);


--
-- Name: currency; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.currency (
    id integer NOT NULL,
    category integer DEFAULT 0 NOT NULL,
    icon_id integer,
    item_id integer,
    cap integer DEFAULT 0 NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: dbversion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dbversion (
    applied_at timestamp with time zone DEFAULT now() NOT NULL,
    part smallint DEFAULT 1 NOT NULL,
    version text NOT NULL,
    notes text
);


--
-- Name: disenchant_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.disenchant_loot (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    chance numeric(7,4) DEFAULT 100 NOT NULL,
    mincount smallint DEFAULT 1 NOT NULL,
    maxcount smallint DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL
);


--
-- Name: dungeon_boss_extra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dungeon_boss_extra (
    map_id integer NOT NULL,
    creature_id integer NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    optional boolean DEFAULT false NOT NULL
);


--
-- Name: event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event (
    id integer NOT NULL,
    holiday_id integer,
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    occurrence_secs integer DEFAULT 0 NOT NULL,
    length_secs integer DEFAULT 0 NOT NULL,
    requires text,
    description text
);


--
-- Name: faction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faction (
    id integer NOT NULL,
    rep_index smallint DEFAULT '-1'::integer NOT NULL,
    side public.faction_side DEFAULT 'neutral'::public.faction_side NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    parent_faction_id integer,
    base_rep jsonb DEFAULT '[]'::jsonb NOT NULL,
    spillover_in real DEFAULT 0 NOT NULL,
    spillover_out real DEFAULT 0 NOT NULL,
    spillover_max_rank smallint DEFAULT 0 NOT NULL,
    qm_npc_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    template_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: faction_template; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faction_template (
    id integer NOT NULL,
    faction_id integer NOT NULL,
    alliance smallint DEFAULT 0 NOT NULL,
    horde smallint DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    faction_group integer DEFAULT 0 NOT NULL,
    friend_group integer DEFAULT 0 NOT NULL,
    enemy_group integer DEFAULT 0 NOT NULL,
    enemies integer[] DEFAULT '{}'::integer[] NOT NULL,
    friends integer[] DEFAULT '{}'::integer[] NOT NULL
);


--
-- Name: fishing_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fishing_loot (
    area_id integer NOT NULL,
    item_id integer NOT NULL,
    chance numeric(7,4) DEFAULT 100 NOT NULL,
    mincount smallint DEFAULT 1 NOT NULL,
    maxcount smallint DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL,
    reference_id integer DEFAULT 0 NOT NULL
);


--
-- Name: gameobject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gameobject (
    id integer NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    type_cat smallint DEFAULT 0 NOT NULL,
    event_id integer,
    display_id integer DEFAULT 0 NOT NULL,
    faction_id integer,
    flags integer DEFAULT 0 NOT NULL,
    cu_flags integer DEFAULT 0 NOT NULL,
    loot_id integer,
    lock_id integer DEFAULT 0 NOT NULL,
    req_skill integer,
    page_text_id integer,
    linked_trap_id integer,
    req_quest_id integer,
    spell_focus_id integer,
    on_use_spell_id integer,
    on_success_spell_id integer,
    aura_spell_id integer,
    triggered_spell_id integer,
    misc_info text,
    script_or_ai text,
    string_id text,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    name_norm text GENERATED ALWAYS AS (lower(name)) STORED
);


--
-- Name: gameobject_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gameobject_loot (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    chance numeric(7,4) DEFAULT 100 NOT NULL,
    mincount smallint DEFAULT 1 NOT NULL,
    maxcount smallint DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL,
    quest_required boolean DEFAULT false NOT NULL,
    reference_id integer DEFAULT 0 NOT NULL
);


--
-- Name: gameobject_quest_ends; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gameobject_quest_ends (
    id integer NOT NULL,
    quest_id integer NOT NULL
);


--
-- Name: gameobject_quest_starts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gameobject_quest_starts (
    id integer NOT NULL,
    quest_id integer NOT NULL
);


--
-- Name: gameobject_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gameobject_search (
    gameobject_id integer NOT NULL,
    locale smallint NOT NULL,
    n_name text
);


--
-- Name: gameobject_spawn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gameobject_spawn (
    guid bigint NOT NULL,
    entry integer NOT NULL,
    map_id integer NOT NULL,
    zone_id integer,
    area_id integer,
    x double precision,
    y double precision,
    z double precision,
    spawnmask smallint,
    phasemask integer,
    zone_x_pct real,
    zone_y_pct real
);


--
-- Name: glyphproperties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.glyphproperties (
    id integer NOT NULL,
    spell_id integer,
    type_flags smallint DEFAULT 0 NOT NULL,
    icon_id integer
);


--
-- Name: holiday; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.holiday (
    id integer NOT NULL,
    boss_creature_id integer,
    achievement_cat_or_id integer,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    looping boolean DEFAULT true NOT NULL,
    schedule_type smallint DEFAULT 0 NOT NULL,
    icon_id integer,
    texture_string text
);


--
-- Name: icon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.icon (
    id integer NOT NULL,
    name text NOT NULL,
    name_source text
);


--
-- Name: item_character_creation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_character_creation (
    item_id integer NOT NULL,
    class_id smallint NOT NULL
);


--
-- Name: item_crafted_by; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_crafted_by (
    recipe_item_id integer,
    spell_id integer NOT NULL,
    crafted_item_id integer NOT NULL
);


--
-- Name: item_dbc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_dbc (
    id integer NOT NULL,
    class smallint NOT NULL,
    sub_class smallint NOT NULL,
    display_id integer DEFAULT 0 NOT NULL,
    inventory_type smallint DEFAULT 0 NOT NULL,
    sheath smallint DEFAULT 0 NOT NULL
);


--
-- Name: item_display_info; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_display_info (
    display_id integer NOT NULL,
    icon_name text NOT NULL
);


--
-- Name: item_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_loot (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    chance numeric(7,4) DEFAULT 100 NOT NULL,
    mincount smallint DEFAULT 1 NOT NULL,
    maxcount smallint DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL,
    quest_required boolean DEFAULT false NOT NULL,
    reference_id integer DEFAULT 0 NOT NULL
);


--
-- Name: item_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_stats (
    item_id integer NOT NULL,
    nsockets smallint DEFAULT 0 NOT NULL,
    dps real,
    speed real,
    damage_type smallint,
    str integer DEFAULT 0 NOT NULL,
    agi integer DEFAULT 0 NOT NULL,
    sta integer DEFAULT 0 NOT NULL,
    int_ integer DEFAULT 0 NOT NULL,
    spi integer DEFAULT 0 NOT NULL,
    crit_rating integer DEFAULT 0 NOT NULL,
    hit_rating integer DEFAULT 0 NOT NULL,
    haste_rating integer DEFAULT 0 NOT NULL,
    expertise integer DEFAULT 0 NOT NULL,
    armor_pen integer DEFAULT 0 NOT NULL,
    mastery_rating integer DEFAULT 0 NOT NULL,
    resilience integer DEFAULT 0 NOT NULL,
    armor integer DEFAULT 0 NOT NULL,
    defense integer DEFAULT 0 NOT NULL,
    dodge_rating integer DEFAULT 0 NOT NULL,
    parry_rating integer DEFAULT 0 NOT NULL,
    block_rating integer DEFAULT 0 NOT NULL,
    block_value integer DEFAULT 0 NOT NULL,
    attack_power integer DEFAULT 0 NOT NULL,
    spell_power integer DEFAULT 0 NOT NULL,
    spell_pen integer DEFAULT 0 NOT NULL,
    mp5 integer DEFAULT 0 NOT NULL,
    hp5 integer DEFAULT 0 NOT NULL,
    res_holy integer DEFAULT 0 NOT NULL,
    res_fire integer DEFAULT 0 NOT NULL,
    res_nature integer DEFAULT 0 NOT NULL,
    res_frost integer DEFAULT 0 NOT NULL,
    res_shadow integer DEFAULT 0 NOT NULL,
    res_arcane integer DEFAULT 0 NOT NULL,
    spell_power_holy integer DEFAULT 0 NOT NULL,
    spell_power_fire integer DEFAULT 0 NOT NULL,
    spell_power_nature integer DEFAULT 0 NOT NULL,
    spell_power_frost integer DEFAULT 0 NOT NULL,
    spell_power_shadow integer DEFAULT 0 NOT NULL,
    spell_power_arcane integer DEFAULT 0 NOT NULL
);


--
-- Name: itemenchantment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.itemenchantment (
    id integer NOT NULL,
    charges smallint DEFAULT 0 NOT NULL,
    proc_chance smallint DEFAULT 0 NOT NULL,
    ppm_rate real DEFAULT 0 NOT NULL,
    types smallint[] DEFAULT '{}'::smallint[] NOT NULL,
    amounts integer[] DEFAULT '{}'::integer[] NOT NULL,
    objects integer[] DEFAULT '{}'::integer[] NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    condition_id smallint,
    skill_line_id integer,
    skill_level smallint DEFAULT 0 NOT NULL,
    required_level smallint DEFAULT 0 NOT NULL
);


--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    id integer NOT NULL,
    class smallint DEFAULT 0 NOT NULL,
    sub_class smallint DEFAULT 0 NOT NULL,
    sub_sub_class smallint DEFAULT 0 NOT NULL,
    sound_override_subclass smallint,
    quality public.item_quality DEFAULT 'common'::public.item_quality NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    flags_extra integer DEFAULT 0 NOT NULL,
    flags_custom integer DEFAULT 0 NOT NULL,
    cu_flags integer DEFAULT 0 NOT NULL,
    inventory_type public.inventory_type DEFAULT 'non_equip'::public.inventory_type NOT NULL,
    bonding public.item_bonding DEFAULT 'none'::public.item_bonding NOT NULL,
    item_level smallint DEFAULT 0 NOT NULL,
    required_level smallint DEFAULT 0 NOT NULL,
    required_class integer DEFAULT 0 NOT NULL,
    required_race integer DEFAULT 0 NOT NULL,
    required_skill integer,
    required_skill_rank smallint DEFAULT 0 NOT NULL,
    required_spell integer,
    required_honor_rank integer DEFAULT 0 NOT NULL,
    required_city_rank integer DEFAULT 0 NOT NULL,
    required_faction_id integer,
    required_faction_rank smallint DEFAULT 0 NOT NULL,
    required_disenchant_skill smallint DEFAULT '-1'::integer NOT NULL,
    max_count integer DEFAULT 0 NOT NULL,
    stackable integer DEFAULT 1 NOT NULL,
    container_slots smallint DEFAULT 0 NOT NULL,
    bag_family integer DEFAULT 0 NOT NULL,
    totem_category integer DEFAULT 0 NOT NULL,
    icon_id integer,
    display_id integer DEFAULT 0 NOT NULL,
    spell_visual_id integer DEFAULT 0 NOT NULL,
    material smallint DEFAULT 0 NOT NULL,
    sheath smallint DEFAULT 0 NOT NULL,
    page_text_id integer DEFAULT 0 NOT NULL,
    language_id smallint DEFAULT 0 NOT NULL,
    food_type smallint DEFAULT 0 NOT NULL,
    duration integer DEFAULT 0 NOT NULL,
    item_limit_category smallint DEFAULT 0 NOT NULL,
    holiday_id integer,
    script_name text DEFAULT ''::text NOT NULL,
    model text,
    buy_count smallint DEFAULT 1 NOT NULL,
    buy_price integer DEFAULT 0 NOT NULL,
    sell_price integer DEFAULT 0 NOT NULL,
    repair_price integer DEFAULT 0 NOT NULL,
    stats jsonb DEFAULT '[]'::jsonb NOT NULL,
    scaling_stat_distribution smallint DEFAULT 0 NOT NULL,
    scaling_stat_value integer DEFAULT 0 NOT NULL,
    damage jsonb DEFAULT '[]'::jsonb NOT NULL,
    delay_ms integer DEFAULT 1000 NOT NULL,
    armor integer DEFAULT 0 NOT NULL,
    armor_damage_modifier real DEFAULT 0 NOT NULL,
    block integer DEFAULT 0 NOT NULL,
    res_holy smallint DEFAULT 0 NOT NULL,
    res_fire smallint DEFAULT 0 NOT NULL,
    res_nature smallint DEFAULT 0 NOT NULL,
    res_frost smallint DEFAULT 0 NOT NULL,
    res_shadow smallint DEFAULT 0 NOT NULL,
    res_arcane smallint DEFAULT 0 NOT NULL,
    ammo_type smallint DEFAULT 0 NOT NULL,
    ranged_mod_range real DEFAULT 0 NOT NULL,
    durability smallint DEFAULT 0 NOT NULL,
    spells jsonb DEFAULT '[]'::jsonb NOT NULL,
    sockets jsonb DEFAULT '[]'::jsonb NOT NULL,
    socket_bonus integer DEFAULT 0 NOT NULL,
    gem_color_mask integer DEFAULT 0 NOT NULL,
    gem_enchantment_id integer,
    disenchant_id integer DEFAULT 0 NOT NULL,
    random_property_id integer,
    random_suffix_id integer,
    random_enchant integer DEFAULT 0 NOT NULL,
    itemset integer,
    area_id integer,
    map_id integer,
    start_quest_id integer,
    lock_id integer DEFAULT 0 NOT NULL,
    pick_up_sound_id integer,
    drop_down_sound_id integer,
    sheathe_sound_id integer,
    unsheathe_sound_id integer,
    min_money_loot integer DEFAULT 0 NOT NULL,
    max_money_loot integer DEFAULT 0 NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    version_tag public.item_version_tag DEFAULT 'unspecified'::public.item_version_tag NOT NULL,
    phase smallint,
    drop_rate text,
    source_label text,
    source_category text,
    classes text[] DEFAULT '{}'::text[] NOT NULL,
    raw_payload jsonb,
    first_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    last_updated_at timestamp with time zone DEFAULT now() NOT NULL,
    name_norm text GENERATED ALWAYS AS (lower(name)) STORED,
    worldforged boolean DEFAULT false NOT NULL,
    taught_spell_id integer,
    wf_base_item_id integer,
    worldforged_tier smallint
);


--
-- Name: items_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items_search (
    item_id integer NOT NULL,
    locale smallint NOT NULL,
    n_name text,
    n_description text,
    n_effects text
);


--
-- Name: itemset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.itemset (
    id integer NOT NULL,
    ref_set_id integer,
    quality public.item_quality DEFAULT 'common'::public.item_quality NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    content_group smallint DEFAULT 0 NOT NULL,
    npieces smallint DEFAULT 0 NOT NULL,
    min_level smallint DEFAULT 0 NOT NULL,
    max_level smallint DEFAULT 0 NOT NULL,
    req_level smallint DEFAULT 0 NOT NULL,
    class_mask integer DEFAULT 0 NOT NULL,
    skill_id integer,
    skill_level smallint DEFAULT 0 NOT NULL,
    heroic boolean DEFAULT false NOT NULL,
    event_id integer,
    item_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    bonus_spells integer[] DEFAULT '{}'::integer[] NOT NULL,
    bonus_thresholds smallint[] DEFAULT '{}'::smallint[] NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    bonus_text text,
    bonus_text_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: lfg_dungeon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lfg_dungeon (
    id integer NOT NULL,
    name text NOT NULL,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    min_level smallint DEFAULT 0 NOT NULL,
    max_level smallint DEFAULT 0 NOT NULL,
    target_level smallint DEFAULT 0 NOT NULL,
    map_id integer,
    difficulty smallint DEFAULT 0 NOT NULL,
    type_cat smallint DEFAULT 0 NOT NULL,
    faction smallint DEFAULT '-1'::integer NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    group_id integer DEFAULT 0 NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    flags integer DEFAULT 0 NOT NULL
);


--
-- Name: locale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locale (
    id smallint NOT NULL,
    code text NOT NULL,
    name text NOT NULL
);


--
-- Name: loot_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.loot_link (
    id bigint NOT NULL,
    npc_id integer NOT NULL,
    object_id integer NOT NULL,
    difficulty public.instance_difficulty DEFAULT 'normal'::public.instance_difficulty NOT NULL,
    priority smallint DEFAULT 0 NOT NULL,
    encounter_id integer DEFAULT 0 NOT NULL
);


--
-- Name: loot_link_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.loot_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: loot_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.loot_link_id_seq OWNED BY public.loot_link.id;


--
-- Name: loot_template; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.loot_template (
    id bigint NOT NULL,
    loot_id integer NOT NULL,
    item_id integer NOT NULL,
    chance real DEFAULT 100 NOT NULL,
    quest_required boolean DEFAULT false NOT NULL,
    lootmode integer DEFAULT 1 NOT NULL,
    group_id smallint DEFAULT 0 NOT NULL,
    min_count integer DEFAULT 1 NOT NULL,
    max_count integer DEFAULT 1 NOT NULL,
    reference_id integer DEFAULT 0 NOT NULL,
    comment text
);


--
-- Name: loot_template_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.loot_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: loot_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.loot_template_id_seq OWNED BY public.loot_template.id;


--
-- Name: map; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.map (
    id integer NOT NULL,
    directory text,
    type public.map_type DEFAULT 'world'::public.map_type NOT NULL,
    is_battleground boolean DEFAULT false NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    instance_type smallint,
    flags integer DEFAULT 0 NOT NULL,
    max_players smallint
);


--
-- Name: mind_of_ascension_talent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mind_of_ascension_talent (
    id integer NOT NULL,
    tree_id smallint NOT NULL,
    "row" smallint NOT NULL,
    col smallint NOT NULL,
    max_rank smallint DEFAULT 1 NOT NULL,
    spell_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    parent_talent_id integer,
    parent_required_rank smallint DEFAULT 0 NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    icon_id integer,
    raw_payload jsonb
);


--
-- Name: mind_of_ascension_tree; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mind_of_ascension_tree (
    id smallint NOT NULL,
    slug public.citext NOT NULL,
    name text NOT NULL,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    icon_id integer,
    role_hint text
);


--
-- Name: mind_of_ascension_tree_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mind_of_ascension_tree_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mind_of_ascension_tree_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mind_of_ascension_tree_id_seq OWNED BY public.mind_of_ascension_tree.id;


--
-- Name: mystic_enchant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mystic_enchant (
    id integer NOT NULL,
    item_id integer,
    spell_id integer,
    scroll_name text NOT NULL,
    class_filter text,
    quality public.item_quality DEFAULT 'common'::public.item_quality NOT NULL,
    tier text,
    req_level smallint DEFAULT 0 NOT NULL,
    effect_text text,
    tooltip_text text,
    prerequisites text[] DEFAULT '{}'::text[] NOT NULL,
    is_crossover boolean DEFAULT false NOT NULL,
    is_collected_default boolean DEFAULT false NOT NULL,
    raw_payload jsonb,
    fetched_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: npc_trainer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.npc_trainer (
    entry integer NOT NULL,
    spell_id integer NOT NULL,
    money_cost integer DEFAULT 0 NOT NULL,
    req_skill integer DEFAULT 0 NOT NULL,
    req_skill_value smallint DEFAULT 0 NOT NULL,
    req_level smallint DEFAULT 0 NOT NULL
);


--
-- Name: npc_vendor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.npc_vendor (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    maxcount integer DEFAULT 0 NOT NULL,
    incrtime integer DEFAULT 0 NOT NULL,
    extendedcost integer DEFAULT 0 NOT NULL
);


--
-- Name: objectdifficulty; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.objectdifficulty (
    id bigint NOT NULL,
    normal_10 integer,
    normal_25 integer,
    heroic_10 integer,
    heroic_25 integer,
    map_type smallint DEFAULT 0 NOT NULL
);


--
-- Name: objectdifficulty_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.objectdifficulty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: objectdifficulty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.objectdifficulty_id_seq OWNED BY public.objectdifficulty.id;


--
-- Name: pet; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pet (
    id integer NOT NULL,
    category integer DEFAULT 0 NOT NULL,
    cu_flags integer DEFAULT 0 NOT NULL,
    min_level smallint DEFAULT 1 NOT NULL,
    max_level smallint DEFAULT 1 NOT NULL,
    food_mask integer DEFAULT 0 NOT NULL,
    type smallint DEFAULT 0 NOT NULL,
    exotic boolean DEFAULT false NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    icon_id integer,
    skill_line_id integer,
    spell_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    armor integer DEFAULT 0 NOT NULL,
    damage integer DEFAULT 0 NOT NULL,
    health integer DEFAULT 0 NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: pickpocket_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pickpocket_loot (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    chance numeric(7,4) DEFAULT 100 NOT NULL,
    mincount smallint DEFAULT 1 NOT NULL,
    maxcount smallint DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL
);


--
-- Name: quest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quest (
    id integer NOT NULL,
    quest_type public.quest_type DEFAULT 'normal'::public.quest_type NOT NULL,
    level smallint DEFAULT 1 NOT NULL,
    min_level smallint DEFAULT 0 NOT NULL,
    max_level smallint DEFAULT 0 NOT NULL,
    quest_sort_id smallint DEFAULT 0 NOT NULL,
    quest_info_id smallint DEFAULT 0 NOT NULL,
    suggested_players smallint DEFAULT 0 NOT NULL,
    time_limit_secs integer DEFAULT 0 NOT NULL,
    event_id integer,
    prev_quest_id integer,
    next_quest_id integer,
    breadcrumb_for_quest_id integer,
    exclusive_group integer DEFAULT 0 NOT NULL,
    next_quest_id_chain integer,
    flags integer DEFAULT 0 NOT NULL,
    special_flags smallint DEFAULT 0 NOT NULL,
    cu_flags integer DEFAULT 0 NOT NULL,
    req_class_mask integer DEFAULT 0 NOT NULL,
    req_race_mask integer DEFAULT 0 NOT NULL,
    req_skill_id integer,
    req_skill_points smallint DEFAULT 0 NOT NULL,
    req_min_rep jsonb DEFAULT '{}'::jsonb NOT NULL,
    req_max_rep jsonb DEFAULT '{}'::jsonb NOT NULL,
    req_player_kills smallint DEFAULT 0 NOT NULL,
    source_item_id integer,
    source_item_count smallint DEFAULT 0 NOT NULL,
    source_spell_id integer,
    reward_xp integer DEFAULT 0 NOT NULL,
    reward_money integer DEFAULT 0 NOT NULL,
    reward_money_max_level integer DEFAULT 0 NOT NULL,
    reward_spell_id integer,
    reward_spell_cast_id integer,
    reward_honor integer DEFAULT 0 NOT NULL,
    reward_arena_points smallint DEFAULT 0 NOT NULL,
    reward_title_id integer,
    reward_talents smallint DEFAULT 0 NOT NULL,
    reward_mail_template_id integer,
    reward_mail_delay_secs integer,
    reward_items jsonb DEFAULT '[]'::jsonb NOT NULL,
    reward_choice_items jsonb DEFAULT '[]'::jsonb NOT NULL,
    reward_factions jsonb DEFAULT '[]'::jsonb NOT NULL,
    req_npc_or_go jsonb DEFAULT '[]'::jsonb NOT NULL,
    req_source_items jsonb DEFAULT '[]'::jsonb NOT NULL,
    req_items jsonb DEFAULT '[]'::jsonb NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    objectives text,
    objectives_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    details text,
    details_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    end_text text,
    end_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    offer_reward text,
    offer_reward_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    request_items text,
    request_items_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    completed_text text,
    completed_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    objective_texts jsonb DEFAULT '[]'::jsonb NOT NULL,
    name_norm text GENERATED ALWAYS AS (lower(name)) STORED,
    reward_xp_difficulty smallint DEFAULT 0 NOT NULL,
    poi_map_id integer,
    poi_x real,
    poi_y real,
    poi_priority smallint DEFAULT 0 NOT NULL,
    xp_per_level double precision GENERATED ALWAYS AS (((reward_xp)::double precision / (NULLIF(GREATEST((level)::integer, 1), 0))::double precision)) STORED
);


--
-- Name: quest_objective_hotspot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quest_objective_hotspot (
    quest_id integer NOT NULL,
    objective_idx smallint NOT NULL,
    target_kind smallint NOT NULL,
    target_id integer NOT NULL,
    target_name text,
    area_id integer NOT NULL,
    map_id integer,
    cx_pct real,
    cy_pct real,
    spawn_count integer NOT NULL,
    radius_pct real
);


--
-- Name: quest_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quest_search (
    quest_id integer NOT NULL,
    locale smallint NOT NULL,
    n_name text,
    n_objectives text,
    n_details text
);


--
-- Name: quest_startend; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quest_startend (
    type smallint NOT NULL,
    type_id integer NOT NULL,
    quest_id integer NOT NULL,
    method smallint NOT NULL,
    event_id integer
);


--
-- Name: quest_xp; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quest_xp (
    level smallint NOT NULL,
    difficulty smallint NOT NULL,
    xp integer NOT NULL
);


--
-- Name: quickfact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quickfact (
    type smallint NOT NULL,
    type_id integer NOT NULL,
    order_idx smallint NOT NULL,
    "position" public.quickfact_position DEFAULT 'append'::public.quickfact_position NOT NULL,
    body text NOT NULL
);


--
-- Name: race; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.race (
    id smallint NOT NULL,
    class_mask integer DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    faction_id integer,
    start_area_id integer,
    leader_npc_id integer,
    base_language smallint,
    side public.faction_side DEFAULT 'neutral'::public.faction_side NOT NULL,
    file_string text,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL
);


--
-- Name: random_property_pool; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.random_property_pool (
    id integer NOT NULL,
    internal_name text,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    enchant_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    allocation_pct smallint[] DEFAULT '{}'::smallint[] NOT NULL
);


--
-- Name: random_suffix_pool; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.random_suffix_pool (
    id integer NOT NULL,
    internal_name text,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    enchant_ids integer[] DEFAULT '{}'::integer[] NOT NULL,
    allocation_pct smallint[] DEFAULT '{}'::smallint[] NOT NULL,
    item_level_min smallint,
    item_level_max smallint
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id smallint NOT NULL,
    slug public.citext NOT NULL,
    display_name text NOT NULL,
    region text,
    is_active boolean DEFAULT true NOT NULL,
    notes text
);


--
-- Name: reference_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reference_loot (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    chance numeric(7,4) DEFAULT 100 NOT NULL,
    mincount smallint DEFAULT 1 NOT NULL,
    maxcount smallint DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL
);


--
-- Name: shapeshiftform; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shapeshiftform (
    id integer NOT NULL,
    bonus_action_bar smallint DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    creature_type smallint DEFAULT 0 NOT NULL,
    attack_icon_id integer,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: skill_line_ability; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skill_line_ability (
    id integer NOT NULL,
    skill_line_id integer NOT NULL,
    spell_id integer NOT NULL,
    race_mask integer DEFAULT 0 NOT NULL,
    class_mask integer DEFAULT 0 NOT NULL,
    exclude_race integer DEFAULT 0 NOT NULL,
    exclude_class integer DEFAULT 0 NOT NULL,
    min_skill_rank smallint DEFAULT 0 NOT NULL,
    superceded_by_spell integer,
    acquire_method smallint DEFAULT 0 NOT NULL
);


--
-- Name: skillline; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skillline (
    id integer NOT NULL,
    type_cat smallint DEFAULT 0 NOT NULL,
    category_id smallint DEFAULT 0 NOT NULL,
    profession_mask smallint DEFAULT 0 NOT NULL,
    icon_id integer,
    recipe_subclass smallint,
    specializations integer[] DEFAULT '{}'::integer[] NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: skinning_loot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skinning_loot (
    entry integer NOT NULL,
    item_id integer NOT NULL,
    chance numeric(7,4) DEFAULT 100 NOT NULL,
    mincount smallint DEFAULT 1 NOT NULL,
    maxcount smallint DEFAULT 1 NOT NULL,
    groupid smallint DEFAULT 0 NOT NULL
);


--
-- Name: sound; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sound (
    id integer NOT NULL,
    cat smallint DEFAULT 0 NOT NULL,
    name text NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    files text[] DEFAULT '{}'::text[] NOT NULL
);


--
-- Name: sound_file; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sound_file (
    id integer NOT NULL,
    file text NOT NULL,
    path text NOT NULL,
    format public.sound_file_format NOT NULL
);


--
-- Name: source; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.source (
    type smallint NOT NULL,
    type_id integer NOT NULL,
    more_type smallint,
    more_type_id integer,
    more_zone_id integer,
    more_mask integer,
    sources public.source_kind[] DEFAULT '{}'::public.source_kind[] NOT NULL
);


--
-- Name: spawn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spawn (
    guid bigint NOT NULL,
    type smallint NOT NULL,
    type_id integer NOT NULL,
    respawn_secs integer DEFAULT 0 NOT NULL,
    spawn_mask smallint DEFAULT 0 NOT NULL,
    phase_mask integer DEFAULT 0 NOT NULL,
    area_id integer,
    floor smallint DEFAULT 0 NOT NULL,
    pos_x real NOT NULL,
    pos_y real NOT NULL,
    pos_z real,
    path_id integer DEFAULT 0 NOT NULL,
    script_name text,
    string_id text
);


--
-- Name: spawn_override; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spawn_override (
    type smallint NOT NULL,
    type_guid bigint NOT NULL,
    area_id integer,
    floor smallint DEFAULT 0 NOT NULL,
    revision smallint DEFAULT 0 NOT NULL
);


--
-- Name: spell; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell (
    id integer NOT NULL,
    category integer DEFAULT 0 NOT NULL,
    type_cat smallint DEFAULT 0 NOT NULL,
    dispel_type smallint DEFAULT 0 NOT NULL,
    mechanic smallint DEFAULT 0 NOT NULL,
    attributes integer[] DEFAULT '{}'::integer[] NOT NULL,
    cu_flags integer DEFAULT 0 NOT NULL,
    stance_mask integer DEFAULT 0 NOT NULL,
    stance_mask_not integer DEFAULT 0 NOT NULL,
    targets integer DEFAULT 0 NOT NULL,
    spell_focus_object integer,
    cast_time_ms integer DEFAULT 0 NOT NULL,
    recovery_time_ms integer DEFAULT 0 NOT NULL,
    recovery_category integer DEFAULT 0 NOT NULL,
    gcd_ms integer DEFAULT 0 NOT NULL,
    gcd_category integer DEFAULT 0 NOT NULL,
    proc_chance smallint DEFAULT 0 NOT NULL,
    proc_charges integer DEFAULT 0 NOT NULL,
    proc_custom real DEFAULT 0 NOT NULL,
    proc_cooldown_ms integer DEFAULT 0 NOT NULL,
    duration_ms integer DEFAULT 0 NOT NULL,
    base_level smallint DEFAULT 0 NOT NULL,
    spell_level smallint DEFAULT 0 NOT NULL,
    max_level smallint DEFAULT 0 NOT NULL,
    talent_level smallint DEFAULT 0 NOT NULL,
    power_type smallint DEFAULT 0 NOT NULL,
    power_cost integer DEFAULT 0 NOT NULL,
    power_cost_per_level integer DEFAULT 0 NOT NULL,
    power_cost_percent integer DEFAULT 0 NOT NULL,
    power_per_second integer DEFAULT 0 NOT NULL,
    power_per_second_level integer DEFAULT 0 NOT NULL,
    range_id integer DEFAULT 0 NOT NULL,
    stack_amount integer DEFAULT 0 NOT NULL,
    equipped_item_class smallint DEFAULT 0 NOT NULL,
    equipped_item_subclass_mask integer DEFAULT 0 NOT NULL,
    equipped_item_inventory_mask integer DEFAULT 0 NOT NULL,
    school_mask smallint DEFAULT 0 NOT NULL,
    damage_class smallint DEFAULT 0 NOT NULL,
    spell_family_id smallint DEFAULT 0 NOT NULL,
    spell_family_flags bigint[] DEFAULT '{}'::bigint[] NOT NULL,
    icon_id integer,
    spell_visual_id integer,
    rank_no smallint DEFAULT 0 NOT NULL,
    skill_line_id integer,
    req_race_mask integer DEFAULT 0 NOT NULL,
    req_class_mask integer DEFAULT 0 NOT NULL,
    req_spell_id integer,
    req_skill_level smallint DEFAULT 0 NOT NULL,
    learned_at smallint DEFAULT 0 NOT NULL,
    skill_level_grey smallint DEFAULT 0 NOT NULL,
    skill_level_yellow smallint DEFAULT 0 NOT NULL,
    training_cost integer DEFAULT 0 NOT NULL,
    reagents jsonb DEFAULT '[]'::jsonb NOT NULL,
    effects jsonb DEFAULT '[]'::jsonb NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    rank_text text,
    rank_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    description_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    buff_text text,
    buff_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    name_norm text GENERATED ALWAYS AS (lower(name)) STORED,
    max_targets smallint DEFAULT 0 NOT NULL,
    moa_description text
);


--
-- Name: spell_bonus_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_bonus_data (
    spell_id integer NOT NULL,
    direct_bonus real,
    dot_bonus real,
    ap_bonus real,
    ap_dot_bonus real,
    comments text
);


--
-- Name: spell_cast_times; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_cast_times (
    id integer NOT NULL,
    base_time_ms integer DEFAULT 0 NOT NULL,
    per_level integer DEFAULT 0 NOT NULL,
    min_time_ms integer DEFAULT 0 NOT NULL
);


--
-- Name: spell_difficulty; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_difficulty (
    id integer NOT NULL,
    normal_10 integer,
    normal_25 integer,
    heroic_10 integer,
    heroic_25 integer,
    map_type smallint DEFAULT 0 NOT NULL
);


--
-- Name: spell_duration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_duration (
    id integer NOT NULL,
    duration integer DEFAULT 0 NOT NULL,
    duration_per_level integer DEFAULT 0 NOT NULL,
    max_duration integer DEFAULT 0 NOT NULL
);


--
-- Name: spell_icon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_icon (
    id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


--
-- Name: spell_radius; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_radius (
    id integer NOT NULL,
    radius real DEFAULT 0 NOT NULL,
    radius_per_level real DEFAULT 0 NOT NULL,
    radius_max real DEFAULT 0 NOT NULL
);


--
-- Name: spell_range; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_range (
    id integer NOT NULL,
    range_min real DEFAULT 0 NOT NULL,
    range_max real DEFAULT 0 NOT NULL,
    range_min_2 real DEFAULT 0 NOT NULL,
    range_max_2 real DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    name text
);


--
-- Name: spell_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.spell_search (
    spell_id integer NOT NULL,
    locale smallint NOT NULL,
    n_name text,
    n_description text,
    n_buff text
);


--
-- Name: talent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.talent (
    id integer NOT NULL,
    rank smallint DEFAULT 0 NOT NULL,
    class_id smallint NOT NULL,
    pet_type_mask smallint DEFAULT 0 NOT NULL,
    tab smallint NOT NULL,
    "row" smallint NOT NULL,
    col smallint NOT NULL,
    spell_id integer NOT NULL
);


--
-- Name: talent_tab; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.talent_tab (
    id smallint NOT NULL,
    class_id smallint,
    name text NOT NULL,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    spell_icon_id integer,
    pet_talent_mask integer DEFAULT 0 NOT NULL,
    order_index smallint DEFAULT 0 NOT NULL,
    raw_class_mask integer DEFAULT 0 NOT NULL
);


--
-- Name: taxinode; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.taxinode (
    id integer NOT NULL,
    map_id integer,
    map_x real NOT NULL,
    map_y real NOT NULL,
    area_id integer,
    area_x real NOT NULL,
    area_y real NOT NULL,
    npc_or_go_kind text NOT NULL,
    type_id integer NOT NULL,
    react_a smallint DEFAULT 0 NOT NULL,
    react_h smallint DEFAULT 0 NOT NULL,
    name text,
    name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT taxinode_npc_or_go_kind_check CHECK ((npc_or_go_kind = ANY (ARRAY['NPC'::text, 'GOBJECT'::text])))
);


--
-- Name: taxipath; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.taxipath (
    id integer NOT NULL,
    start_node_id integer NOT NULL,
    end_node_id integer NOT NULL
);


--
-- Name: title; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.title (
    id integer NOT NULL,
    category smallint DEFAULT 0 NOT NULL,
    gender smallint DEFAULT 0 NOT NULL,
    side public.faction_side DEFAULT 'neutral'::public.faction_side NOT NULL,
    expansion smallint DEFAULT 0 NOT NULL,
    bit_idx smallint DEFAULT 0 NOT NULL,
    event_id integer,
    male_name text,
    male_name_loc jsonb DEFAULT '{}'::jsonb NOT NULL,
    female_name text,
    female_name_loc jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: world_discovery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.world_discovery (
    id bigint NOT NULL,
    realm_id smallint,
    guid text NOT NULL,
    discovery_type smallint,
    map_id integer,
    area_id integer,
    coord_x real,
    coord_y real,
    item_id integer,
    item_quality public.item_quality,
    item_type smallint,
    item_subtype smallint,
    creature_id integer,
    source text,
    status text,
    found_by_player text,
    originator text,
    announce_count integer DEFAULT 0 NOT NULL,
    merge_count integer DEFAULT 1 NOT NULL,
    first_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    raw_payload jsonb
);


--
-- Name: world_discovery_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.world_discovery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: world_discovery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.world_discovery_id_seq OWNED BY public.world_discovery.id;


--
-- Name: world_map_area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.world_map_area (
    id integer NOT NULL,
    map_id integer NOT NULL,
    area_id integer,
    area_name text,
    loc_left real,
    loc_right real,
    loc_top real,
    loc_bottom real
);


--
-- Name: affixed_item id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affixed_item ALTER COLUMN id SET DEFAULT nextval('public.affixed_item_id_seq'::regclass);


--
-- Name: blackmarket_listing id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_listing ALTER COLUMN id SET DEFAULT nextval('public.blackmarket_listing_id_seq'::regclass);


--
-- Name: blackmarket_vendor id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_vendor ALTER COLUMN id SET DEFAULT nextval('public.blackmarket_vendor_id_seq'::regclass);


--
-- Name: loot_link id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loot_link ALTER COLUMN id SET DEFAULT nextval('public.loot_link_id_seq'::regclass);


--
-- Name: loot_template id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loot_template ALTER COLUMN id SET DEFAULT nextval('public.loot_template_id_seq'::regclass);


--
-- Name: mind_of_ascension_tree id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_tree ALTER COLUMN id SET DEFAULT nextval('public.mind_of_ascension_tree_id_seq'::regclass);


--
-- Name: objectdifficulty id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.objectdifficulty ALTER COLUMN id SET DEFAULT nextval('public.objectdifficulty_id_seq'::regclass);


--
-- Name: world_discovery id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_discovery ALTER COLUMN id SET DEFAULT nextval('public.world_discovery_id_seq'::regclass);


--
-- Name: achievement_category achievement_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement_category
    ADD CONSTRAINT achievement_category_pkey PRIMARY KEY (id);


--
-- Name: achievement achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_pkey PRIMARY KEY (id);


--
-- Name: affixed_item affixed_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affixed_item
    ADD CONSTRAINT affixed_item_pkey PRIMARY KEY (id);


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id);


--
-- Name: areatrigger areatrigger_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areatrigger
    ADD CONSTRAINT areatrigger_pkey PRIMARY KEY (id);


--
-- Name: blackmarket_listing blackmarket_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_listing
    ADD CONSTRAINT blackmarket_listing_pkey PRIMARY KEY (id);


--
-- Name: blackmarket_vendor blackmarket_vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_vendor
    ADD CONSTRAINT blackmarket_vendor_pkey PRIMARY KEY (id);


--
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_pkey PRIMARY KEY (id);


--
-- Name: class_spell class_spell_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_spell
    ADD CONSTRAINT class_spell_pkey PRIMARY KEY (class_id, spell_id, kind);


--
-- Name: craft_recipe craft_recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.craft_recipe
    ADD CONSTRAINT craft_recipe_pkey PRIMARY KEY (spell_id);


--
-- Name: creature_difficulty creature_difficulty_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_difficulty
    ADD CONSTRAINT creature_difficulty_pkey PRIMARY KEY (entry);


--
-- Name: creature_family creature_family_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_family
    ADD CONSTRAINT creature_family_pkey PRIMARY KEY (id);


--
-- Name: creature_loot creature_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_loot
    ADD CONSTRAINT creature_loot_pkey PRIMARY KEY (entry, item_id, groupid);


--
-- Name: creature_onkill_reputation creature_onkill_reputation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_onkill_reputation
    ADD CONSTRAINT creature_onkill_reputation_pkey PRIMARY KEY (creature_id, faction_id);


--
-- Name: creature creature_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature
    ADD CONSTRAINT creature_pkey PRIMARY KEY (id);


--
-- Name: creature_quest_ends creature_quest_ends_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_quest_ends
    ADD CONSTRAINT creature_quest_ends_pkey PRIMARY KEY (id, quest_id);


--
-- Name: creature_quest_starts creature_quest_starts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_quest_starts
    ADD CONSTRAINT creature_quest_starts_pkey PRIMARY KEY (id, quest_id);


--
-- Name: creature_search creature_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_search
    ADD CONSTRAINT creature_search_pkey PRIMARY KEY (creature_id, locale);


--
-- Name: creature_spawn creature_spawn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_spawn
    ADD CONSTRAINT creature_spawn_pkey PRIMARY KEY (guid);


--
-- Name: creature_spell_data creature_spell_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_spell_data
    ADD CONSTRAINT creature_spell_data_pkey PRIMARY KEY (id);


--
-- Name: creature_waypoint creature_waypoint_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_waypoint
    ADD CONSTRAINT creature_waypoint_pkey PRIMARY KEY (creature_or_path, point, area_id, floor);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);


--
-- Name: disenchant_loot disenchant_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disenchant_loot
    ADD CONSTRAINT disenchant_loot_pkey PRIMARY KEY (entry, item_id, groupid);


--
-- Name: dungeon_boss_extra dungeon_boss_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dungeon_boss_extra
    ADD CONSTRAINT dungeon_boss_extra_pkey PRIMARY KEY (map_id, creature_id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: faction faction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faction
    ADD CONSTRAINT faction_pkey PRIMARY KEY (id);


--
-- Name: faction_template faction_template_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faction_template
    ADD CONSTRAINT faction_template_pkey PRIMARY KEY (id);


--
-- Name: fishing_loot fishing_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fishing_loot
    ADD CONSTRAINT fishing_loot_pkey PRIMARY KEY (area_id, item_id, groupid);


--
-- Name: gameobject_loot gameobject_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject_loot
    ADD CONSTRAINT gameobject_loot_pkey PRIMARY KEY (entry, item_id, groupid);


--
-- Name: gameobject gameobject_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_pkey PRIMARY KEY (id);


--
-- Name: gameobject_quest_ends gameobject_quest_ends_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject_quest_ends
    ADD CONSTRAINT gameobject_quest_ends_pkey PRIMARY KEY (id, quest_id);


--
-- Name: gameobject_quest_starts gameobject_quest_starts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject_quest_starts
    ADD CONSTRAINT gameobject_quest_starts_pkey PRIMARY KEY (id, quest_id);


--
-- Name: gameobject_search gameobject_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject_search
    ADD CONSTRAINT gameobject_search_pkey PRIMARY KEY (gameobject_id, locale);


--
-- Name: gameobject_spawn gameobject_spawn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject_spawn
    ADD CONSTRAINT gameobject_spawn_pkey PRIMARY KEY (guid);


--
-- Name: glyphproperties glyphproperties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.glyphproperties
    ADD CONSTRAINT glyphproperties_pkey PRIMARY KEY (id);


--
-- Name: holiday holiday_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.holiday
    ADD CONSTRAINT holiday_pkey PRIMARY KEY (id);


--
-- Name: icon icon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.icon
    ADD CONSTRAINT icon_pkey PRIMARY KEY (id);


--
-- Name: item_character_creation item_character_creation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_character_creation
    ADD CONSTRAINT item_character_creation_pkey PRIMARY KEY (item_id);


--
-- Name: item_dbc item_dbc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_dbc
    ADD CONSTRAINT item_dbc_pkey PRIMARY KEY (id);


--
-- Name: item_display_info item_display_info_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_display_info
    ADD CONSTRAINT item_display_info_pkey PRIMARY KEY (display_id);


--
-- Name: item_loot item_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_loot
    ADD CONSTRAINT item_loot_pkey PRIMARY KEY (entry, item_id, groupid);


--
-- Name: item_stats item_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_stats
    ADD CONSTRAINT item_stats_pkey PRIMARY KEY (item_id);


--
-- Name: itemenchantment itemenchantment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.itemenchantment
    ADD CONSTRAINT itemenchantment_pkey PRIMARY KEY (id);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: items_search items_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_search
    ADD CONSTRAINT items_search_pkey PRIMARY KEY (item_id, locale);


--
-- Name: itemset itemset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.itemset
    ADD CONSTRAINT itemset_pkey PRIMARY KEY (id);


--
-- Name: lfg_dungeon lfg_dungeon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lfg_dungeon
    ADD CONSTRAINT lfg_dungeon_pkey PRIMARY KEY (id);


--
-- Name: locale locale_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locale
    ADD CONSTRAINT locale_code_key UNIQUE (code);


--
-- Name: locale locale_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locale
    ADD CONSTRAINT locale_pkey PRIMARY KEY (id);


--
-- Name: loot_link loot_link_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loot_link
    ADD CONSTRAINT loot_link_pkey PRIMARY KEY (id);


--
-- Name: loot_template loot_template_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loot_template
    ADD CONSTRAINT loot_template_pkey PRIMARY KEY (id);


--
-- Name: map map_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.map
    ADD CONSTRAINT map_pkey PRIMARY KEY (id);


--
-- Name: mind_of_ascension_talent mind_of_ascension_talent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_talent
    ADD CONSTRAINT mind_of_ascension_talent_pkey PRIMARY KEY (id);


--
-- Name: mind_of_ascension_tree mind_of_ascension_tree_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_tree
    ADD CONSTRAINT mind_of_ascension_tree_pkey PRIMARY KEY (id);


--
-- Name: mind_of_ascension_tree mind_of_ascension_tree_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_tree
    ADD CONSTRAINT mind_of_ascension_tree_slug_key UNIQUE (slug);


--
-- Name: mystic_enchant mystic_enchant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mystic_enchant
    ADD CONSTRAINT mystic_enchant_pkey PRIMARY KEY (id);


--
-- Name: npc_trainer npc_trainer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.npc_trainer
    ADD CONSTRAINT npc_trainer_pkey PRIMARY KEY (entry, spell_id);


--
-- Name: npc_vendor npc_vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.npc_vendor
    ADD CONSTRAINT npc_vendor_pkey PRIMARY KEY (entry, item_id, extendedcost);


--
-- Name: objectdifficulty objectdifficulty_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.objectdifficulty
    ADD CONSTRAINT objectdifficulty_pkey PRIMARY KEY (id);


--
-- Name: pet pet_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pet
    ADD CONSTRAINT pet_pkey PRIMARY KEY (id);


--
-- Name: pickpocket_loot pickpocket_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pickpocket_loot
    ADD CONSTRAINT pickpocket_loot_pkey PRIMARY KEY (entry, item_id, groupid);


--
-- Name: quest_objective_hotspot quest_objective_hotspot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_objective_hotspot
    ADD CONSTRAINT quest_objective_hotspot_pkey PRIMARY KEY (quest_id, objective_idx, target_id, area_id);


--
-- Name: quest quest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_pkey PRIMARY KEY (id);


--
-- Name: quest_search quest_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_search
    ADD CONSTRAINT quest_search_pkey PRIMARY KEY (quest_id, locale);


--
-- Name: quest_startend quest_startend_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_startend
    ADD CONSTRAINT quest_startend_pkey PRIMARY KEY (type, type_id, quest_id);


--
-- Name: quest_xp quest_xp_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_xp
    ADD CONSTRAINT quest_xp_pkey PRIMARY KEY (level, difficulty);


--
-- Name: quickfact quickfact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quickfact
    ADD CONSTRAINT quickfact_pkey PRIMARY KEY (type, type_id, order_idx);


--
-- Name: race race_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_pkey PRIMARY KEY (id);


--
-- Name: random_property_pool random_property_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.random_property_pool
    ADD CONSTRAINT random_property_pool_pkey PRIMARY KEY (id);


--
-- Name: random_suffix_pool random_suffix_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.random_suffix_pool
    ADD CONSTRAINT random_suffix_pool_pkey PRIMARY KEY (id);


--
-- Name: realm realm_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT realm_pkey PRIMARY KEY (id);


--
-- Name: realm realm_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT realm_slug_key UNIQUE (slug);


--
-- Name: reference_loot reference_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reference_loot
    ADD CONSTRAINT reference_loot_pkey PRIMARY KEY (entry, item_id, groupid);


--
-- Name: shapeshiftform shapeshiftform_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shapeshiftform
    ADD CONSTRAINT shapeshiftform_pkey PRIMARY KEY (id);


--
-- Name: skill_line_ability skill_line_ability_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_line_ability
    ADD CONSTRAINT skill_line_ability_pkey PRIMARY KEY (id);


--
-- Name: skillline skillline_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skillline
    ADD CONSTRAINT skillline_pkey PRIMARY KEY (id);


--
-- Name: skinning_loot skinning_loot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skinning_loot
    ADD CONSTRAINT skinning_loot_pkey PRIMARY KEY (entry, item_id, groupid);


--
-- Name: sound_file sound_file_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sound_file
    ADD CONSTRAINT sound_file_pkey PRIMARY KEY (id);


--
-- Name: sound sound_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sound
    ADD CONSTRAINT sound_pkey PRIMARY KEY (id);


--
-- Name: source source_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.source
    ADD CONSTRAINT source_pkey PRIMARY KEY (type, type_id);


--
-- Name: spawn_override spawn_override_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spawn_override
    ADD CONSTRAINT spawn_override_pkey PRIMARY KEY (type, type_guid);


--
-- Name: spawn spawn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spawn
    ADD CONSTRAINT spawn_pkey PRIMARY KEY (guid, type, floor);


--
-- Name: spell_bonus_data spell_bonus_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_bonus_data
    ADD CONSTRAINT spell_bonus_data_pkey PRIMARY KEY (spell_id);


--
-- Name: spell_cast_times spell_cast_times_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_cast_times
    ADD CONSTRAINT spell_cast_times_pkey PRIMARY KEY (id);


--
-- Name: spell_difficulty spell_difficulty_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_difficulty
    ADD CONSTRAINT spell_difficulty_pkey PRIMARY KEY (id);


--
-- Name: spell_duration spell_duration_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_duration
    ADD CONSTRAINT spell_duration_pkey PRIMARY KEY (id);


--
-- Name: spell_icon spell_icon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_icon
    ADD CONSTRAINT spell_icon_pkey PRIMARY KEY (id);


--
-- Name: spell spell_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell
    ADD CONSTRAINT spell_pkey PRIMARY KEY (id);


--
-- Name: spell_radius spell_radius_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_radius
    ADD CONSTRAINT spell_radius_pkey PRIMARY KEY (id);


--
-- Name: spell_range spell_range_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_range
    ADD CONSTRAINT spell_range_pkey PRIMARY KEY (id);


--
-- Name: spell_search spell_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_search
    ADD CONSTRAINT spell_search_pkey PRIMARY KEY (spell_id, locale);


--
-- Name: talent talent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.talent
    ADD CONSTRAINT talent_pkey PRIMARY KEY (id, rank);


--
-- Name: talent_tab talent_tab_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.talent_tab
    ADD CONSTRAINT talent_tab_pkey PRIMARY KEY (id);


--
-- Name: taxinode taxinode_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taxinode
    ADD CONSTRAINT taxinode_pkey PRIMARY KEY (id);


--
-- Name: taxipath taxipath_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taxipath
    ADD CONSTRAINT taxipath_pkey PRIMARY KEY (id);


--
-- Name: title title_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.title
    ADD CONSTRAINT title_pkey PRIMARY KEY (id);


--
-- Name: world_discovery world_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_discovery
    ADD CONSTRAINT world_discovery_pkey PRIMARY KEY (id);


--
-- Name: world_map_area world_map_area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_map_area
    ADD CONSTRAINT world_map_area_pkey PRIMARY KEY (id);


--
-- Name: achievement_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX achievement_category_idx ON public.achievement USING btree (category_id) WHERE (category_id IS NOT NULL);


--
-- Name: achievement_map_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX achievement_map_idx ON public.achievement USING btree (map_id) WHERE (map_id IS NOT NULL);


--
-- Name: affixed_base_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX affixed_base_item_idx ON public.affixed_item USING btree (base_item_id) WHERE (base_item_id IS NOT NULL);


--
-- Name: affixed_bisbeard_id_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX affixed_bisbeard_id_uniq ON public.affixed_item USING btree (bisbeard_id) WHERE (bisbeard_id IS NOT NULL);


--
-- Name: affixed_item_observed_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX affixed_item_observed_id_idx ON public.affixed_item USING btree (item_id_observed) WHERE (item_id_observed IS NOT NULL);


--
-- Name: affixed_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX affixed_name_idx ON public.affixed_item USING btree (name_norm);


--
-- Name: affixed_name_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX affixed_name_trgm_idx ON public.affixed_item USING gin (name public.gin_trgm_ops);


--
-- Name: affixed_quality_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX affixed_quality_idx ON public.affixed_item USING btree (quality);


--
-- Name: affixed_stats_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX affixed_stats_gin ON public.affixed_item USING gin (rolled_stats jsonb_path_ops);


--
-- Name: affixed_zone_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX affixed_zone_idx ON public.affixed_item USING btree (drop_zone_id) WHERE (drop_zone_id IS NOT NULL);


--
-- Name: area_map_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX area_map_idx ON public.area USING btree (map_id);


--
-- Name: area_name_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX area_name_trgm_idx ON public.area USING gin (name public.gin_trgm_ops);


--
-- Name: area_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX area_parent_idx ON public.area USING btree (parent_area_id) WHERE (parent_area_id IS NOT NULL);


--
-- Name: areatrigger_quest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX areatrigger_quest_idx ON public.areatrigger USING btree (quest_id) WHERE (quest_id IS NOT NULL);


--
-- Name: areatrigger_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX areatrigger_type_idx ON public.areatrigger USING btree (type);


--
-- Name: blackmarket_listing_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blackmarket_listing_item_idx ON public.blackmarket_listing USING btree (item_id) WHERE (item_id IS NOT NULL);


--
-- Name: blackmarket_listing_vendor_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blackmarket_listing_vendor_idx ON public.blackmarket_listing USING btree (vendor_id);


--
-- Name: blackmarket_vendor_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blackmarket_vendor_area_idx ON public.blackmarket_vendor USING btree (area_id) WHERE (area_id IS NOT NULL);


--
-- Name: blackmarket_vendor_creature_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blackmarket_vendor_creature_idx ON public.blackmarket_vendor USING btree (vendor_creature_id) WHERE (vendor_creature_id IS NOT NULL);


--
-- Name: blackmarket_vendor_guid_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX blackmarket_vendor_guid_uniq ON public.blackmarket_vendor USING btree (realm_id, guid);


--
-- Name: class_slug_uidx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX class_slug_uidx ON public.class USING btree (slug) WHERE (slug IS NOT NULL);


--
-- Name: class_spell_class_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX class_spell_class_idx ON public.class_spell USING btree (class_id);


--
-- Name: class_spell_spell_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX class_spell_spell_idx ON public.class_spell USING btree (spell_id);


--
-- Name: craft_recipe_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX craft_recipe_item_idx ON public.craft_recipe USING btree (item_id) WHERE (item_id IS NOT NULL);


--
-- Name: creature_faction_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_faction_idx ON public.creature USING btree (faction_id) WHERE (faction_id IS NOT NULL);


--
-- Name: creature_faction_template_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_faction_template_idx ON public.creature USING btree (faction_template_id) WHERE (faction_template_id <> 0);


--
-- Name: creature_family_skill_line_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_family_skill_line_idx ON public.creature_family USING btree (skill_line) WHERE (skill_line <> 0);


--
-- Name: creature_level_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_level_idx ON public.creature USING btree (min_level, max_level);


--
-- Name: creature_loot_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_loot_entry_idx ON public.creature_loot USING btree (entry);


--
-- Name: creature_loot_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_loot_idx ON public.creature USING btree (loot_id) WHERE (loot_id IS NOT NULL);


--
-- Name: creature_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_loot_item_idx ON public.creature_loot USING btree (item_id);


--
-- Name: creature_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_name_idx ON public.creature USING btree (name_norm);


--
-- Name: creature_name_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_name_trgm_idx ON public.creature USING gin (name public.gin_trgm_ops);


--
-- Name: creature_onkill_reputation_creature_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_onkill_reputation_creature_idx ON public.creature_onkill_reputation USING btree (creature_id);


--
-- Name: creature_pickpocket_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_pickpocket_idx ON public.creature USING btree (pickpocket_loot_id) WHERE (pickpocket_loot_id IS NOT NULL);


--
-- Name: creature_quest_ends_quest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_quest_ends_quest_idx ON public.creature_quest_ends USING btree (quest_id);


--
-- Name: creature_quest_starts_quest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_quest_starts_quest_idx ON public.creature_quest_starts USING btree (quest_id);


--
-- Name: creature_rank_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_rank_idx ON public.creature USING btree (rank);


--
-- Name: creature_search_n_name_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_search_n_name_trgm ON public.creature_search USING gin (n_name public.gin_trgm_ops);


--
-- Name: creature_skin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_skin_idx ON public.creature USING btree (skin_loot_id) WHERE (skin_loot_id IS NOT NULL);


--
-- Name: creature_spawn_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_spawn_area_idx ON public.creature_spawn USING btree (area_id) WHERE (area_id IS NOT NULL);


--
-- Name: creature_spawn_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_spawn_entry_idx ON public.creature_spawn USING btree (entry);


--
-- Name: creature_spawn_map_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_spawn_map_idx ON public.creature_spawn USING btree (map_id);


--
-- Name: creature_spells_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_spells_gin ON public.creature USING gin (spells);


--
-- Name: creature_trainer_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX creature_trainer_idx ON public.creature USING btree (trainer_type) WHERE (trainer_type > 0);


--
-- Name: disenchant_loot_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX disenchant_loot_entry_idx ON public.disenchant_loot USING btree (entry);


--
-- Name: disenchant_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX disenchant_loot_item_idx ON public.disenchant_loot USING btree (item_id);


--
-- Name: event_holiday_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX event_holiday_idx ON public.event USING btree (holiday_id) WHERE (holiday_id IS NOT NULL);


--
-- Name: faction_template_faction_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX faction_template_faction_idx ON public.faction_template USING btree (faction_id);


--
-- Name: fishing_loot_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fishing_loot_area_idx ON public.fishing_loot USING btree (area_id);


--
-- Name: fishing_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fishing_loot_item_idx ON public.fishing_loot USING btree (item_id);


--
-- Name: gameobject_loot_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_loot_entry_idx ON public.gameobject_loot USING btree (entry);


--
-- Name: gameobject_loot_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_loot_idx ON public.gameobject USING btree (loot_id) WHERE (loot_id IS NOT NULL);


--
-- Name: gameobject_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_loot_item_idx ON public.gameobject_loot USING btree (item_id);


--
-- Name: gameobject_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_name_idx ON public.gameobject USING btree (name_norm);


--
-- Name: gameobject_name_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_name_trgm_idx ON public.gameobject USING gin (name public.gin_trgm_ops);


--
-- Name: gameobject_quest_ends_quest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_quest_ends_quest_idx ON public.gameobject_quest_ends USING btree (quest_id);


--
-- Name: gameobject_quest_starts_quest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_quest_starts_quest_idx ON public.gameobject_quest_starts USING btree (quest_id);


--
-- Name: gameobject_search_n_name_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_search_n_name_trgm ON public.gameobject_search USING gin (n_name public.gin_trgm_ops);


--
-- Name: gameobject_spawn_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_spawn_area_idx ON public.gameobject_spawn USING btree (area_id) WHERE (area_id IS NOT NULL);


--
-- Name: gameobject_spawn_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_spawn_entry_idx ON public.gameobject_spawn USING btree (entry);


--
-- Name: gameobject_spawn_map_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_spawn_map_idx ON public.gameobject_spawn USING btree (map_id);


--
-- Name: gameobject_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gameobject_type_idx ON public.gameobject USING btree (type);


--
-- Name: icon_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX icon_name_idx ON public.icon USING btree (name);


--
-- Name: icon_name_source_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX icon_name_source_idx ON public.icon USING btree (name_source) WHERE (name_source IS NOT NULL);


--
-- Name: item_character_creation_class_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_character_creation_class_idx ON public.item_character_creation USING btree (class_id);


--
-- Name: item_crafted_by_crafted_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_crafted_by_crafted_idx ON public.item_crafted_by USING btree (crafted_item_id);


--
-- Name: item_crafted_by_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX item_crafted_by_uniq ON public.item_crafted_by USING btree (recipe_item_id, spell_id, crafted_item_id) NULLS NOT DISTINCT;


--
-- Name: item_dbc_class_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_dbc_class_idx ON public.item_dbc USING btree (class);


--
-- Name: item_display_info_icon_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_display_info_icon_idx ON public.item_display_info USING btree (icon_name);


--
-- Name: item_loot_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_loot_entry_idx ON public.item_loot USING btree (entry);


--
-- Name: item_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_loot_item_idx ON public.item_loot USING btree (item_id);


--
-- Name: item_stats_agi_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_stats_agi_idx ON public.item_stats USING btree (agi) WHERE (agi > 0);


--
-- Name: item_stats_dps_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_stats_dps_idx ON public.item_stats USING btree (dps) WHERE (dps IS NOT NULL);


--
-- Name: item_stats_int_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_stats_int_idx ON public.item_stats USING btree (int_) WHERE (int_ > 0);


--
-- Name: item_stats_spell_pwr; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_stats_spell_pwr ON public.item_stats USING btree (spell_power) WHERE (spell_power > 0);


--
-- Name: item_stats_sta_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_stats_sta_idx ON public.item_stats USING btree (sta) WHERE (sta > 0);


--
-- Name: item_stats_str_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_stats_str_idx ON public.item_stats USING btree (str) WHERE (str > 0);


--
-- Name: items_class_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_class_idx ON public.items USING btree (class);


--
-- Name: items_classes_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_classes_gin ON public.items USING gin (classes);


--
-- Name: items_default_listing_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_default_listing_idx ON public.items USING btree (item_level DESC NULLS LAST) WHERE (NOT worldforged);


--
-- Name: items_display_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_display_idx ON public.items USING btree (display_id);


--
-- Name: items_icon_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_icon_idx ON public.items USING btree (icon_id) WHERE (icon_id IS NOT NULL);


--
-- Name: items_inventory_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_inventory_type_idx ON public.items USING btree (inventory_type);


--
-- Name: items_itemset_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_itemset_idx ON public.items USING btree (itemset) WHERE (itemset IS NOT NULL);


--
-- Name: items_name_norm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_name_norm_idx ON public.items USING btree (name_norm);


--
-- Name: items_name_norm_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_name_norm_trgm_idx ON public.items USING gin (name_norm public.gin_trgm_ops) WHERE ((name_norm IS NOT NULL) AND (name_norm <> ''::text));


--
-- Name: items_name_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_name_trgm_idx ON public.items USING gin (name public.gin_trgm_ops);


--
-- Name: items_phase_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_phase_idx ON public.items USING btree (phase) WHERE (phase IS NOT NULL);


--
-- Name: items_quality_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_quality_idx ON public.items USING btree (quality);


--
-- Name: items_quality_min_rare_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_quality_min_rare_idx ON public.items USING btree (item_level DESC) WHERE (quality = ANY (ARRAY['rare'::public.item_quality, 'epic'::public.item_quality, 'legendary'::public.item_quality, 'artifact'::public.item_quality, 'heirloom'::public.item_quality]));


--
-- Name: items_required_faction; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_required_faction ON public.items USING btree (required_faction_id) WHERE (required_faction_id IS NOT NULL);


--
-- Name: items_required_skill_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_required_skill_idx ON public.items USING btree (required_skill) WHERE (required_skill IS NOT NULL);


--
-- Name: items_search_n_description_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_search_n_description_trgm ON public.items_search USING gin (n_description public.gin_trgm_ops);


--
-- Name: items_search_n_effects_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_search_n_effects_trgm ON public.items_search USING gin (n_effects public.gin_trgm_ops);


--
-- Name: items_search_n_name_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_search_n_name_trgm ON public.items_search USING gin (n_name public.gin_trgm_ops);


--
-- Name: items_spells_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_spells_gin ON public.items USING gin (spells jsonb_path_ops);


--
-- Name: items_stats_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_stats_gin ON public.items USING gin (stats jsonb_path_ops);


--
-- Name: items_taught_spell_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_taught_spell_idx ON public.items USING btree (taught_spell_id) WHERE (taught_spell_id IS NOT NULL);


--
-- Name: items_wf_base_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_wf_base_item_idx ON public.items USING btree (wf_base_item_id) WHERE (wf_base_item_id IS NOT NULL);


--
-- Name: items_worldforged_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_worldforged_idx ON public.items USING btree (worldforged) WHERE worldforged;


--
-- Name: items_worldforged_tier_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX items_worldforged_tier_idx ON public.items USING btree (worldforged_tier) WHERE (worldforged_tier IS NOT NULL);


--
-- Name: itemset_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX itemset_name_idx ON public.itemset USING btree (name);


--
-- Name: lfg_dungeon_expansion_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lfg_dungeon_expansion_idx ON public.lfg_dungeon USING btree (expansion);


--
-- Name: lfg_dungeon_map_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lfg_dungeon_map_idx ON public.lfg_dungeon USING btree (map_id) WHERE (map_id IS NOT NULL);


--
-- Name: lfg_dungeon_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX lfg_dungeon_type_idx ON public.lfg_dungeon USING btree (type_cat);


--
-- Name: loot_link_npc_diff_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX loot_link_npc_diff_uniq ON public.loot_link USING btree (npc_id, difficulty);


--
-- Name: loot_link_object_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX loot_link_object_idx ON public.loot_link USING btree (object_id);


--
-- Name: loot_template_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX loot_template_item_idx ON public.loot_template USING btree (item_id);


--
-- Name: loot_template_loot_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX loot_template_loot_idx ON public.loot_template USING btree (loot_id);


--
-- Name: loot_template_reference_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX loot_template_reference_idx ON public.loot_template USING btree (reference_id) WHERE (reference_id <> 0);


--
-- Name: loot_template_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX loot_template_uniq ON public.loot_template USING btree (loot_id, item_id, group_id);


--
-- Name: mind_of_ascension_talent_parent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mind_of_ascension_talent_parent_idx ON public.mind_of_ascension_talent USING btree (parent_talent_id) WHERE (parent_talent_id IS NOT NULL);


--
-- Name: mind_of_ascension_talent_spells_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mind_of_ascension_talent_spells_gin ON public.mind_of_ascension_talent USING gin (spell_ids);


--
-- Name: mind_of_ascension_talent_tree_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mind_of_ascension_talent_tree_idx ON public.mind_of_ascension_talent USING btree (tree_id);


--
-- Name: mystic_enchant_class_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mystic_enchant_class_idx ON public.mystic_enchant USING btree (class_filter);


--
-- Name: mystic_enchant_name_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mystic_enchant_name_trgm ON public.mystic_enchant USING gin (scroll_name public.gin_trgm_ops);


--
-- Name: mystic_enchant_quality_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mystic_enchant_quality_idx ON public.mystic_enchant USING btree (quality);


--
-- Name: mystic_enchant_tier_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX mystic_enchant_tier_idx ON public.mystic_enchant USING btree (tier);


--
-- Name: npc_trainer_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX npc_trainer_entry_idx ON public.npc_trainer USING btree (entry);


--
-- Name: npc_trainer_spell_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX npc_trainer_spell_idx ON public.npc_trainer USING btree (spell_id);


--
-- Name: npc_vendor_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX npc_vendor_entry_idx ON public.npc_vendor USING btree (entry);


--
-- Name: npc_vendor_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX npc_vendor_item_idx ON public.npc_vendor USING btree (item_id);


--
-- Name: objectdifficulty_h10_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX objectdifficulty_h10_idx ON public.objectdifficulty USING btree (heroic_10) WHERE (heroic_10 IS NOT NULL);


--
-- Name: objectdifficulty_h25_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX objectdifficulty_h25_idx ON public.objectdifficulty USING btree (heroic_25) WHERE (heroic_25 IS NOT NULL);


--
-- Name: objectdifficulty_n10_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX objectdifficulty_n10_idx ON public.objectdifficulty USING btree (normal_10) WHERE (normal_10 IS NOT NULL);


--
-- Name: objectdifficulty_n25_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX objectdifficulty_n25_idx ON public.objectdifficulty USING btree (normal_25) WHERE (normal_25 IS NOT NULL);


--
-- Name: pickpocket_loot_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pickpocket_loot_entry_idx ON public.pickpocket_loot USING btree (entry);


--
-- Name: pickpocket_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pickpocket_loot_item_idx ON public.pickpocket_loot USING btree (item_id);


--
-- Name: quest_chain_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_chain_idx ON public.quest USING btree (next_quest_id_chain) WHERE (next_quest_id_chain IS NOT NULL);


--
-- Name: quest_event_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_event_idx ON public.quest USING btree (event_id) WHERE (event_id IS NOT NULL);


--
-- Name: quest_level_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_level_idx ON public.quest USING btree (level);


--
-- Name: quest_level_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_level_name_idx ON public.quest USING btree (level DESC, name) WHERE (name <> ''::text);


--
-- Name: quest_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_name_idx ON public.quest USING btree (name_norm);


--
-- Name: quest_name_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_name_trgm_idx ON public.quest USING gin (name public.gin_trgm_ops);


--
-- Name: quest_objective_hotspot_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_objective_hotspot_area_idx ON public.quest_objective_hotspot USING btree (area_id) WHERE (area_id IS NOT NULL);


--
-- Name: quest_objective_hotspot_quest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_objective_hotspot_quest_idx ON public.quest_objective_hotspot USING btree (quest_id);


--
-- Name: quest_poi_xy_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_poi_xy_idx ON public.quest USING btree (poi_map_id, poi_x, poi_y) WHERE (poi_map_id IS NOT NULL);


--
-- Name: quest_req_items_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_req_items_gin ON public.quest USING gin (req_items jsonb_path_ops);


--
-- Name: quest_req_npcgo_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_req_npcgo_gin ON public.quest USING gin (req_npc_or_go jsonb_path_ops);


--
-- Name: quest_req_source_items_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_req_source_items_gin ON public.quest USING gin (req_source_items jsonb_path_ops);


--
-- Name: quest_reward_choice_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_reward_choice_gin ON public.quest USING gin (reward_choice_items jsonb_path_ops);


--
-- Name: quest_reward_items_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_reward_items_gin ON public.quest USING gin (reward_items jsonb_path_ops);


--
-- Name: quest_reward_spell_cast_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_reward_spell_cast_idx ON public.quest USING btree (reward_spell_cast_id) WHERE (reward_spell_cast_id IS NOT NULL);


--
-- Name: quest_reward_spell_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_reward_spell_idx ON public.quest USING btree (reward_spell_id) WHERE (reward_spell_id IS NOT NULL);


--
-- Name: quest_reward_xp_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_reward_xp_idx ON public.quest USING btree (reward_xp DESC) WHERE (reward_xp > 0);


--
-- Name: quest_search_n_name_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_search_n_name_trgm ON public.quest_search USING gin (n_name public.gin_trgm_ops);


--
-- Name: quest_sort_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_sort_idx ON public.quest USING btree (quest_sort_id);


--
-- Name: quest_startend_quest_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_startend_quest_idx ON public.quest_startend USING btree (quest_id);


--
-- Name: quest_xp_per_level_sort_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_xp_per_level_sort_idx ON public.quest USING btree (xp_per_level DESC NULLS LAST, name) WHERE ((name <> ''::text) AND (name !~~ 'Hand of Fate Quest #%'::text));


--
-- Name: quest_xp_sort_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX quest_xp_sort_idx ON public.quest USING btree (reward_xp DESC NULLS LAST, name) WHERE ((name <> ''::text) AND (name !~~ 'Hand of Fate Quest #%'::text));


--
-- Name: reference_loot_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reference_loot_entry_idx ON public.reference_loot USING btree (entry);


--
-- Name: reference_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reference_loot_item_idx ON public.reference_loot USING btree (item_id);


--
-- Name: skill_line_ability_class_mask_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX skill_line_ability_class_mask_idx ON public.skill_line_ability USING btree (class_mask) WHERE (class_mask > 0);


--
-- Name: skill_line_ability_skill_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX skill_line_ability_skill_idx ON public.skill_line_ability USING btree (skill_line_id);


--
-- Name: skill_line_ability_spell_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX skill_line_ability_spell_idx ON public.skill_line_ability USING btree (spell_id);


--
-- Name: skinning_loot_entry_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX skinning_loot_entry_idx ON public.skinning_loot USING btree (entry);


--
-- Name: skinning_loot_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX skinning_loot_item_idx ON public.skinning_loot USING btree (item_id);


--
-- Name: source_sources_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX source_sources_gin ON public.source USING gin (sources);


--
-- Name: spawn_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spawn_area_idx ON public.spawn USING btree (area_id) WHERE (area_id IS NOT NULL);


--
-- Name: spawn_type_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spawn_type_id_idx ON public.spawn USING btree (type_id, type);


--
-- Name: spawn_xy_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spawn_xy_idx ON public.spawn USING btree (area_id, pos_x, pos_y);


--
-- Name: spell_attributes_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_attributes_gin ON public.spell USING gin (attributes);


--
-- Name: spell_cast_time_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_cast_time_idx ON public.spell USING btree (cast_time_ms) WHERE (cast_time_ms IS NOT NULL);


--
-- Name: spell_duration_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_duration_idx ON public.spell USING btree (duration_ms) WHERE (duration_ms IS NOT NULL);


--
-- Name: spell_effects_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_effects_gin ON public.spell USING gin (effects jsonb_path_ops);


--
-- Name: spell_family_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_family_idx ON public.spell USING btree (spell_family_id);


--
-- Name: spell_icon_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_icon_idx ON public.spell USING btree (icon_id) WHERE (icon_id IS NOT NULL);


--
-- Name: spell_icon_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_icon_name_idx ON public.spell_icon USING btree (name) WHERE (name <> ''::text);


--
-- Name: spell_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_name_idx ON public.spell USING btree (name_norm);


--
-- Name: spell_name_norm_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_name_norm_trgm_idx ON public.spell USING gin (name_norm public.gin_trgm_ops) WHERE ((name_norm IS NOT NULL) AND (name_norm <> ''::text));


--
-- Name: spell_name_trgm_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_name_trgm_idx ON public.spell USING gin (name public.gin_trgm_ops);


--
-- Name: spell_range_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_range_id_idx ON public.spell USING btree (range_id) WHERE (range_id IS NOT NULL);


--
-- Name: spell_search_n_name_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_search_n_name_trgm ON public.spell_search USING gin (n_name public.gin_trgm_ops);


--
-- Name: spell_skill_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX spell_skill_idx ON public.spell USING btree (skill_line_id) WHERE (skill_line_id IS NOT NULL);


--
-- Name: talent_class_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX talent_class_idx ON public.talent USING btree (class_id);


--
-- Name: talent_spell_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX talent_spell_idx ON public.talent USING btree (spell_id);


--
-- Name: talent_tab_class_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX talent_tab_class_idx ON public.talent_tab USING btree (class_id);


--
-- Name: taxipath_end_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taxipath_end_idx ON public.taxipath USING btree (end_node_id);


--
-- Name: taxipath_start_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taxipath_start_idx ON public.taxipath USING btree (start_node_id);


--
-- Name: world_discovery_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX world_discovery_area_idx ON public.world_discovery USING btree (area_id) WHERE (area_id IS NOT NULL);


--
-- Name: world_discovery_creature_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX world_discovery_creature_idx ON public.world_discovery USING btree (creature_id) WHERE (creature_id IS NOT NULL);


--
-- Name: world_discovery_guid_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX world_discovery_guid_uniq ON public.world_discovery USING btree (realm_id, guid);


--
-- Name: world_discovery_item_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX world_discovery_item_idx ON public.world_discovery USING btree (item_id) WHERE (item_id IS NOT NULL);


--
-- Name: world_map_area_area_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX world_map_area_area_idx ON public.world_map_area USING btree (area_id) WHERE (area_id IS NOT NULL);


--
-- Name: world_map_area_map_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX world_map_area_map_idx ON public.world_map_area USING btree (map_id);


--
-- Name: achievement achievement_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.achievement_category(id) ON DELETE SET NULL;


--
-- Name: achievement_category achievement_category_parent_cat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement_category
    ADD CONSTRAINT achievement_category_parent_cat_fkey FOREIGN KEY (parent_cat) REFERENCES public.achievement_category(id) ON DELETE SET NULL;


--
-- Name: achievement achievement_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: achievement achievement_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE SET NULL;


--
-- Name: achievement achievement_ref_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_ref_achievement_id_fkey FOREIGN KEY (ref_achievement_id) REFERENCES public.achievement(id) ON DELETE SET NULL;


--
-- Name: affixed_item affixed_item_base_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affixed_item
    ADD CONSTRAINT affixed_item_base_item_id_fkey FOREIGN KEY (base_item_id) REFERENCES public.items(id) ON DELETE SET NULL;


--
-- Name: affixed_item affixed_item_drop_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affixed_item
    ADD CONSTRAINT affixed_item_drop_zone_id_fkey FOREIGN KEY (drop_zone_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: affixed_item affixed_item_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.affixed_item
    ADD CONSTRAINT affixed_item_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: area area_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE CASCADE;


--
-- Name: area area_parent_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_parent_area_id_fkey FOREIGN KEY (parent_area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: areatrigger areatrigger_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areatrigger
    ADD CONSTRAINT areatrigger_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE SET NULL;


--
-- Name: areatrigger areatrigger_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.areatrigger
    ADD CONSTRAINT areatrigger_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quest(id) ON DELETE SET NULL;


--
-- Name: blackmarket_listing blackmarket_listing_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_listing
    ADD CONSTRAINT blackmarket_listing_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.blackmarket_vendor(id) ON DELETE CASCADE;


--
-- Name: blackmarket_vendor blackmarket_vendor_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_vendor
    ADD CONSTRAINT blackmarket_vendor_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: blackmarket_vendor blackmarket_vendor_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_vendor
    ADD CONSTRAINT blackmarket_vendor_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE SET NULL;


--
-- Name: blackmarket_vendor blackmarket_vendor_realm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_vendor
    ADD CONSTRAINT blackmarket_vendor_realm_id_fkey FOREIGN KEY (realm_id) REFERENCES public.realm(id) ON DELETE SET NULL;


--
-- Name: blackmarket_vendor blackmarket_vendor_vendor_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blackmarket_vendor
    ADD CONSTRAINT blackmarket_vendor_vendor_creature_id_fkey FOREIGN KEY (vendor_creature_id) REFERENCES public.creature(id) ON DELETE SET NULL;


--
-- Name: class_spell class_spell_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_spell
    ADD CONSTRAINT class_spell_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.class(id) ON DELETE CASCADE;


--
-- Name: class_spell class_spell_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.class_spell
    ADD CONSTRAINT class_spell_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spell(id) ON DELETE CASCADE;


--
-- Name: creature creature_faction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature
    ADD CONSTRAINT creature_faction_id_fkey FOREIGN KEY (faction_id) REFERENCES public.faction(id) ON DELETE SET NULL;


--
-- Name: creature_search creature_search_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_search
    ADD CONSTRAINT creature_search_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES public.creature(id) ON DELETE CASCADE;


--
-- Name: creature_search creature_search_locale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_search
    ADD CONSTRAINT creature_search_locale_fkey FOREIGN KEY (locale) REFERENCES public.locale(id) ON DELETE CASCADE;


--
-- Name: creature_waypoint creature_waypoint_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creature_waypoint
    ADD CONSTRAINT creature_waypoint_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: currency currency_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: currency currency_item_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_item_fk FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE SET NULL;


--
-- Name: event event_holiday_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_holiday_id_fkey FOREIGN KEY (holiday_id) REFERENCES public.holiday(id) ON DELETE SET NULL;


--
-- Name: faction faction_parent_faction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faction
    ADD CONSTRAINT faction_parent_faction_id_fkey FOREIGN KEY (parent_faction_id) REFERENCES public.faction(id) ON DELETE SET NULL;


--
-- Name: faction_template faction_template_faction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faction_template
    ADD CONSTRAINT faction_template_faction_id_fkey FOREIGN KEY (faction_id) REFERENCES public.faction(id) ON DELETE CASCADE;


--
-- Name: gameobject gameobject_aura_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_aura_spell_id_fkey FOREIGN KEY (aura_spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: gameobject gameobject_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id) ON DELETE SET NULL;


--
-- Name: gameobject gameobject_faction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_faction_id_fkey FOREIGN KEY (faction_id) REFERENCES public.faction(id) ON DELETE SET NULL;


--
-- Name: gameobject gameobject_on_success_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_on_success_spell_id_fkey FOREIGN KEY (on_success_spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: gameobject gameobject_on_use_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_on_use_spell_id_fkey FOREIGN KEY (on_use_spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: gameobject gameobject_req_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_req_quest_id_fkey FOREIGN KEY (req_quest_id) REFERENCES public.quest(id) ON DELETE SET NULL;


--
-- Name: gameobject gameobject_req_skill_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_req_skill_fkey FOREIGN KEY (req_skill) REFERENCES public.skillline(id) ON DELETE SET NULL;


--
-- Name: gameobject_search gameobject_search_gameobject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject_search
    ADD CONSTRAINT gameobject_search_gameobject_id_fkey FOREIGN KEY (gameobject_id) REFERENCES public.gameobject(id) ON DELETE CASCADE;


--
-- Name: gameobject_search gameobject_search_locale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject_search
    ADD CONSTRAINT gameobject_search_locale_fkey FOREIGN KEY (locale) REFERENCES public.locale(id) ON DELETE CASCADE;


--
-- Name: gameobject gameobject_triggered_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gameobject
    ADD CONSTRAINT gameobject_triggered_spell_id_fkey FOREIGN KEY (triggered_spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: glyphproperties glyphproperties_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.glyphproperties
    ADD CONSTRAINT glyphproperties_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: glyphproperties glyphproperties_spell_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.glyphproperties
    ADD CONSTRAINT glyphproperties_spell_fk FOREIGN KEY (spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: holiday holiday_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.holiday
    ADD CONSTRAINT holiday_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: item_character_creation item_character_creation_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_character_creation
    ADD CONSTRAINT item_character_creation_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.class(id) ON DELETE CASCADE;


--
-- Name: item_character_creation item_character_creation_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_character_creation
    ADD CONSTRAINT item_character_creation_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE;


--
-- Name: item_stats item_stats_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_stats
    ADD CONSTRAINT item_stats_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE;


--
-- Name: itemenchantment itemenchantment_skill_line_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.itemenchantment
    ADD CONSTRAINT itemenchantment_skill_line_id_fkey FOREIGN KEY (skill_line_id) REFERENCES public.skillline(id) ON DELETE SET NULL;


--
-- Name: items items_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: items items_holiday_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_holiday_id_fkey FOREIGN KEY (holiday_id) REFERENCES public.holiday(id) ON DELETE SET NULL;


--
-- Name: items items_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: items items_itemset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_itemset_fkey FOREIGN KEY (itemset) REFERENCES public.itemset(id) ON DELETE SET NULL;


--
-- Name: items items_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE SET NULL;


--
-- Name: items items_random_property_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_random_property_fk FOREIGN KEY (random_property_id) REFERENCES public.random_property_pool(id) ON DELETE SET NULL;


--
-- Name: items items_random_suffix_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_random_suffix_fk FOREIGN KEY (random_suffix_id) REFERENCES public.random_suffix_pool(id) ON DELETE SET NULL;


--
-- Name: items items_required_faction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_required_faction_id_fkey FOREIGN KEY (required_faction_id) REFERENCES public.faction(id) ON DELETE SET NULL;


--
-- Name: items items_required_skill_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_required_skill_fkey FOREIGN KEY (required_skill) REFERENCES public.skillline(id) ON DELETE SET NULL;


--
-- Name: items items_required_spell_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_required_spell_fk FOREIGN KEY (required_spell) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: items_search items_search_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_search
    ADD CONSTRAINT items_search_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE;


--
-- Name: items_search items_search_locale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items_search
    ADD CONSTRAINT items_search_locale_fkey FOREIGN KEY (locale) REFERENCES public.locale(id) ON DELETE CASCADE;


--
-- Name: items items_start_quest_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_start_quest_fk FOREIGN KEY (start_quest_id) REFERENCES public.quest(id) ON DELETE SET NULL;


--
-- Name: items items_taught_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_taught_spell_id_fkey FOREIGN KEY (taught_spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: items items_wf_base_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_wf_base_item_id_fkey FOREIGN KEY (wf_base_item_id) REFERENCES public.items(id) ON DELETE SET NULL;


--
-- Name: itemset itemset_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.itemset
    ADD CONSTRAINT itemset_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id) ON DELETE SET NULL;


--
-- Name: itemset itemset_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.itemset
    ADD CONSTRAINT itemset_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skillline(id) ON DELETE SET NULL;


--
-- Name: lfg_dungeon lfg_dungeon_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lfg_dungeon
    ADD CONSTRAINT lfg_dungeon_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE SET NULL;


--
-- Name: loot_link loot_link_npc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loot_link
    ADD CONSTRAINT loot_link_npc_id_fkey FOREIGN KEY (npc_id) REFERENCES public.creature(id) ON DELETE CASCADE;


--
-- Name: loot_link loot_link_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loot_link
    ADD CONSTRAINT loot_link_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.gameobject(id) ON DELETE CASCADE;


--
-- Name: loot_template loot_template_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loot_template
    ADD CONSTRAINT loot_template_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE;


--
-- Name: mind_of_ascension_talent mind_of_ascension_talent_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_talent
    ADD CONSTRAINT mind_of_ascension_talent_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: mind_of_ascension_talent mind_of_ascension_talent_parent_talent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_talent
    ADD CONSTRAINT mind_of_ascension_talent_parent_talent_id_fkey FOREIGN KEY (parent_talent_id) REFERENCES public.mind_of_ascension_talent(id) ON DELETE SET NULL;


--
-- Name: mind_of_ascension_talent mind_of_ascension_talent_tree_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_talent
    ADD CONSTRAINT mind_of_ascension_talent_tree_id_fkey FOREIGN KEY (tree_id) REFERENCES public.mind_of_ascension_tree(id) ON DELETE CASCADE;


--
-- Name: mind_of_ascension_tree mind_of_ascension_tree_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mind_of_ascension_tree
    ADD CONSTRAINT mind_of_ascension_tree_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: mystic_enchant mystic_enchant_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mystic_enchant
    ADD CONSTRAINT mystic_enchant_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE SET NULL;


--
-- Name: mystic_enchant mystic_enchant_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mystic_enchant
    ADD CONSTRAINT mystic_enchant_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: pet pet_icon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pet
    ADD CONSTRAINT pet_icon_id_fkey FOREIGN KEY (icon_id) REFERENCES public.icon(id) ON DELETE SET NULL;


--
-- Name: pet pet_skill_line_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pet
    ADD CONSTRAINT pet_skill_line_id_fkey FOREIGN KEY (skill_line_id) REFERENCES public.skillline(id) ON DELETE SET NULL;


--
-- Name: quest quest_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id) ON DELETE SET NULL;


--
-- Name: quest_objective_hotspot quest_objective_hotspot_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_objective_hotspot
    ADD CONSTRAINT quest_objective_hotspot_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quest(id) ON DELETE CASCADE;


--
-- Name: quest quest_req_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_req_skill_id_fkey FOREIGN KEY (req_skill_id) REFERENCES public.skillline(id) ON DELETE SET NULL;


--
-- Name: quest quest_reward_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_reward_spell_id_fkey FOREIGN KEY (reward_spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: quest_search quest_search_locale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_search
    ADD CONSTRAINT quest_search_locale_fkey FOREIGN KEY (locale) REFERENCES public.locale(id) ON DELETE CASCADE;


--
-- Name: quest_search quest_search_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_search
    ADD CONSTRAINT quest_search_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quest(id) ON DELETE CASCADE;


--
-- Name: quest quest_source_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_source_item_id_fkey FOREIGN KEY (source_item_id) REFERENCES public.items(id) ON DELETE SET NULL;


--
-- Name: quest quest_source_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest
    ADD CONSTRAINT quest_source_spell_id_fkey FOREIGN KEY (source_spell_id) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: quest_startend quest_startend_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_startend
    ADD CONSTRAINT quest_startend_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id) ON DELETE SET NULL;


--
-- Name: quest_startend quest_startend_quest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quest_startend
    ADD CONSTRAINT quest_startend_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES public.quest(id) ON DELETE CASCADE;


--
-- Name: race race_faction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_faction_id_fkey FOREIGN KEY (faction_id) REFERENCES public.faction(id) ON DELETE SET NULL;


--
-- Name: race race_start_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.race
    ADD CONSTRAINT race_start_area_id_fkey FOREIGN KEY (start_area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: skill_line_ability skill_line_ability_skill_line_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_line_ability
    ADD CONSTRAINT skill_line_ability_skill_line_id_fkey FOREIGN KEY (skill_line_id) REFERENCES public.skillline(id) ON DELETE CASCADE;


--
-- Name: skill_line_ability skill_line_ability_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_line_ability
    ADD CONSTRAINT skill_line_ability_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spell(id) ON DELETE CASCADE;


--
-- Name: skill_line_ability skill_line_ability_superceded_by_spell_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_line_ability
    ADD CONSTRAINT skill_line_ability_superceded_by_spell_fkey FOREIGN KEY (superceded_by_spell) REFERENCES public.spell(id) ON DELETE SET NULL;


--
-- Name: spawn spawn_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spawn
    ADD CONSTRAINT spawn_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: spawn_override spawn_override_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spawn_override
    ADD CONSTRAINT spawn_override_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: spell_bonus_data spell_bonus_data_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_bonus_data
    ADD CONSTRAINT spell_bonus_data_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spell(id) ON DELETE CASCADE;


--
-- Name: spell_search spell_search_locale_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_search
    ADD CONSTRAINT spell_search_locale_fkey FOREIGN KEY (locale) REFERENCES public.locale(id) ON DELETE CASCADE;


--
-- Name: spell_search spell_search_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell_search
    ADD CONSTRAINT spell_search_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spell(id) ON DELETE CASCADE;


--
-- Name: spell spell_skill_line_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.spell
    ADD CONSTRAINT spell_skill_line_id_fkey FOREIGN KEY (skill_line_id) REFERENCES public.skillline(id) ON DELETE SET NULL;


--
-- Name: talent talent_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.talent
    ADD CONSTRAINT talent_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spell(id) ON DELETE CASCADE;


--
-- Name: talent_tab talent_tab_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.talent_tab
    ADD CONSTRAINT talent_tab_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.class(id) ON DELETE CASCADE;


--
-- Name: taxinode taxinode_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taxinode
    ADD CONSTRAINT taxinode_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: taxinode taxinode_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taxinode
    ADD CONSTRAINT taxinode_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE SET NULL;


--
-- Name: taxipath taxipath_end_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taxipath
    ADD CONSTRAINT taxipath_end_node_id_fkey FOREIGN KEY (end_node_id) REFERENCES public.taxinode(id) ON DELETE CASCADE;


--
-- Name: taxipath taxipath_start_node_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.taxipath
    ADD CONSTRAINT taxipath_start_node_id_fkey FOREIGN KEY (start_node_id) REFERENCES public.taxinode(id) ON DELETE CASCADE;


--
-- Name: title title_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.title
    ADD CONSTRAINT title_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id) ON DELETE SET NULL;


--
-- Name: world_discovery world_discovery_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_discovery
    ADD CONSTRAINT world_discovery_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id) ON DELETE SET NULL;


--
-- Name: world_discovery world_discovery_creature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_discovery
    ADD CONSTRAINT world_discovery_creature_id_fkey FOREIGN KEY (creature_id) REFERENCES public.creature(id) ON DELETE SET NULL;


--
-- Name: world_discovery world_discovery_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_discovery
    ADD CONSTRAINT world_discovery_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE SET NULL;


--
-- Name: world_discovery world_discovery_map_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_discovery
    ADD CONSTRAINT world_discovery_map_id_fkey FOREIGN KEY (map_id) REFERENCES public.map(id) ON DELETE SET NULL;


--
-- Name: world_discovery world_discovery_realm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.world_discovery
    ADD CONSTRAINT world_discovery_realm_id_fkey FOREIGN KEY (realm_id) REFERENCES public.realm(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict ucujrTGm8Ru5E4TstxP2hYo8J30O5pdmSKDIjsQu9B5rBjxAtbcQUWkz4lXc6DY

