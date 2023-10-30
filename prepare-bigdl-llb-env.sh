# Usage:
##  bash prepare-bigdl-llb-env.sh xpu   # for xpu test
##  bash prepare-bigdl-llb-env.sh cpu   # for cpu test

conda create -n llb_test python=3.9 -y
conda activate llb_test

pip install --pre --upgrade bigdl-nano
source bigdl-nano-init

if [ "$1" == "xpu" ]
then
    pip install --pre --upgrade bigdl-llm[xpu] -f https://developer.intel.com/ipex-whl-stable-xpu
    echo 'source /opt/intel/oneapi/setvars.sh' >> $CONDA_PREFIX/etc/conda/activate.d/oneapi.sh

    conda env config vars set USE_XETLA=OFF
    conda env config vars set SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=1

else 
    pip install --pre --upgrade bigdl-llm[all]
fi

pip install -e .

conda env config vars set HF_HOME=$HF_HOME
conda env config vars set HF_DATASETS_CACHE=$HF_HOME/datasets

conda deactivate
conda activate llb_test