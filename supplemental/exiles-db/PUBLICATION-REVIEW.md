# Publication review

Archive SHA-256: `6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b`,
verified against the upstream release's own `SHA256SUMS.txt` before extraction and
re-verified by the importer before any artifact was written.

The importer read the mirror without executing anything from it. Page-to-file
mapping comes from the crawler's own `offline_site.sqlite` rather than from
walking directories, so a page the crawler never recorded is never published and
a route whose file is absent is counted rather than silently skipped. Every
published record names the mirrored file and SHA-256 it was parsed from, and
`verify` requires that hash to match the published mirror index. Gzip timestamps
are zeroed and streams are written in sorted route order; rebuilding from the
same mirror and baseline produces byte-identical artifacts.

## The file index has two more rows than the archive

`mirror.index.tsv.gz` lists **517,760** files; the upstream archive contains
**517,758**. The difference is exactly `data/offline_site.sqlite-shm` and
`data/offline_site.sqlite-wal`, which SQLite created when the importer opened the
crawler's own database — read-only opens of a WAL-mode database still write
sidecar files. They are not part of the upstream archive. Every other row
corresponds to a mirrored file. The index describes the tree as it was parsed,
which is what makes it useful for confirming a reader holds the same bytes; these
two rows are the one place where that tree and the archive differ, and they carry
no mirrored content.

## What was checked, and what these checks cannot establish

`verify` re-reads every artifact, checks its hash and size against the manifest,
requires the snapshot to contain exactly the files the manifest lists, confirms
per-stream record counts and per-type page counts, requires each tree's parsed
talent count to equal the count its own page declares, checks the SQLite schema
against the expected schema, its integrity and its row counts, recomputes the
comparison totals, and screens every artifact for personal-data indicators.

Unlike the BisBeard catalog, this one **cannot re-derive its records from
preserved source bytes**: 13.75 GB of mirrored HTML is not republishable in a Git
repository. Original bytes are preserved only for the talent tree and class
pages, whose markup is itself the data. Everything else is identified by SHA-256
in `mirror.index.tsv.gz`. These checks establish that the published artifacts are
internally consistent, unmodified and traceable to named files; they do not
establish that the parse was faithful to bytes this repository does not hold. A
reader who obtains the upstream archive can close that gap with the index.

## Extraction completeness

Structural extraction drops things silently, so it was measured rather than
assumed. For each page type, the word multiset of the page's rendered main
content was compared against the word multiset of everything stored in the
resulting record. Every entity page type reports nothing missing. What remains
uncaptured on a few types is interface chrome or a figure derived from data that
is captured: the changelog's filter bar, a class page's `473 abilities · 65
talents` summary line, and the `0/` current-rank prefix on a talent cell whose
maximum rank is stored as an integer.

That measurement found two real omissions before publication. Quest reward blocks
are rendered as bare `<div class="quest-rewards__xp">Experience: 33,100 XP</div>`,
belonging to no list, table or definition list, and were being dropped entirely;
records now carry leaf-`<div>` fields. Separately, 62 of the 155 talent trees use
a `moa-tree-flat` list layout rather than the positioned `talent-grid`, and were
parsing to zero talents without error. Both are covered by tests.

## Comparison correctness

The comparison was computed twice, by the importer and by a separate
implementation written not to share its code, and the two agree: 121,003
name-match, 939 name-conflict, 39,900 candidate-missing, 7,797 unnamed-in-mirror.

An earlier run reported **10,273** quest name conflicts. That figure was wrong.
`cachedata/union/questcache.tsv.gz` holds the quest name in a column called
`Title` at index 65, where the other three caches use `name` near the front; a
loader that fell back to the second column had been comparing every quest against
`Method`, whose values are `0` and `2`. Ten thousand conflicts out of ten thousand
quests is not self-evidently absurd, and nothing else about the output looked
wrong — it was caught only by printing named example rows beneath the counts,
which read `mirror='Fossil Fuel' captured='2'`. The importer now declares each
baseline's name column explicitly and refuses a baseline that lacks it. The real
figure is 96. There is a regression test.

## Personal data

The mirror's indexed names, route paths, verbatim-preserved pages and API
specification were screened before publication. One finding: the site's
`openapi.json` carries a contact in `info.contact` — a named individual's email
address, and an organisation that identifies the site's operator, who has asked to
remain anonymous. The field map that document provides is worth preserving; the
contact is not. The published copy is byte-identical to the original except that
every address is replaced with `<redacted: contact address>` and the organisation
with `<redacted: operator>`; the unmodified file's SHA-256 and both redaction counts
are recorded in the manifest. The organisation was retained in the first
publication and removed in a later commit. `verify` refuses a snapshot in which an
address reappears or the contact is named, and it now
screens **every** artifact rather than a listed subset — the specification was
not on the earlier list, which is precisely why it needed to be.

A full sweep of every published artifact found exactly **one** distinct
email-shaped string, and no player GUIDs, account paths or local machine paths
at all. That string is `techbot@gnome.mail`, appearing twice in
`spells.jsonl.gz`. It is game text, not a person's address: it is the flavour
line on the GM "BAN Hammer" spell (ids 2102812 and 3102812) — *"You have been
banned for … You may contact techbot@gnome.mail to appeal."* — a mailbox at a
TLD that does not exist. It is allowed as that exact literal and nothing wider;
another address at the same domain, or the same name at a real domain, still
fails, and there is a test for both. `source_path` values are relative paths
inside the mirror.

## Standing limits

This is a supplemental preservation catalog of a third-party website. Item, NPC,
loot and source accuracy are not independently established; drop percentages are
the site's own claims and no probability is inferred from them; `candidate-missing`
IDs are research candidates, not proven game entities. The crawl's 39,858 failed
asset fetches are not missing icons — 22,151 requested a `/coa/static/icons/` path
the site never served, 16,702 were creature renders that were never made, and 498
were `icons-clean` files — and the operator's complete icon set has since been
published separately. Captured WDB values remain
authoritative. No WDB payloads were produced and no live realm has been changed.
The source's licensing status is not asserted by this preservation record.
