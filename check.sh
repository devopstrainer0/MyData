if jq -e . >/dev/null 2>&1 <<<"$json_string"; then
    echo "Parsed JSON successfully and got something other than false/null"
else
    echo "Failed to parse JSON, or got false/null"
fi


new_json_str=$(echo "$json_str" | jq 'del(.key_to_remove)')

jq 'del(.scanResults[].JsonResult.vulnerabilities[].details.body.htmlDetails)' input.json > updated_input.json


jq 'del(.scanResults[].JsonResult.vulnerabilities[].details.body.htmlDetails)' input.json > temp.json && mv temp.json input.json
    jq 'del(.scanResults[].JsonResult.vulnerabilities[].details.body.htmlDetails)' "$file" > temp.json && mv temp.json "$file"
