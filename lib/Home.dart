import 'package:flutter/material.dart';
import 'package:ind_level_coding_crud/AddEditDemoPage.dart';
import 'package:ind_level_coding_crud/DatabaseFile/DBoprations.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MyDataBaseOp().onInit();
    List User=[];
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEdit(),)).then((value) {setState(() {});});
      },child: Icon(Icons.add),backgroundColor: Colors.transparent,elevation: 0,),
      body: FutureBuilder(
        future: MyDataBaseOp().onGetAll(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            User.clear();
            User.addAll(snapshot.data!);

            return ListView.builder(itemCount: User.length,itemBuilder: (context, index) {
                return Container(margin:const EdgeInsets.all(15),
                  child: ListTile(
                    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.purpleAccent)),
                    title: Column(
                      children: [
                        Text(User[index]["name"]),
                        Text(User[index]["email"]),
                        Text(User[index]["gender"]),
                      ],
                    ),
                    leading: GestureDetector(
                      onTap: () {
                            MyDataBaseOp().onDelete(User[index]["id"]).then((value) {
                              setState(() {});
                            });
                      },
                        child: Icon(
                            Icons.delete,color: Colors.grey)),
                    trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => AddEdit(userObject: {...User[index]}),)).then((value) {
                            setState(() {});
                          });
                        },
                        child: Icon(
                            Icons.edit,color: Colors.grey)),
                  ),
                );
            },);
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
