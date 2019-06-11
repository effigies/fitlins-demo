
# Debian
# apt-get install git-annex

# Linux with Conda
# conda install -y git-annex

# OSX
# open https://git-annex.branchable.com/install/OSX/

pip install -q --upgrade pip setuptools
pip install -q --upgrade "datalad @ git+https://github.com/datalad/datalad@5f5342ce2e63b91d54f75edb87d97129a916d9ef" \
                         "nistats @ git+https://github.com/nistats/nistats.git@b69e127020df05aa8ba540f9a8d799e1dad3d602"

# Set environment variable to make outputs more friendly
export DATALAD_UI_PROGRESSBAR=log
export NO_COLOR="1"

datalad install -r ///labs/poldrack/ds003_fmriprep
datalad update ds003_fmriprep

datalad get ds003_fmriprep/sub-*/func/*_space-MNI152NLin2009cAsym_desc-*.nii.gz \
            ds003_fmriprep/sub-*/func/*_desc-confounds_*.tsv

pip install -q --upgrade fitlins==0.4.0

tree -P "sub-0[123]*.nii.gz" -I "figures|log" --prune --noreport ds003_fmriprep | grep -v -- '->'

cat ../models/ds000003/models/model-001_smdl.json

fitlins ds003_fmriprep/sourcedata output/ dataset \
    --derivatives $PWD/ds003_fmriprep \
    --model $PWD/../models/ds000003/models/model-001_smdl.json \
    --smoothing 5:run \
    -w scratch \
    --n-cpus 2
