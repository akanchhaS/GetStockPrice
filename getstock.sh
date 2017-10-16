#!/bin/bash

##read the stock ticker from external file giving complete path
readarray ticker < <PATH_OF_TXT_FILE_HERE>

##for each ticker get invoke the yahoo api to get the price and append the ticker and price 
for i in "${ticker[@]}"
do
        #echo $i
        j=$(echo $i | sed -e 's/$i//g')
        url="http://download.finance.yahoo.com/d/quotes.csv?s=$j&f=l1"
        quot=$(curl -s $url)
        body+="$j":"$quot " #appending ticker name and value to body variable
done

##Replace all the spaces with comma, as otherwise it will break the curl
finbody=`echo $body | sed -e 's/\s/,/g'`

##print the final body to consol
echo $finbody

##Create an array of phone numbers on which message to be sent
declare -a phnum=('+14xxxxxxxx0' '+16xxxxxxxx6')


##Loop through the numbers and send the POST to Twilio api though curl
for number in "${phnum[@]}"
	do
		curl 'https://api.twilio.com/2010-04-01/Accounts/AC5420ccc34e76152d5c665ef792e860d7/Messages.json' -X POST \
		--data-urlencode 'To='$number \
		--data-urlencode 'From=<YOUR_TWILIO_NUMBER>' \
		--data-urlencode 'Body=Current price'$finbody \
		-u <ACCOUNT_SID>:<AUTH_TOKEN_KEY>
		echo "message sent to"$number 
	done
echo "all messages sent"



