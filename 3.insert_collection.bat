REM #
REM #---------------------------------------------------#
REM #						        #
REM # 5. Insert collection from File		        #
REM #						        #
REM #---------------------------------------------------#
REM #	
mongoimport --db test --collection restaurants --drop --file 3.restaurants_dataset.json
REM # importing the data. Deletes it if it is already created
pause
REM #



