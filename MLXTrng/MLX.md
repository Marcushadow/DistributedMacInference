## Setup

In order to ensure replicability. Will be using conda environments. To see the conda install, check the parent directory for more details.

## IMPORTANT NOTICE

In order for MLX to work, the path must be exactly the same.

Have the same absolute directory:\
1 - Installations and environments. i.e conda installation must be the same\
2 - Folder Directory must be the same as well

## Conda

```bash
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
sh Miniconda3-latest-MacOSX-arm64.sh
```

Add to path


```bash
conda init zsh
```
 or

```bash
echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

## Adding to path

```bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc && source ~/.zshrc
```

## Installation

```bash
brew install open-mpi
```
### Clone Conda Env (For node)
```bash
# Command to clone over scp / rsync -r
```

### Creating a Conda Env (If completely new)
```bash
conda create -n MLX python=3.12

conda activate MLX

conda install -c conda-forge openmpi
```


### pip installs

```bash
pip install mlx
```

### SSH Environment setup
<ul>
<li> On the Mac you wish to SSH into, open <b>System Settings > Sharing</b> . </li>
<li>Turn on <b>Remote Login</b> (this enables the built-in SSH server).</li>
<li>Note the username shown in the Remote Login pane – you’ll use this to log in.</li>
</ul>
<br>

On client mac:
```bash
md -p ~/.ssh
chmod 700 ~/.ssh

ssh-keygen -t ed25519 -C "your_email@example.com"
```

Accept the default save location (`/Users/<username>/.ssh/id_ed25519`) and passphrase.

#### Displaying public key (client mac)
```bash
cat ~/.ssh/id_ed25519.pub
```

#### Adding the key to authorized keys (On the destination mac)
```bash
echo "<Entire Key here>" >> ~/.ssh/authorized_keys
```

#### Testing the connection
```bash
ssh <username>@ip
```


### MLX ring suggested setup (Tested + Not Working)

```bash
mlx.distributed_config --verbose --hosts xxx.xxx.xxx.xxx,yyy.yyy.yyy.yyy
```

Sample Output

```zsh
[INFO] Preparing a thunderbolt ring for xxx.xxx.xxx.xxx, yyy.yyy.yyy.yyy 
[INFO] Getting connectivity from xxx.xxx.xxx.xxx 
[INFO] Getting connectivity from yyy.yyy.yyy.yyy 
[INFO] Getting interface names from xxx.xxx.xxx.xxx 
[INFO] Getting interface names from yyy.yyy.yyy.yyy 
[INFO] Extracting rings from the parsed connectivity 
Setup for xxx.xxx.xxx.xxx
=================================
sudo ifconfig bridge0 down
sudo ifconfig en2 inet 192.168.0.2 netmask 255.255.255.252
sudo route change 192.168.0.1 -interface en2
sudo ifconfig en3 inet 192.168.0.5 netmask 255.255.255.252
sudo route change 192.168.0.6 -interface en3

Enter to continue

Setup for yyy.yyy.yyy.yyy
===============================
sudo ifconfig bridge0 down
sudo ifconfig en2 inet 192.168.0.6 netmask 255.255.255.252
sudo route change 192.168.0.5 -interface en2
sudo ifconfig en4 inet 192.168.0.1 netmask 255.255.255.252
sudo route change 192.168.0.2 -interface en4

Enter to continue

Hostfile
========
[
    {
        "ssh": "xxx.xxx.xxx.xxx",
        "ips": [
            "192.168.0.2"
        ]
    },
    {
        "ssh": "yyy.yyy.yyy.yyy",
        "ips": [
            "192.168.0.6"
        ]
    }
]
```

```bash
mlx.launch --verbose --hostfile hostfile.json -n 2 test_mlx_mpi.py
```

### MLX Ring set up (Figured out)
### Copy Files Over
```bash
rsync -r DistributedMacInference <target>:~/Desktop/
```

#### Run tests

```bash
mlx.launch --verbose --hosts xxx.xxx.xxx.xxx,yyy.yyy.yyy.yyy -n 2 test_mlx_mpi.py
```

#### Setup for Fine Tuning (mlx vlm and lm libs)

```bash
pip install mlx-lm
pip install mlx-vlm
pip install hf_transfer
```

#### HF cli was logged into (Master Node)

```bash
huggingface-cli login
```

#### Convert suggested did not work with existing Llama Repo. This is because the Llama models by meta require special request. I.e to download llama 70b, u need to request access

#### Local download first
```bash
export HF_HUB_ENABLE_HF_TRANSFER=1

huggingface-cli download --local-dir ./models meta-llama/Llama-3.3-70B-Instruct
```

```bash
python -m mlx_lm.convert --hf-path /path/to/local-model --mlx-path /path/to/mlx-model -q
```

#### From HF straight

#### Using hf models*

```bash
HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download google/gemma-3-1b-it

HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download google/gemma-3-12b-it

HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download google/gemma-3-27b-it
```

```bash
python -m mlx_lm.convert --hf-path unsloth/Llama-3.3-70B-Instruct -q 
```
`-q` is default to 4 bit quantization 

#### HF LLM datasets

Data has to be in this format:
https://github.com/ml-explore/mlx-lm/blob/main/mlx_lm/LORA.md 

This dataset: mlx-community/wikisql 
TIGER-Lab/MathInstruct

https://huggingface.co/collections/sugatoray/llm-training-datasets-65dbe4ab2b0037ec198b09ab

https://github.com/mlabonne/llm-datasets?tab=readme-ov-file 

#### Converting a huggingface model

```bash
mlx_lm.convert --hf-path google/gemma-3-1b-it --mlx-path gemma-model
```

#### Single device lora command 

```bash
mlx_lm.lora \                                
    --model ./mlx_model \
    --train \
    --data ./data \
    --iters 1
```

#### After Setting up the connection
```bash
mlx.launch --verbose --hostfile hostfile.json -n 2 mlx_lm.lora --model ./mlx_model --adapter-path ./adapters --train --data ./data --iters 20
```

## Copying things over
## When another mac comes -> use the file sharing.

```bash
rsync -r MLXTrng 192.168.1.125:~/Desktop/DistributedMacInference 
```

## Copying the conda environment

```bash
conda env export > environment.yml
conda env create -f environment.yml
```

```bash
conda list --explicit > spec-file.txt
conda create --name myenv --file spec-file.txt
```


## Target File Structure
`./adapters`
- Stores all the Lora Adapters

`./data`
- Your data directory

`./mlx_model`
- Stores your converted mlx model

`./models`
- Stores your huggingface downloaded models


