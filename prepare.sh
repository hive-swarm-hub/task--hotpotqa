#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading HotPotQA..."
python3 -c "
from datasets import load_dataset
import json, pathlib

dev = load_dataset('hotpotqa/hotpot_qa', 'distractor', split='train[:200]')
dev_out = pathlib.Path('data/dev.jsonl')
with dev_out.open('w') as f:
    for row in dev:
        f.write(json.dumps({'question': row['question'], 'answer': row['answer']}) + '\n')

test = load_dataset('hotpotqa/hotpot_qa', 'distractor', split='validation[:500]')
test_out = pathlib.Path('data/test.jsonl')
with test_out.open('w') as f:
    for row in test:
        f.write(json.dumps({'question': row['question'], 'answer': row['answer']}) + '\n')

print(f'Dev:  {len(dev)} problems -> {dev_out}')
print(f'Test: {len(test)} problems -> {test_out}')
"
echo "Done."
