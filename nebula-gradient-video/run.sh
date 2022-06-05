#!/bin/bash
source activate nebula 
export SHELL=/bin/bash
rm -rf /storage/lost+found
#ln -s /datasets/nebula/* /storage/data/
export TRANSFORMERS_CACHE=/storage/models 

if [ ! -L /storage/models ]
then
   mkdir /storage/models
fi

if [ ! -d /storage/NEBULA2 ]
then
   #rm -rf /storage/NEBULA2/notebooks/nebula_api/mdmmt_api/models/CLIP
   #rm -rf /storage/NEBULA2/nebula_api/mdmmt_api/models/tensorflow_models
   cd /storage && git clone https://github.com/NEBULA3PR0JECT/nebula3_videoprocessing
   cd /storage/NEBULA2/nebula_api/mdmmt_api && git clone https://github.com/openai/CLIP models/CLIP &&\
   git clone https://github.com/tensorflow/models/ models/tensorflow_models &&\
   ln -s /storage/models ckpts &&\
   ln -s /storage/models mdmmt_model &&\
   cd /storage/models &&\
   wget https://github.com/bjuncek/VMZ/releases/download/test_models/irCSN_152_ig65m_from_scratch_f125286141.pth &&\
   wget https://storage.googleapis.com/audioset/vggish_model.ckpt &&\
   wget https://nebmodels.s3.eu-central-1.amazonaws.com/comet-atomic_2020_BART/mdmmt_3mod.pth
fi
export PYTHONPATH=/storage/NEBULA2

if [ ! -L /notebooks/NEBULA ]
then
   chmod -R a+w /notebooks
   cd /notebooks && ln -s /storage/NEBULA2 NEBULA 
fi
#cd /root/.cache/ && ln -s /storage/models clip 

jupyter lab --ip=0.0.0.0 --no-browser --allow-root --LabApp.trust_xheaders=True --LabApp.disable_check_xsrf=False --LabApp.allow_remote_access=True --LabApp.allow_origin='*'
