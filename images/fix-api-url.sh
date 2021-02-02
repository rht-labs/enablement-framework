#!/bin/bash
help() { echo "something broke - do you need to 'oc login' ?"; exit $1; }
fixApiUrl() { API_URL=$(oc get routes/$(oc get routes | grep 9000 | cut -d ' ' -f 1)  --template='{{.spec.host}}'); [[ $? -ne 0 ]] && help 0; [[ -z "$API_URL" ]] && help 0; sed -i -e "s|todoEndpoint:.*$|todoEndpoint: \"https://${API_URL}/api/todos\"|g" /projects/todolist/src/config/index.js; }

