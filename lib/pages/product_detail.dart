import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/services/constant.dart';
import 'package:flutter_project/services/database.dart';
import 'package:flutter_project/services/shared_pref.dart';
import 'package:flutter_project/widget/support_widget.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  String image,name,detail,price;
  ProductDetail({required this.detail,required this.name,required this.price,required this.image});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String? name, mail, image;

  getthesharedpref()async{
    name=await SharedPreferenceHelper().getUserName();
    mail=await SharedPreferenceHelper().getUserEmail();
    image=await SharedPreferenceHelper().getUserImage();
    setState(() {

    });
  }
  ontheload()async{
    await getthesharedpref();
    setState(() {

    });
  }
  @override
  void iniState(){
    super.initState();
    ontheload();
  }

  Map<String, dynamic>? paymentIntent;

  get secretKey => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffef5f1),
      body: Container(
        padding: EdgeInsets.only(top:50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Stack(
            children: [GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(30)),
                  child: Icon(Icons.arrow_back_ios_new_outlined)),
            ),
              Center(child: Image.asset("images/headphone2.png",height: 300,))

          ]),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20) )
                ),
                width: MediaQuery.of(context).size.width,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Headphone",style: AppWidget.boldTextFeildStyle(),),
                        Text("\$300", style: TextStyle(color: Color(0xfffd6f3e),
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Text("Details",style: AppWidget.semiboldTextFeildStyle(),),
                    SizedBox(height: 10.0,),
                    Text("The product is very good. It have a 1 year waranty,These headphone are too good like if you can also listen a person who is speaking slowly. These headphone are also good by the lookwise "),
                   SizedBox(height: 90.0,),
                    GestureDetector(
                      onTap:(){ makePayment(widget.price);
                        },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xfffd6f3e),borderRadius: BorderRadius.circular(10)
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),)),
                      ),
                    )
                  ],
                ) ,
              ),
            )
       ],),
      ),
    );
  }


  Future<void> makePayment(String amount) async{
    try{
      paymentIntent= await createPaymentIntent(amount,'USD');
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent?['client_secret'],
        style: ThemeMode.dark,merchantDisplayName: 'Adnan'
      )).then((value){});

      displayPaymentSheet();
    }catch(e,s){
      print('exception:$e$s');
    }
  }
  displayPaymentSheet()async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value) async{
       Map<String,dynamic> orderInfoMap={
         "Product": widget.name,
         "Price":widget.price,
         "Name":name,
         "Email": mail,
         "Image": image,
         "ProductImage": widget.image,
       };
     //  await DatabaseMethods().orderDetails(userInfoMap);
        showDialog(
            context: context, builder: (_)=> AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [Row(children: [
            Icon(Icons.check_circle,color: Colors.green,),
            Text("Payment Successful")
          ],)],
        ),

        ));
        paymentIntent=null;
      }).onError((error, stackTrace){
        print("Error is :---> $error $stackTrace");
      });
    }on StripeException catch(e){
      print("Error is:---> $e");
      showDialog(context: context, builder: (_)=> AlertDialog(
        content: Text("Cancelled"),
      ));
    }catch(e){
      print('$e');
    }
  }

  createPaymentIntent(String amount, String  currency)async{
    try{
      Map<String, dynamic> body={
        'amount' : calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]':'card'
      };
      var response =await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers:{'Authorization': 'Bearer $secretKey','Content-Type':'application/x-www-form-urlencoded',
          },body: body,
      );
      return jsonDecode(response.body);
    }catch(err){
      print("err charging user: ${err.toString()}");
    }
  }
  calculateAmount(String amount){
    final calculatedAmount=(int.parse(amount)*100);
    return calculatedAmount.toString();
  }
}
