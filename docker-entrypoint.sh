#!/bin/bash -e

source /functions.sh

#
GLOBALRESOURCES=${GLOBALRESOURCES:-"storageclasses,thirdpartyresource,networkpolicy"}
RESOURCETYPES=${RESOURCETYPES:-"pvc,svc,ingress,configmap,secrets,ds,rc,deployment,statefulset,cronjob,serviceaccount"}
TARFILENAME="kube-state-$(date +%FT%T).tar.gz"

# dump state
dump_state

# tar backup assets
tar_files

# upload to cloud storage
if [ "${STORAGE}" = "aws" ]
then
  upload_s3
elif [ "${STORAGE}" = "gcs" ]
then
  upload_gcs
elif [ "${STORAGE}" = "azure" ]
then
  upload_azure_blob
fi
