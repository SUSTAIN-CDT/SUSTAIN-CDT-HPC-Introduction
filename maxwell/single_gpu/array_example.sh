#!/bin/bash
#SBATCH --nodes=1 # number of nodes
#SBATCH --cpus-per-task=4 # number of cores
#SBATCH --mem=32G # memory pool for all cores

#SBATCH --ntasks-per-node=1 # one job per node
#SBATCH --gres=gpu:1 # 1 GPU out of 3
#SBATCH --partition=a100_full

#SBATCH -o slurm.%j.out # STDOUT
#SBATCH -e slurm.%j.err # STDERR

#SBATCH --mail-type=ALL 
#SBATCH --mail-user=<username>@abdn.ac.uk 

#SBATCH --array=0-2 # Array indices (0, 1, 2)

module load miniconda3
source activate test

# Define an array of learning rates
learning_rates=(0.1 0.01 0.001)

# Get the learning rate corresponding to the current array index
lr=${learning_rates[$SLURM_ARRAY_TASK_ID]}

echo "Starting job ${SLURM_ARRAY_TASK_ID} with learning rate: ${lr}"

srun python example_script.py --epochs=10 --lr "${lr}" --save $HOME/sharedscratch/
