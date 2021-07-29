filename=/var/www/html/v3/plugins/eclipse/che-theia/latest/meta.yaml 
oldhash1=dc87777a63ef1fd4799cf7b249add81531e340c7876201034ad085f56d163141
newhash1=e19ab58d0bb1b4f39ff3f66edd2138fed76b8feae5db78acee0e364936a73827
oldhash2=35f482306b13df72eb7417bd18b18b3c4a81ae7f2ecbe041deb7d8174ba7e313
newhash2=1e77ab29f9a72ce94ae40670499c3823048cfdb4fe7de0707adeffd7274f78c9

oc project do500-workspaces
plugin_podname=$(oc get pods | grep plugin-registry | awk '{ print $1 }')
oc exec $plugin_podname -- sed -i "s/$oldhash1/$newhash1/g" $filename
oc exec $plugin_podname -- sed -i "s/$oldhash2/$newhash2/g" $filename