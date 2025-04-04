
## Replication steps
Steps to replicate:

### Start a conda env

```bash
conda create -n llamacpp python=3.12
```

### Proceed

```bash
brew install cmake
```

```bash
git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp
```

```bash
cd build-rpc-metal
cmake .. -DLLAMA_METAL=ON -DLLAMA_BUILD_RPC=ON
cmake --build . --config Release
```

Running the individual RPC

While Inside `build-rpc-metal`, to start the server:

```bash
bin/rpc-server -H 0.0.0.0 -p 50052
```

Use `ifconfig` to find the local ip. Check the bridge `bridge0`

Use `arp -a` to scan for connections.

Example:
```bash
bin/llama-cli -m ./models/google_gemma-3-27b-it-Q8_0.gguf -p "What is the meaning of life?" --repeat-penalty 1.0 -n 64 --rpc 169.254.155.178:50052,169.254.191.140:50052 -ngl 99
```

## To Monitor Resources

```bash
macmon
```