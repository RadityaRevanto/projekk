import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projekk/login/reusable_widgets/reusable_widget.dart';
import 'package:projekk/login/screen/home_screen.dart';
import 'package:projekk/login/screen/signup_screen.dart';
import 'package:projekk/login/utils/color_utils.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextContoller = TextEditingController();
  TextEditingController _emailTextContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Mengatur Color Background
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("8BADE1"),
              hexStringToColor("2B77BD"),
              hexStringToColor("5E61F4"),
            ], begin: Alignment.topCenter,end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2,20 , 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo helm.png"),
                SizedBox(height: 30,),
                reusableTextField("Enter Username", Icons.person_outline, false, _emailTextContoller),
                SizedBox(height: 20,),
                reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextContoller),
                SizedBox(height: 20,),
                signInSignUpButton(context, true, (){
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextContoller.text, password: _passwordTextContoller.text)
                      .then((value) {
                    print("object");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),);
  }
  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(" Sign Up",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}