#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading HotPotQA..."
python3 << 'PY'
from datasets import load_dataset
import json, pathlib
ds = load_dataset('hotpotqa/hotpot_qa', 'distractor', split='validation')
out = pathlib.Path('data/test.jsonl')
with out.open('w') as f:
    for row in ds:
        f.write(json.dumps({"question": row["question"], "answer": row["answer"]}) + '\n')
print(f'Wrote {len(ds)} problems to {out}')
PY
echo "Done."
