import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class UIPart extends StatelessWidget {
   UIPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
           body:Center(
            child: Container(
              child: Stack(
                alignment: Alignment.center,
           children: [
             Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,color: Colors.white,),
             Container(
                 decoration:  BoxDecoration(
                     borderRadius:const  BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(85),bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20)),
                     gradient: LinearGradient(
                       begin: Alignment.topRight,
                       end: Alignment.bottomLeft,
                       colors: [
                         Colors.deepOrange.shade300,
                         Colors.deepOrange.shade200,
                       ],
                     ),
                   boxShadow:const [
                     BoxShadow(
                       color: Colors.grey,
                       offset: Offset(0.0, 1.0), //(x,y)
                       blurRadius: 10.0,
                     ),
                   ],
                 ),
                 height: 330,
                 width: MediaQuery.of(context).size.width * 0.55,
               ),
             Positioned(
                 left: 100,
                 top: 250,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Stack(
                       clipBehavior: Clip.none,
                       children: [
                         Positioned(
                           top:-20,
                           left: -20,
                           child: Container(
                             height: 125.0,
                             width: 125.0,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               color: Colors.white.withOpacity(0.3),
                             ),
                           ),
                         ),
                         Image.asset("assets/images/breakfast.png",height: 100,width: 100,),
                       ],
                     ),
                   Padding(
                     padding: const EdgeInsets.only(left: 16.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const SizedBox(height: 5,),
                          const Text("Breakfast",style:  const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0,fontStyle: FontStyle.normal),),
                           const SizedBox(height: 25.0,),
                         const Text("Bread,",style:  TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15.0),),
                         const SizedBox(height: 5,),
                         const Text("Peanut butter,",style:  const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15.0),),
                         const SizedBox(height: 5,),
                         const Text("Apple",style:  TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15.0),),
                         const SizedBox(height: 30,),
                         Row(
                           textBaseline: TextBaseline.alphabetic,
                           crossAxisAlignment: CrossAxisAlignment.baseline,
                           children: const [
                              Text("525",style:   TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 40.0),),
                             SizedBox(width: 10,),
                             Text("Kcal",style:   TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15.0),),
                           ],
                         ),
                       ],
                     ),
                   )
                   ],
                 )),
           ],
              ),
            ),
          ),
    );
  }

  Future<List<FileSystemEntity>> dirContents(Directory dir) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    lister.listen (
            (file) => files.add(file),
        // should also register onError
        onDone:   () => completer.complete(files)
    );
    return completer.future;
  }
}
