# Add HPC scripts e.g. mqsub to the path
export PATH="/mnt/hpccs01/work/microbiome/sw/hpc_scripts/bin:$PATH"

#function for command prompt and email notification of job completion
function notify { command "$@" && success || fail; }

#setup temporary file folder # No need for this since /tmp is /data1 in mounts
# export TMPDIR=/data1/tmp-$USER
# mkdir -p $TMPDIR

#check for nextflow config
if [[ ! -e ~/.nextflow/config ]]; then
    NEXTFLOW_CONFIG=/mnt/hpccs01/work/microbiome/sw/nextflow_config/config
fi

# Otherwise qaddtime is only available on lyra # currently disabled due to abuse
#alias qaddtime=/pkg/hpc/scripts/qaddtime

# Save all the history, see https://debian-administration.org/article/543/Bash_eternal_history
export HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
               "$(history 1)" >> ~/.bash_eternal_history'

#Path to kingfisher # symlinked /lustre/work-lustre/microbiome/sw/kingfisher-download/bin/kingfisher in $CONDA_PREFIX/envs/kingfisher/bin instead
export PATH=/work/microbiome/sw/kingfisher_repos/kingfisher-v0.4.1/kingfisher-download/bin:$PATH
export PATH=/work/microbiome/sw/recurm_repos/recurm-v0.3.0/recurm/bin:$PATH

# Setup snakemake config directories so it interfaces well with the PBS system
mkdir -p ~/.config/snakemake
cd ~/.config/snakemake && ln -sf /work/microbiome/sw/hpc_scripts/snakemake_configs/* . && cd $OLDPWD
