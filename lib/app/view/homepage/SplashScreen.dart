import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed( Duration(seconds: 5), () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(child: Scaffold(
      backgroundColor: Color(0xff2d3a4e),

      body: Center(child: Container(
        padding: EdgeInsets.all(10),
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:


          [Container(

            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage("assets/images/logo.png"),fit: BoxFit.cover)),
          ),
            SizedBox(height: 10,),
            Text("Wheather App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
          ],),
      ),),
    )
      ,));

  }
}