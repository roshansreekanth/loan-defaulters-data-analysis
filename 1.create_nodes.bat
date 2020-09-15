REM #
REM #-------------------------------------------------#
REM #						      #
REM # 0. Set myName to the name of the computer       #
REM #						      #
REM #-------------------------------------------------#
REM #	
SET myName=LAPTOP-F1IC05QJ
REM #
REM #-------------------------------------------------#
REM #						      #
REM # 1. Start the config server database instances   #
REM #						      #
REM #-------------------------------------------------#
REM #	
REM # 1.1. Create the data directory for each of the config servers
REM #	
REM # The following three directories store the data for the configuration servers. They are all independent of each other
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cfg0"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cfg1"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cfg2"
REM #	
REM # 1.2. Start the config server instances 
REM #	
REM # /b means the process will run in the background without taking up the current thread.
REM # All mongo executables are stored as environment variables so it is accessible from anywhere
REM # The mongo server is working as a configuration server. opLog stores a history of ec=verything that's happening in the cluster. 1 is the smallest size
REM # dbPath is the directory in which the config server stores the information. --port is the port at which the config server will wait to handle requests.
REM # Each server stores the information in a different directory.
start /b mongod --oplogSize 1 --configsvr -dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cfg0" --port 26050
start /b mongod --oplogSize 1 --configsvr --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cfg1" --port 26051
start /b mongod --oplogSize 1 --configsvr --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cfg2" --port 26052
REM #	
REM #-------------------------------------------------#

REM #						      #
REM # 2. Start the C:\MongoDB_3_0\bin\mongos instances   		      #
REM #						      #
REM #-------------------------------------------------#
REM #	
REM # 2.1. A first C:\MongoDB_3_0\bin\mongos process listens to the default port 27017
REM #	
echo Start the C:\MongoDB_3_0\bin\mongos instances
start /b mongos --configdb %myName%.local:26050,%myName%.local:26051,%myName%.local:26052


REM #	
REM # 2.2. Remaining C:\MongoDB_3_0\bin\mongos processes listen to the explicit ports assigned by us
REM #
REM # mongos is used to start the interface servers (in background mode). The port number is used to detect the location of the configuration server.	
start /b mongos --configdb %myName%.local:26050,%myName%.local:26051,%myName%.local:26052 --port 26061
start /b mongos --configdb %myName%.local:26050,%myName%.local:26051,%myName%.local:26052 --port 26062
start /b mongos --configdb %myName%.local:26050,%myName%.local:26051,%myName%.local:26052 --port 26063

REM #	
REM #-------------------------------------------------#
REM #						      #
REM # 3. Create the shards of our cluster	      #
REM #						      #
REM #-------------------------------------------------#
REM #	
REM # 3.1. Create the data directory for each of the replica sets servers
REM # Each directory stores data when the mongo servers are started. 
echo Create the data directory for each of the replica sets servers
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\dublin0"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\dublin1"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\dublin2"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cork0"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cork1"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cork2"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\limerick0"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\limerick1"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\limerick2"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\galway0"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\galway1"
mkdir "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\galway2"
REM #	
REM # 3.2. Start each member of the replica set 
REM # Each mongo server could become a part of a relica set in the future (--replSet). If it is part of a replica set, it will be called Dublin/Cork/Limerick/Galway
REM # The information will be stored in the directories specified with an opLog size of 1. We also specify the port the mongo server is going to wait on. The 12 servers
REM # will be running in background mode.
echo  3.2. Start each member of the replica set 
start /b mongod --replSet dublin --oplogSize 1 --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\dublin0" --port 27000
start /b mongod --replSet dublin --oplogSize 1 --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\dublin1" --port 27001
start /b mongod --replSet dublin --oplogSize 1 --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\dublin2" --port 27002
start /b mongod --oplogSize 1 --replSet cork --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cork0" --port 27100
start /b mongod --oplogSize 1 --replSet cork --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cork1" --port 27101
start /b mongod --oplogSize 1 --replSet cork --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\cork2" --port 27102
start /b mongod --oplogSize 1 --replSet limerick --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\limerick0" --port 27200
start /b mongod --oplogSize 1 --replSet limerick --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\limerick1" --port 27201
start /b mongod --oplogSize 1 --replSet limerick --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\limerick2" --port 27202
start /b mongod --oplogSize 1 --replSet galway --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\galway0" --port 27300
start /b mongod --oplogSize 1 --replSet galway --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\galway1" --port 27301
start /b mongod --oplogSize 1 --replSet galway --dbpath "C:\Users\rosha\OneDrive - mycit.ie\NoSQL Data Architectures\Assignment 2\distribc\galway2" --port 27302
pause
REM # Now the interface servers and the configuration servers are running (to store metadata). The following scripts will be setting up shards.
