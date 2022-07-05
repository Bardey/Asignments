touch dataLogger.sh
chmod 777 dataLogger.sh
nano dataLogger.sh 

//Inside of script

echo "Store new data in here" > demand_data.txt
currentDate=`date`
echo $currentDate >> demands.log 


