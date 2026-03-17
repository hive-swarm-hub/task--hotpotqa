#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading HotPotQA..."
python3 << 'PY'
from datasets import load_dataset
import json, pathlib, random
random.seed(42)
train = list(load_dataset('hotpotqa/hotpot_qa', 'distractor', split='train[:500]'))
random.shuffle(train)
with pathlib.Path('data/train.jsonl').open('w') as f:
    for row in train[:100]:
        f.write(json.dumps({"question": row["question"], "answer": row["answer"]}) + '\n')
val = list(load_dataset('hotpotqa/hotpot_qa', 'distractor', split='validation[:500]'))
random.shuffle(val)
with pathlib.Path('data/test.jsonl').open('w') as f:
    for row in val[:150]:
        f.write(json.dumps({"question": row["question"], "answer": row["answer"]}) + '\n')
print('Train: 100, Test: 150')
PY
echo "Done."
