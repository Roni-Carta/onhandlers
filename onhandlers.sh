#!/bin/bash

# Request the MDN Documentation with all the Event Handlers
request=`curl -s https://developer.mozilla.org/en-US/docs/Web/Events`

# List of Xpaths with the event handlers that might be callable from HTML attributes
xpaths=(
	'//*[@id="content"]/article/div[3]/ul/li[6]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[7]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[11]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[13]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[14]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[15]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[16]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[17]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[18]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[19]/ul/li/a'
	'//*[@id="content"]/article/div[3]/ul/li[54]/ul/li/a'
)

# Fetching the Event Handlers on the page
for path in ${xpaths[@]}; do
	echo "$request" | xmllint --format --html --xpath "$path" - 2>/dev/null | sed 's|</a>|\n|g' | sed 's/.*">//g' | sed 's/ event//g' | sort -u | awk '{ print "on"$1}'
done | grep -v DOM | grep -v MS | sort -u
