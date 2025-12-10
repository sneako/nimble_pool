#!/bin/bash
set -e

# Ensure bench/results exists
mkdir -p bench/results

REV=$(git rev-parse --short HEAD)
OUTPUT_FILE="bench/results/bench_${REV}.txt"

echo "Running benchmark for revision $REV..."
echo "Output will be saved to $OUTPUT_FILE"

# Run with mix run to ensure environment is loaded
mix run bench/pool_bench.exs | tee "$OUTPUT_FILE"

echo "Done. Results saved to $OUTPUT_FILE"
