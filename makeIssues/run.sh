#!/bin/bash
source setting.sh

echo "-------setting-----------------"

echo "privateToken: $privateToken "
echo "id: $id "
echo "defaultlabels: $defaultlabels"
defaultlabels=$(echo $defaultlabels | nkf -wMQ | tr = % | tr -d '\n')
echo "defaultlabels(urlencoded): $defaultlabels"

echo "-------create issues-----------"
cat issueList.txt | while read title labels
do
  echo "title: $title "
  title=$(echo $title | nkf -wMQ | tr = % | tr -d '\n')
  echo "title(urlencoded): $title "
  echo "labels: $labels "

  if [ -n "$labels" ]; then
    # 追加ラベルが存在する
    labels=$defaultlabels$(echo ",$labels" | nkf -wMQ | tr = % | tr -d '\n')
  else
    # デフォルトラベルのみ
    labels=$defaultlabels
  fi
  echo "-------------------------------"
  curl -v \
       --request POST \
       --header "PRIVATE-TOKEN: $privateToken" \
       "https://gitlab.com/api/v4/projects/$id/issues?title=$title&labels=$labels" 
done
privateToken=""
id=""