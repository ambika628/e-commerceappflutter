import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/bottomnav.dart';
import 'package:flutter_project/pages/home.dart';
import 'package:flutter_project/pages/signup.dart';
import 'package:flutter_project/widget/support_widget.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email="", password="";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
    }
    on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("No User Found for that Email",style: TextStyle(fontSize: 20.0),)));
      }
      else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Wrong Password Provided by User ",style: TextStyle(fontSize: 20.0),)));

      }
    }
  }

  final _formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20.0,right: 20.0,left: 20.0,bottom: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Image.asset("images/login.png"),
              Center(child: Text("Sign In",style: AppWidget.semiboldTextFeildStyle(),)),
              SizedBox(height: 20.0,),
              Text("Please enter the details below to\n                       continue",style: AppWidget.lightTextFeildStyle(),),
               SizedBox(height: 30.0,),
                Text("Email",style: AppWidget.semiboldTextFeildStyle(),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(color: Color(0xfff4f5f9 ),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: mailcontroller,
    validator: (value){
    if(value==null|| value.isEmpty) {
    return 'Please Enter your Email';
    }
    return null;},
                    decoration: InputDecoration(border: InputBorder.none,hintText:"Email" ),
                    
                  ),
                ),
                SizedBox(height: 30.0,),
                Text("Password",style: AppWidget.semiboldTextFeildStyle(),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(color: Color(0xfff4f5f9 ),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordcontroller,
    validator: (value){
    if(value==null|| value.isEmpty) {
    return 'Please Enter your Password';
    }
    return null;},
                    decoration: InputDecoration(border: InputBorder.none,hintText:"Password" ),
                    
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password?",style: TextStyle(color: Colors.green,fontSize: 18.0,fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email=mailcontroller.text;
                        password=passwordcontroller.text;
                      });
                    }
                    userLogin();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20.0)),
                      child: Center(child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize:18.0,fontWeight:FontWeight.bold ),)),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                  Center(child: Text("Don't have an account? "  ,style: AppWidget.lightTextFeildStyle(),)),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      child: Text("Sign Up",style: TextStyle(color: Colors.green,fontSize: 18.0,fontWeight: FontWeight.w500),)),
                ],)
            ],
            ),
          ),
        ),
      ),
    );
  }
}
