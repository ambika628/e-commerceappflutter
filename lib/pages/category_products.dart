import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/product_detail.dart';
import 'package:flutter_project/services/database.dart';

import '../widget/support_widget.dart';

class CategoryProducts extends StatefulWidget {
  String category;
  CategoryProducts({required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
 Stream? CategoryStream;

getontheload()async{
  CategoryStream= await DatabaseMethods().getProducts(widget.category);
  setState(() {

  });

}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget allProducts(){
    return StreamBuilder(stream: CategoryStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.6, mainAxisSpacing: 10.0,crossAxisSpacing:10.0 ),itemCount:snapshot.data.docs.length , itemBuilder: (context, index){
            DocumentSnapshot ds=snapshot.data.docs[index];

            return
              Container(
                height:210 ,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                Container(

                padding:EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(children: [
                  SizedBox(height: 10.0,),
                  Image.network(
                    ds["Image"],
                    height: 120,width: 120,
                    fit: BoxFit.cover,),
                  Text(
                    ds["Name"],
                    style: AppWidget.semiboldTextFeildStyle(),),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Text(
                        "\$"+ds["Price"],style: TextStyle(color: Color(0xfffd6f3e),fontSize: 20.0,fontWeight: FontWeight.bold),),
                      SizedBox(width: 40.0,),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(detail: ds["Detail"], name: ds["Name"], price: ds["Price"], image: ds["Image"])));
                        } ,
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Color(0xfffd6f3e),borderRadius: BorderRadius.circular(5)),
                            child: Icon(Icons.add,color: Colors.white,)),
                      )
                    ],)
                ],),
              )]));

      }):Container();
    });

}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(backgroundColor: Color(0xfff2f2f2),),
      body: Container(
        margin: EdgeInsets.only(left: 20.0,right:20.0 ),
        child: Column(
        children: [
        Expanded(child: allProducts())
      ],),),
    );
  }
}
