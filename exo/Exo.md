https://developer.apple.com/metal/pytorch/

https://ml-explore.github.io/mlx/build/html/install.html 

```bash
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
sh Miniconda3-latest-MacOSX-arm64.sh
```

```bash
conda create -n ExoEnv python=3.12
conda activate ExoEnv
pip install mlx
conda install conda-forge::mlx
```

```bash
python -c "import platform; print(platform.processor())"
```
Should return u `arm`


```bash
git clone https://github.com/exo-explore/exo.git
cd exo

source install.sh
```

```bash
./configure_mlx.sh
```