import 'package:expense_tracker/homepage.dart';
import 'package:flutter/material.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Column(
        children: <Widget>[
                Column(  
                  children: <Widget>[
                    Container(
                    padding: EdgeInsets.only(right: 100,),
                    margin: EdgeInsets.only(top:90),
                    child: Text("Welcome", 
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                  Container(
                  padding: EdgeInsets.only(right: 50,),
                 // margin: EdgeInsets.only(bottom: 100),
                  child: Text("Manage your money \n Track your expenses",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                  )
                ),
              ),
            ] 
          ),
            Container(
            margin: EdgeInsets.only(top: 50),
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/budget.png")
            ),
          ),
        ),
          Column(
            children: <Widget>[
              /* MaterialButton(
                minWidth: 350,
                height: 60,
                onPressed: (){},

                //defining the shape
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black),
                    borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    ),  
                ), */
              SizedBox(height:20),
              MaterialButton(minWidth: 300,
                height: 60,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    ),  
                  ),
                 ],
               ),
             ],
          ),
         ),
       );
    }
}