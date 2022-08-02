import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todquest/bussines_logic/page2_bloc/page_2_bloc.dart';
import 'package:todquest/bussines_logic/page2_bloc/page_2_event.dart';
import 'package:todquest/bussines_logic/page2_bloc/page_2_state.dart';
import 'package:todquest/controller/maincotroller.dart';

import '../../data/user_model.dart';
class Page2 extends StatefulWidget {

  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late MainController mainController;

  TextEditingController searchController = TextEditingController();
  String dropdownValue = 'All';


  @override
  Widget build(BuildContext context) {
    mainController = Provider.of<MainController>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page2"),
        backgroundColor: Colors.deepOrangeAccent.shade100,
      ),
      body: BlocConsumer<Page2Bloc,Page2State>(
        listener: (context,state) {

        },
        builder: (context,state){
          if(state is Page2LoadingState) {
            return Center(child: const CircularProgressIndicator(),);
          } else if(state is Page2WorkingState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.deepOrangeAccent.withOpacity(0.5)
                            ),
                            child: TextField(
                              onChanged: (value) {
                                if(value.length > 1) {
                                  BlocProvider.of<Page2Bloc>(context).add(Page2SearchEvent(listOfUsers: state.listOfUser, value: value));
                                } else {
                                  BlocProvider.of<Page2Bloc>(context).add(Page2InitialEvent());
                                }
                              },
                              controller: searchController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),

                              ),
                            ),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        onTap: (){
                          BlocProvider.of<Page2Bloc>(context).add(Page2InitialEvent());
                        },
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                          if(dropdownValue == "All") {
                            BlocProvider.of<Page2Bloc>(context).add(Page2InitialEvent());
                          }else{
                            BlocProvider.of<Page2Bloc>(context).add(Page2FilterEvent(listOfUsers: state.listOfUser, value: dropdownValue));
                          }
                        },
                        items: <String>["All",'Google','FaceBook','Instagram','Organic','Friend'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  state.listOfUser.isNotEmpty ? ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.listOfUser.length,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent.shade100,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name:${state.listOfUser[index].name}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                    Text("Email:${state.listOfUser[index].email}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                    Text("Where are you from:${state.listOfUser[index].from}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              )
                          ),
                        );
                      }
                  ) : Center(child: Text("No Dat found"),),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("yaha"),
            );
          }
        },
      ),
    );
  }
}
