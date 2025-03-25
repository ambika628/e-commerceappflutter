import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Admin/add_product.dart';
import 'package:flutter_project/Admin/admin_login.dart';
import 'package:flutter_project/Admin/all_orders.dart';
import 'package:flutter_project/Admin/home_admin.dart';
import 'package:flutter_project/pages/bottomnav.dart';
import 'package:flutter_project/pages/home.dart';
import 'package:flutter_project/pages/login.dart';
import 'package:flutter_project/pages/onboarding.dart';
import 'package:flutter_project/pages/product_detail.dart';
import 'package:flutter_project/pages/profile.dart';
import 'package:flutter_project/pages/signup.dart';
import 'package:flutter_project/services/constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=publishablekey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeAdmin(),
    );
  }
}
