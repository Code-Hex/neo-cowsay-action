#!/bin/bash

function parseInputs {
  # Required inputs
  if [ "${INPUT_MESSAGE}" != "" ]; then
    message=${INPUT_MESSAGE}
  else
    echo "Input message cannot be empty"
    exit 1
  fi

  # Optional inputs
  cow=${INPUT_COW}
  onComment=0
  if [ "${INPUT_COWSAY_ON_COMMENT}" == "1" ] || [ "${INPUT_COWSAY_ON_COMMENT}" == "true" ]; then
    onComment=1
  fi
  outputName=${INPUT_COWSAY_TO_OUTPUT}
}

function installNeoCowsay {
  version="v0.1.1"
  file="cowsay_${version}_Linux_x86_64.tar.gz"
  url="https://github.com/Code-Hex/Neo-cowsay/releases/download/${version}/${file}"
  echo "Downloading Neo-cowsay"
  curl -s -S -L -o /tmp/${file} ${url}
  if [ "${?}" -ne 0 ]; then
    echo "Failed to download Neo-cowsay"
    exit 1
  fi
  echo "Successfully downloaded Neo-cowsay"

  echo "Unarchiving Neo-cowsay"
  tar -xzf /tmp/${file} -C /usr/local/bin
  if [ "${?}" -ne 0 ]; then
    echo "Failed to unarchiving Neo-cowsay"
    exit 1
  fi
  echo "Successfully unarchiving Neo-cowsay"
}

function main {
  parseInputs
  installNeoCowsay

  result=$(echo $message | cowsay -n -f $cow)

  # Set cowsay to output
  if [ "${outputName}" != "" ]; then
    # https://github.community/t5/GitHub-Actions/set-output-Truncates-Multiline-Strings/m-p/38372/highlight/true#M3322
    fmtResult="${result//'%'/'%25'}"
    fmtResult="${fmtResult//$'\n'/'%0A'}"
    echo "##[set-output name=${outputName};]${fmtResult}"
  fi

  # Comment on the pull request if necessary.
  if [ "$GITHUB_EVENT_NAME" == "pull_request" ] && [ "${onComment}" == "1" ]; then    
    commentsURL=$(cat ${GITHUB_EVENT_PATH} | jq -r .pull_request.comments_url)
    commentFromCowsay="### Message from cowsay
\`\`\`
${result}
\`\`\`
"
    payload=$(echo "${commentFromCowsay}" | jq -R --slurp '{body: .}')
    echo "${payload}" | curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data @- "${commentsURL}" > /dev/null
  fi

  # If Didn't set optional values
  if [ "${outputName}" == "" ] && [ "${onComment}" == "0" ]; then
    echo "${result}"
  fi
}

main "${*}"
