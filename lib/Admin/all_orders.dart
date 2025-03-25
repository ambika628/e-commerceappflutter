import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/services/database.dart';
import 'package:flutter_project/widget/support_widget.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  Stream?  orderStream;

//
// getontheload()async{
//   orderStream=await DatabaseMethods().allOrders();
//   setState(() {
//
//   });
// }
// @override
//   void initState() {
//    getontheload();
//     super.initState();
//   }

  Widget allOrders() {
    return StreamBuilder(
        stream: orderStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData ?
      ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];

            return
              Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(children: [
                    Row(
                      children: [
                        Image.network(
                          ds["ProductImage"], height: 120, width: 120, fit:
                        BoxFit.cover,),
                        SizedBox(width: 30.0,),
                        Column(children: [
                          Text(ds["Product"],
                            style: AppWidget.semiboldTextFeildStyle(),),


                        ],)
                      ],
                    )
                  ],),
                ),
              );
          }) : Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Orders",style: AppWidget.boldTextFeildStyle(),),),
      body: Container(
        margin: EdgeInsets.only(left: 20.0,right: 20.0),
        child: Column(children: [
         ],),
      ),
    );
  }
}
