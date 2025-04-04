#### This marks the spot I start to lose my mind

I realise the complexities of this is not as simple as calling a lora.py

<ul>
<li>3 lora.py versions exist. 1.) calling mlx_lm.lora 2.) inside mlx main repo. 3.) inside mlx_lm main repo</li>
<li>After scrutinising the code. The code does not seem to be doing distributed data parallel. The documentation says that it is possible. But the fix that it gives cant even apply to the lora.py file itself.</li>
</ul>

#### Got everything to install!

```bash
mlx_lm.convert --hf-path google/gemma-3-1b-it
```

#### This worked on 1 device!

#### Lora 1 device

```bash
mlx_lm.lora \                                
    --model ./mlx_model \
    --train \
    --data ./data \
    --iters 1
```


#### Copying things over
```bash
rsync -r MLXTrng 192.168.1.125:~/Desktop/DistributedMacInference 
```

#### After Setting up the connection
```bash
    mlx.launch --verbose --hostfile hostfile.json -n 2 mlx_lm.lora --model ./mlx_model --train --data ./data --iters 20
```

