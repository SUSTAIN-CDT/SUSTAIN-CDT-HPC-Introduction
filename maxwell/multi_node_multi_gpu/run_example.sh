#!/bin/bash
#SBATCH --nodes=2 # number of nodes
#SBATCH --cpus-per-task=4 # number of cores
#SBATCH --mem=32G # memory pool for all cores

#SBATCH --ntasks-per-node=2 # one job per node
#SBATCH --gres=gpu:2 # 2 GPU out of 3
#SBATCH --partition=a100_full

#SBATCH -o slurm.%j.out # STDOUT
#SBATCH -e slurm.%j.err # STDERR

#SBATCH --mail-type=ALL 
#SBATCH --mail-user=<username>@abdn.ac.uk 

module load miniconda3
source activate test

srun python example_script.py --epochs=10 --save $HOME/sharedscratch/ --num_nodes=2 --gpus_node=2
