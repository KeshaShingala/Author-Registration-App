import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../globals/global.dart';

class splash_screens extends StatefulWidget {
  const splash_screens({Key? key}) : super(key: key);

  @override
  State<splash_screens> createState() => _splash_screensState();
}

class _splash_screensState extends State<splash_screens> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: MasonryGridView.count(
            itemCount: photos.length,
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.asset(photos[index]["image"]),
                ),
              );
            },
          ),),
          Expanded(
            flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text("Welcome",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.w800),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text("to Planz",style: TextStyle(color: Colors.white,fontSize: 45,fontWeight: FontWeight.w800),),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text("Chack, and Add your book......",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: InkWell(
                      onTap: (){
                        setState((){
                          Navigator.of(context).pushNamed('Homepage');
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Text("Continue",style: TextStyle(color: Color(0XFF0793B6),fontSize: 25,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      backgroundColor: Color(0XFF0793B6),
    );
  }
}
