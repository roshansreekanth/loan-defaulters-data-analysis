//----------------------------------------------------
//
//  CREATE AND INITIATE THE REPLICA SETS AND SHARDS
//
//----------------------------------------------------
//
//------------------------------------------------
// 0. Set myName to the name of the computer
//------------------------------------------------
//
var myName = "LAPTOP-F1IC05QJ";
//
//------------------------------------------------
// 1. GLOBAL VARIABLES
//------------------------------------------------
//
db = db.getSisterDB("config");
var mongosConn = db;
var res = null;
//
//------------------------------------------------
// 2. SET THE CHUNK SIZE
//------------------------------------------------
// Chunk size is the size of groups of data that are used in the fair distribution algorithm. 1 is the smallest chunk size to be set
db.settings.save( { _id:"chunksize", value: 1 } )
//
//------------------------------------------------
// 3. DUBLIN
//------------------------------------------------
//
// 1. CONNECT TO THE PROPER mongod PROCESS
// Connecting to one of the mongo servers setup in the first script. The port number of the server is specified (Dublin).
db = connect(myName+".local:27000/test");
//
// 2. INITIATE THE REPLICA SET
// rs.initiate initiates a replica set. The 3 servers are the components of the replica set. The servers could become part of the Dublin
// replica set.
res = rs.initiate(
    {
        "_id" : "dublin",
        "members" : [
            { _id:0,host:myName+".local:"+"27000" },
            { _id:1,host:myName+".local:"+"27001" },
            { _id:2,host:myName+".local:"+"27002" }
        ]
    }
);
//
// 3. WAIT UNTIL ALL THE NODES OF THE REPLICA SET ARE UP AND RUNNING
//
while (res.ok != 1){ 
    sleep(10); // If result is not OK it waits until the replica set is set up. 
}
print("Dublin Replica Set Created!");
while (((rs.status().members[0].state != 1) && (rs.status().members[0].state != 2)) || ((rs.status().members[1].state != 1) && (rs.status().members[1].state != 2)) || ((rs.status().members[2].state != 1) && (rs.status().members[2].state != 2))) {
    sleep(10);
}
print("Dublin Replica Set Up!");
//
// 4. ADD THE SHARD
//
db = mongosConn;
res = sh.addShard("dublin/"+myName+".local:27000"); // The replica set is added to the cluster as a shard.
while (res.ok != 1){
    sleep(60); // Give it time to complete before moving on
    if (res.ok != 1){
        print("Adding Shard Failed. Trying it again");
        res = sh.addShard("dublin/"+myName+".local:27000"); // Name of the replica set is Dublin and the primary server is port 27000
    }
}
print("Dublin Shard Added!");
//
//------------------------------------------------
// 4. CORK
//------------------------------------------------
//
// 1. CONNECT TO THE PROPER mongod PROCESS
//
db = connect(myName+".local:27100/test");
//
// 2. INITIATE THE REPLICA SET
//
res = rs.initiate(
    {
        "_id" : "cork",
        "members" : [
            { _id:0,host:myName+".local:"+"27100" },
            { _id:1,host:myName+".local:"+"27101" },
            { _id:2,host:myName+".local:"+"27102" }
        ]
    }
);
//
// 3. WAIT UNTIL ALL THE NODES OF THE REPLICA SET ARE UP AND RUNNING
//
while (res.ok != 1){
    sleep(10);
}
print("Cork Replica Set Created!");
while (((rs.status().members[0].state != 1) && (rs.status().members[0].state != 2)) || ((rs.status().members[1].state != 1) && (rs.status().members[1].state != 2)) || ((rs.status().members[2].state != 1) && (rs.status().members[2].state != 2))) {
    sleep(10);
}
print("Cork Replica Set Up!");
//
// 4. ADD THE SHARD
//
db = mongosConn;
res = sh.addShard("cork/"+myName+".local:27100");
while (res.ok != 1){
    sleep(60);
    if (res.ok != 1){
        print("Adding Shard Failed. Trying it again");
        res = sh.addShard("cork/"+myName+".local:27100");
    }
}
print("Cork Shard Added!");
//
//------------------------------------------------
// 5. LIMERICK
//------------------------------------------------
//
// 1. CONNECT TO THE PROPER mongod PROCESS
//
db = connect(myName+".local:27200/test");
//
// 2. INITIATE THE REPLICA SET
//
res = rs.initiate(
    {
        "_id" : "limerick",
        "members" : [
            { _id:0,host:myName+".local:"+"27200" },
            { _id:1,host:myName+".local:"+"27201" },
            { _id:2,host:myName+".local:"+"27202" }
        ]
    }
);
//
// 3. WAIT UNTIL ALL THE NODES OF THE REPLICA SET ARE UP AND RUNNING
//
while (res.ok != 1){
    sleep(10);
}
print("Limerick Replica Set Created!");
while (((rs.status().members[0].state != 1) && (rs.status().members[0].state != 2)) || ((rs.status().members[1].state != 1) && (rs.status().members[1].state != 2)) || ((rs.status().members[2].state != 1) && (rs.status().members[2].state != 2))) {
    sleep(10);
}
print("Limerick Replica Set Up!");
//
// 4. ADD THE SHARD
//
db = mongosConn;
res = sh.addShard("limerick/"+myName+".local:27200");
while (res.ok != 1){
    sleep(60);
    if (res.ok != 1){
        print("Adding Shard Failed. Trying it again");
        res = sh.addShard("limerick/"+myName+".local:27200");
    }
}
print("Limerick Shard Added!");
//
//------------------------------------------------
// 6. GALWAY
//------------------------------------------------
//
// 1. CONNECT TO THE PROPER mongod PROCESS
//
db = connect(myName+".local:27300/test");
//
// 2. INITIATE THE REPLICA SET
//
res = rs.initiate(
    {
        "_id" : "galway",
        "members" : [
            { _id:0,host:myName+".local:"+"27300" },
            { _id:1,host:myName+".local:"+"27301" },
            { _id:2,host:myName+".local:"+"27302" }
        ]
    }
);
//
// 3. WAIT UNTIL ALL THE NODES OF THE REPLICA SET ARE UP AND RUNNING
//
while (res.ok != 1){
    sleep(10);
}
print("Galway Replica Set Created!");
while (((rs.status().members[0].state != 1) && (rs.status().members[0].state != 2)) || ((rs.status().members[1].state != 1) && (rs.status().members[1].state != 2)) || ((rs.status().members[2].state != 1) && (rs.status().members[2].state != 2))) {
    sleep(10);
}
print("Galway Replica Set Up!");
//
// 4. ADD THE SHARD
//
db = mongosConn;
res = sh.addShard("galway/"+myName+".local:27300");
while (res.ok != 1){
    sleep(60);
    if (res.ok != 1){
        print("Adding Shard Failed. Trying it again");
        res = sh.addShard("galway/"+myName+".local:27300");
    }
}
print("Galway Shard Added!");
// The shards are setup with the replica set within them. The interface and configuration servers are setup. Now a client must 
// to the cluster
//------------------------------------------------
// 7. QUIT
//------------------------------------------------
//
quit()

