import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/services/database.dart';
import 'package:flutter_project/widget/support_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker= ImagePicker();
  File? selectedImage;
  TextEditingController namecontroller=new TextEditingController();

  Future getImage()async{
    var image= await _picker.pickImage(source: ImageSource.gallery);
    selectedImage=File(image!.path);
    setState(() {

    });

  }
  uploadItem()async{
    if(selectedImage!=null && namecontroller.text!=""){
      String addId=randomAlphaNumeric(10);
      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child("blogImage").child(addId);
      
      final UploadTask task=firebaseStorageRef.putFile(selectedImage!);
       var dowloadurl=await(await task).ref.getDownloadURL();

     Map<String, dynamic> addProduct={
       "Name":namecontroller.text,
       "Image": dowloadurl,
     };
     await DatabaseMethods().addProduct(addProduct, value!).then((value){});
     selectedImage=null;
      namecontroller.text="";
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Our Product hasbeen Uploaded Successfully!!!",style: TextStyle(fontSize: 20.0),)));

    }
  }
String? value;
  final List<String> categoryitem=[
    'Watch','laptop','TV','Headphone'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap:(){
              Navigator.pop(context);
            } ,
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text("Add Product ",style: AppWidget.semiboldTextFeildStyle(),),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        
            children: [
        Text("Upload the Product Image",style: AppWidget.lightTextFeildStyle(),),
            SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.camera_alt_outlined),
              ),
            ),SizedBox(height: 20.0,),
              Text("Product Name",
                style: AppWidget.lightTextFeildStyle(),),
              SizedBox(height: 20.0,),
        
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xffececf8),borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),SizedBox(height: 20.0,),
              Text("Product Category",style: AppWidget.lightTextFeildStyle(),
              ),SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xffececf8),borderRadius: BorderRadius.circular(10.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(items:categoryitem
                      .map((item) =>DropdownMenuItem(value: item,child: Text(item,style: AppWidget.semiboldTextFeildStyle(),))).toList(),onChanged:((value)=>setState((){
                    this.value=value;
                  })) ,
                  dropdownColor: Colors.white,
                    hint: Text("Select Categrory"),
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                    value: value,
                  ),
                ),),
              SizedBox(height: 20.0,),
              Center(
                  child: ElevatedButton(onPressed: (){
                    uploadItem();
                  }, child:Text("Add Product",style: TextStyle(fontSize: 22),)))
        
        
            ],),),
      ),
    );
  }
}
