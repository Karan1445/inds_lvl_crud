import "dart:convert";

import "package:http/http.dart" as http;
import "package:sqflite/sqflite.dart";
class MyDataBaseOp{

  Future<Database> onInit() async {
  Database db=await openDatabase("demo.db",onCreate: (db, version) {
    db.execute("create table demo(id integer,name text,email text,gender text,job text)");
  },version: 1);
  return db;
  }

  Future<List> onGetAll() async {
    Database db=await onInit();
    List DatabaseList=await db.query("demo");
    var res =await http.get(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata"));
    List<dynamic> ApiData=await jsonDecode(res.body);
    //Comparision logic
  print(" ${DatabaseList.length} ${ApiData.length}");
    if(DatabaseList.length==ApiData.length){
      print("hellas");
      return DatabaseList;
    }else{
      print("del");
      await db.delete("demo");
      for(var i=0;i<ApiData.length;i++){
        db.insert("demo", {"id":ApiData[i]["id"],"name":ApiData[i]["name"],
        "email":ApiData[i]["email"],"gender":ApiData[i]["gender"],"job":ApiData[i]["job"]});
      }
    }
    return DatabaseList;
  }
  
  Future<void> onDelete(id) async {
    Database db=await onInit();
    await db.delete("demo",where: "id = ?",whereArgs: [id]).then((value) async {
        await http.delete(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata/$id"));
    });
  }
  
  Future<void> onUpdate(map,id) async {
    Database db=await onInit();
    await db.update("demo",map,where: "id = ?",whereArgs: [id]).then((value) {
      http.put(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata/$id"),body: map);
    },);
  }
  
  Future<void> onPost(map) async {
    Database db=await onInit();
    await http.post(Uri.parse("https://65ded69bff5e305f32a09845.mockapi.io/fakedata"),body: map).then((value) async {
     await db.insert("demo",jsonDecode(value.body));
    });
  }
}