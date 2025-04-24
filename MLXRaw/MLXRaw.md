# MLXRaw 

MLXRaw seeks to test a full huggingface approach to distributed training/ ft on mac

This assumes that the setup for regular MLX distributed is done

### Creating a Conda Env (If completely new)
```bash
conda create -n MLXRaw python=3.12

conda activate MLXRaw

conda install -c conda-forge openmpi
```

```
pip install mlx
pip install mlx-lm
pip install mlx-vlm
pip install hf_transfer
```

### Config

i.p addresses follow `en1`

```bash
mlx.distributed_config --verbose --hosts xxx.xxx.xxx.xxx,yyy.yyy.yyy.yyy
```

```bash
mlx.launch --verbose --hosts xxx.xxx.xxx.xxx,yyy.yyy.yyy.yyy -n 2 test_mlx_mpi.py
```