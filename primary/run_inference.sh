#!/bin/bash

# remember to chmod +x run_inference.sh

# Define CLI variables to take in 
MODEL_PATH=${1:-"default_model_path"}  # First argument or default value
PROMPT=${2:-"Default prompt"}          # Second argument or default value

# Run the command
../build/bin/llama --client --config ./rpc_config.json --model "$MODEL_PATH" --prompt "$PROMPT"


# ./run_inference.sh "/path/to/model" "Prompt should be here"
