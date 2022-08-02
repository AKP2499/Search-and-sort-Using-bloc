
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todquest/bussines_logic/page2_bloc/page_2_event.dart';
import 'package:todquest/controller/maincotroller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todquest/screen/screen_1/page2.dart';
import 'package:todquest/screen/ui.dart';
import 'package:todquest/utils/session_manager.dart';

import '../../bussines_logic/page2_bloc/page_2_bloc.dart';
class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}
class _Page1State extends State<Page1> {
  late MainController mainController;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String dropdownValue = 'FaceBook';

  @override
  Widget build(BuildContext context) {
    mainController = Provider.of<MainController>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        title: const Text("Page1"),
      ),
      body: Form(
        key: context.watch<MainController>().accountFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  TextField(
                  controller:_emailController,
                    decoration: const InputDecoration(
                      hintText: "email",
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Google','FaceBook','Instagram','Organic','Friend'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: ()async{
                  var userList = await SessionManager.getUserList();
                  String? profileOk = _checkFields(name: _nameController.text.trim(), email: _emailController.text.trim(), dropDownValue: "ehbd");
                  if(profileOk == null) {
                    mainController.addItemToList(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        dropDownValue: dropdownValue,
                    );
                    // ignore: use_build_context_synchronously
                    _emailController.text = "";
                    _nameController.text = "";
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(profileOk),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrangeAccent.shade100,
                  ),
                  child:const Text('Add'),
                ),
              ),
              // ElevatedButton(onPressed: () async {
              //   var userList = await SessionManager.getUserList();
              //   if(userList != null) {
              //     print("*************${userList.length}");
              //     Navigator.push (
              //       context,
              //       MaterialPageRoute (
              //         builder: (BuildContext context) =>  Page2(),
              //       ),
              //     );
              //   }
              // }, child: Text("check"))
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: ()async{
                  var userList = await SessionManager.getUserList();
                  if(userList != null){
                    // ignore: use_build_context_synchronously
                    Navigator.push (
                      context,
                      MaterialPageRoute (
                        builder: (BuildContext context) =>  BlocProvider(
                          create:(context) => Page2Bloc(listOfUser: userList)..add(Page2InitialEvent()),
                            child: Page2()),
                      ),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("List is Empty"),
                      duration: Duration(seconds: 2),
                    ));
                  }

                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrangeAccent.shade100,
                  ),
                  child:const Text('UserList'),
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  Navigator.push (
                    context,
                    MaterialPageRoute (
                      builder: (BuildContext context) =>  UIPart(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrangeAccent.shade100,
                  ),
                  child:const Text('UI Page'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? _checkFields({required String? name,required String? email,required String? dropDownValue}) {
  if(name == null || name == "") {
    return "Please fill you name";
  } else if(email == null || email == "") {
    return "Please fill you email";
  } else if(dropDownValue == null || dropDownValue == "") {
    return "Select field";
  }
  return null;
}
