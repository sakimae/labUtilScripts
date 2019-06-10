#!/bin/bash
source setting.sh

echo "-------setting-----------------"

echo "privateToken: $privateToken "
echo "id: $id "
echo "defaultlabels: $defaultlabels"

echo "-------create issues-----------"
cat issueList.txt | while read title labels
do
  echo "title: $title "
  echo "labels: $labels "

  if [ -n "$labels" ]; then
    # 追加ラベルが存在する
    labels=$defaultlabels,$labels
  else
    # デフォルトラベルのみ
    labels=$defaultlabels
  fi
  echo "-------------------------------"
  curl -v \
       --request POST \
       --header "PRIVATE-TOKEN: $privateToken" \
       -H "Content-Type: application/json" \
       -d "{\"title\":\"$title\",\"labels\":\"$labels\"}" \
       "https://gitlab.com/api/v4/projects/$id/issues" 
done
privateToken=""
id=""