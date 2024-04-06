import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:ind_level_coding_crud/DatabaseFile/DBoprations.dart";
class AddEdit extends StatefulWidget {
  Map? userObject={};
   AddEdit({super.key,this.userObject});

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name=TextEditingController();
    TextEditingController email=TextEditingController();
    TextEditingController job=TextEditingController();
    TextEditingController gender=TextEditingController();
    name.text=widget.userObject?["name"]??"";
    email.text=widget.userObject?["email"]??"";
    job.text=widget.userObject?["job"]??"";
    gender.text=widget.userObject?["gender"]??"";
    return Scaffold(

      body: Column(
        children: [
          TextFormField(controller: name),
          TextFormField(controller: email,),
          TextFormField(controller: job,),
          TextFormField(controller: gender,),
          ElevatedButton(onPressed: () {
            widget.userObject!=null?
            MyDataBaseOp().onUpdate({"name":name.text,"email":email.text,"job":job.text,"gender":gender.text}, widget.userObject?["id"]).then((value) {
              Navigator.pop(context);
            }):
            MyDataBaseOp().onPost({"name":name.text,"email":email.text,"job":job.text,"gender":gender.text}).then((value) {
              Navigator.pop(context);
            })
            ;
          }, child: Text(widget.userObject==null?"Add":"edit")),
        ],
      ),
    );
  }
}
