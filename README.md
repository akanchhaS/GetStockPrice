# GetStockPrice

Script to recieve stock prices via sms at specific time of the day.

This script was created to know what is the current market price of the stock in the morning and before the market closes, via sms. The reason being, this information would come in handy if I wanted to buy or sell shares.

The script is written in bash and uses the following API(s):
a. Yahoo API to get the stock tiker's price
b. Twilio API to send sms to the verified numbers.

Steps to use the script:

1. Place the ticker of the company you are following in the txt file (one ticker in each line)
2. Replace <PATH_OF_TXT_FILE_HERE> with the absolute path of the text file created in Step 1.
If you are not sure, then get the present working directory and then prefix that to the file name.
 
  $pwd
  /home/ubuntu/ak
  
  absolute file path: /home/ubuntu/ak/<YOUR_FILENAME>
  /home/ubuntu/ak/filename.txt
  
3. Set up a Twilio Account (you can create a free trial account) here: https://www.twilio.com/try-twilio
4. Get the Account SiD and Auth token (refer: https://www.twilio.com/docs/api/messaging)
5. Create/choose your number.
6. If you want to send sms to multiple numbers add those numbers to the verified number list in your Twilio account. To verifiy the account an sms or call would be made to those numbers.
   Remember Twilio free account send sms to only verified/white listed numbers.
7. Add the verified phone numbers (to which messadge is to be sent) in the array 'phnum'
8. Replace the <ACCOUNT_SID> and <AUTH_TOKEN> with your account sid and auth token obtained in step 4.

P.S : To learn more about Twilio free trail account use: https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-


Logic:

1. Read the tickers line by line in the array 'ticker'
2. Loop through teh ticker array and make calls to Yahoo API to get the current stock price and add it to the body.
3. Create teh final body variable that will store the ticker name and value separated by comma.
4. Create an array phnum with the numbers to which sms is to be sent.
5. Loop through btoh the numbers, and make call to Twilio SMS API.

To recieve the sms everyday at 6 AM PST and 12 PM PST schedule a cron job.
1. Type:
$ crontab -e 
2. 0 13,19 * * 1-5 /home/ubuntu/ak/stock.sh 1>> /home/ubuntu/ak/quotelog.txt 2>> /home/ubuntu/ak/quoteerr.txt
