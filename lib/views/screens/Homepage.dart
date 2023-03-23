
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:image_picker/image_picker.dart';

import '../../helpers/firebase_auth_helpers.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  GlobalKey<FormState> authorKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bookController = TextEditingController();
  String name = "";
  String book = "";
  Uint8List? image;
  Uint8List? decodedImage;
  String encodedImage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Author Registration",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        backgroundColor: Color(0xff058BB0),
        leading: Icon(Icons.arrow_back_ios,color: Colors.white,
        ),
      ),
      body:  SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseCloudHelper.firebaseCloudHelper.fetchAllData(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot querySnapshot = snapshot.data!;
              List<QueryDocumentSnapshot> queryDocumentSnapshot = querySnapshot.docs;

              return ListView.builder(
                itemCount: queryDocumentSnapshot.length,
                itemBuilder: (context, i) {
                  Map<String, dynamic> data = queryDocumentSnapshot[i].data() as Map<String, dynamic>;

                  if (data["image"] != null) {
                    // decodedImage == null;
                    decodedImage = base64Decode(data["image"]);
                  } else {
                    decodedImage == null;
                  }
                  //image = base64Decode(data['image']);

                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              SizedBox(width: 20,),
                              Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Author : ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Color(0XFF79A7BB),
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${data["name"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color:  Color(0XFF1B4758),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                     Spacer(),
                                          InkWell(
                                            onTap: () async {
                                              deleteData(id: queryDocumentSnapshot[i].id);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                              SizedBox(width: 15,),
                            ],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width: 20,),
                              Text(
                                "Books : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0XFF79A7BB),
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                "${data["book"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:  Color(0XFF1B4758),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );


                  // return Padding(
                  //   padding: EdgeInsets.all(12),
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     height: 220,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         // (decodedImage == null)
                  //         //     ? Text(
                  //         //   "NO IMAGE",
                  //         //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                  //         // )
                  //         //     : Container(
                  //         //   height: 130,
                  //         //   width: 100,
                  //         //   decoration: BoxDecoration(
                  //         //     color: Colors.white.withOpacity(0.7),
                  //         //     borderRadius: BorderRadius.circular(10),
                  //         //   ),
                  //         //   child: ClipRRect(
                  //         //     borderRadius: BorderRadius.circular(10),
                  //         //     child: Image.memory(
                  //         //       decodedImage!,
                  //         //       fit: BoxFit.cover,
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //         SizedBox(height: 15,),
                  //         Row(
                  //           children: [
                  //             Text.rich(
                  //               TextSpan(
                  //                 children: [
                  //                   TextSpan(
                  //                     text: "Author : ",
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 20,
                  //                       color: Color(0XFF79A7BB),
                  //                       letterSpacing: 2,
                  //                     ),
                  //                   ),
                  //                   TextSpan(
                  //                     text: "${data["name"]}",
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 18,
                  //                       color:  Color(0XFF1B4758),
                  //                       letterSpacing: 2,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             const Spacer(),
                  //             InkWell(
                  //               onTap: () async {
                  //                // deleteOneData(id: queryDocumentSnapshot[i].id);
                  //               },
                  //               child: Icon(
                  //                 Icons.delete_forever,
                  //                 color: Colors.redAccent,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Books : ",
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 20,
                  //                 color: Color(0XFF79A7BB),
                  //                 letterSpacing: 2,
                  //               ),
                  //             ),
                  //             Container(
                  //               height: 20,
                  //               width: 225,
                  //               padding: EdgeInsets.only(top: 3),
                  //               child: Text(
                  //                 "${data["book"]}",
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 16,
                  //                   color:  Color(0XFF1B4758),
                  //                   letterSpacing: 2,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff058BB0),
        onPressed: (){
          ValidateAndInsert(context);
        },
        label: Text("Add",style: TextStyle(fontSize: 22),),
        icon: Icon(Icons.add,size: 30,),
      ),
      backgroundColor: Color(0XFF9ACEDD),
    );
  }


  ValidateAndInsert(context) {
    return showDialog(
        context: context,
        builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xff0085AA),
              title: Text(
                "Add Book",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800,color: Colors.white),
              ),
              content: Form(
                key: authorKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ink(
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color:  Color(0XFF79A7BB),
                    //   ),
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(50),
                    //     onTap: () async {
                    //       final ImagePicker _picker = ImagePicker();
                    //
                    //       XFile? img = await _picker.pickImage(source: ImageSource.gallery);
                    //
                    //       if (img != null) {
                    //         File compressedImage = await FlutterNativeImage.compressImage(img.path);
                    //         image = await compressedImage.readAsBytes();
                    //         encodedImage = base64Encode(image!);
                    //
                    //       }
                    //       setState(() {});
                    //     },
                    //     child: CircleAvatar(
                    //       backgroundColor:  Color(0XFF79A7BB),
                    //       radius: 50,
                    //       child: Center(
                    //         child: image == null
                    //             ? const Text(
                    //           "ADD IMAGE",
                    //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                    //         )
                    //             : Container(
                    //           height: 100,
                    //           width: 100,
                    //           decoration: BoxDecoration(
                    //             color: Colors.white.withOpacity(0.7),
                    //           ),
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(50),
                    //             child: Image.memory(
                    //               image!,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter name First...";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        name = val!;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.grey.shade200)),
                        hintText: "Enter name...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter book First...";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        book = val!;
                      },
                      controller: bookController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.grey.shade200)),
                        hintText: "Enter Book...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (authorKey.currentState!.validate()) {
                      authorKey.currentState!.save();

                      await FirebaseCloudHelper.firebaseCloudHelper.insertData(name: name, book: book,);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Failed To Add data"),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                    nameController.clear();
                    bookController.clear();

                    setState(() {
                      name = "";
                      book = "";
                    });
                    Navigator.pop(context);
                  },

                  child: Text("Save",style: TextStyle(color:  Color(0xff0085AA),),),
                ),
                OutlinedButton(
                  onPressed: () {
                    nameController.clear();
                    bookController.clear();

                    setState(() {
                      name = "";
                      book = "";
                    });

                    Navigator.pop(context);
                  },
                  child: Text("Clear",style: TextStyle(color: Colors.white),),),
              ],
            );
        });
  }


  deleteData({required String id}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        title: const Text("Delete Data",style: TextStyle(color: Colors.red),),
        content: const Text(
          "Are you sure for delete",
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              FirebaseCloudHelper.firebaseCloudHelper.deleteData(deleteId: id);

              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

}


