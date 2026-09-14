# Get Ascension data

Browse and search [AscensionDB](https://ascension-db.ascension-archive.workers.dev/).
GitHub remains the starting point for public data. Large collections are distributed
through [Releases](https://github.com/hertigservices/ascension-data/releases), with
checksummed manifests in [datasets](datasets/).

To restore the cache collection with normal filenames:

1. Save [datasets/cache.json](datasets/cache.json).
2. Save [dataset.py](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/data-storage/dataset.py).
3. With Python 3.12 or later installed, run `python dataset.py download cache.json --out AscensionData`.

To retrieve only a folder, add `--select cachedata/union`. Running again resumes
interrupted downloads and skips verified completed files. No account or API key is
needed. Other collections still stored under supplemental/ can be downloaded from
this repository; their existing Release mirrors remain linked in their documents.

A normal Git checkout contains the manifests and the remaining smaller public
collections. The cache manifest retrieves the bulk cache files. Keep the downloaded
manifest with the data to identify the exact snapshot. Old Git history remains
available; removing bulk files from the current tree does not rewrite that history.

Public exports preserve source distinctions and limitations. Private donations,
player records, unknown originals and material awaiting permission are retained by
the maintainer, not included in a public download. A record being searchable does
not mean it has been installed into a playable server or proves a spawn/drop rate.

Small cachedata/contributions receipts remain in Git so upload confirmations can verify publication. All bulk cache files are retrieved using the manifest.
