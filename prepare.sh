#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading HotPotQA..."
python3 -c "
from datasets import load_dataset
import json, pathlib, random

random.seed(42)

train = list(load_dataset('hotpotqa/hotpot_qa', 'distractor', split='train[:500]'))
random.shuffle(train)
dev_out = pathlib.Path('data/dev.jsonl')
with dev_out.open('w') as f:
    for row in train[:150]:
        f.write(json.dumps({'question': row['question'], 'answer': row['answer']}) + '
')

val = list(load_dataset('hotpotqa/hotpot_qa', 'distractor', split='validation[:500]'))
random.shuffle(val)
test_out = pathlib.Path('data/test.jsonl')
with test_out.open('w') as f:
    for row in val[:150]:
        f.write(json.dumps({'question': row['question'], 'answer': row['answer']}) + '
')

print(f'Dev:  150 problems -> {dev_out}')
print(f'Test: 150 problems -> {test_out}')
"
echo "Done."
