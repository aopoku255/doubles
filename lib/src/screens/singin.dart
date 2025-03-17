import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/main_text.dart';
import '../widgets/text_field_input.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(leading: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 10),
        child: InkWell(onTap: (){
          Navigator.pop(context);
        }, child: MainText(text: "Cancel", color: Colors.black,)),
      ), title: MainText(text: "Sign in", color: Colors.black), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(text: "ENTER YOUR EMAIL ADDRESS", color: Colors.black,),
              Form(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    TextFieldInput(label: "Email", hintText: "user@gmail.com",),
                    SizedBox(height: 20,),
                    TextFieldInput(label: "Password"),
                    SizedBox(height: 20,),
                    Button(text: "Sign in", onTap: (){
                      Navigator.pushNamed(context, "/signin");
                    }),
                    TextButton(onPressed: (){}, child: MainText(text: "Forgot password?", color: Colors.blue, textAlign: TextAlign.start,)),
                    SizedBox(height: 40,),
                    MainText(text: "OTHER SIGN IN METHODS", color: Colors.black,),
                    SizedBox(height: 10,),
                    Button(text: "Continue with Google", withIcon: true, color: Colors.white, iconImage: "assets/images/google.png",),
                    SizedBox(height: 10,),
                    Button(text: "Continue with Facebook", withIcon: true, color: Colors.white, iconImage: "assets/images/facebook.png",),
                    SizedBox(height: 10,),
                    Button(text: "Continue with X", withIcon: true, color: Colors.white, iconImage: "assets/images/twitter.png",),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
