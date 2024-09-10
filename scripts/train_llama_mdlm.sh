#!/bin/bash
#SBATCH --nodes=1
#SBATCH -p a100
#SBATCH --time=7-00:00:00
#SBATCH --job-name=mdlm_llama
#SBATCH --output=mdlm_llama.log

source /usr/workspace/christopher9/x86_miniconda/bin/activate
conda activate mdlm

cd /usr/workspace/christopher9/mdlm



# export PYTHONPATH=$PYTHONPATH:/usr/workspace/christopher9/code/speculative-decoding/
# export PYTHONPATH=$PYTHONPATH:/usr/workspace/christopher9/code/speculative-decoding/mdlm
# export TRANSFORMERS_CACHE=/usr/workspace/christopher9/.cache/
# export HF_CACHE=/usr/workspace/christopher9/.cache/
# export HF_HOME=/usr/workspace/christopher9/.cache/
# export HF_DATASETS_CACHE=/usr/workspace/christopher9/.cache/

# To enable preemption re-loading, set `hydra.run.dir` or 
# `checkpointing.save_dir` explicitly.
CUDA_LAUNCH_BLOCKING=1 python main.py \
  model=small \
  data=openwebtext-llama \
  wandb.name=mdlm-llama \
  parameterization=subs \
  model.length=1024 \
  eval.compute_generative_perplexity=True \
  sampling.steps=1000