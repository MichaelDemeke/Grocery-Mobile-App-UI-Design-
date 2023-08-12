import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery_mobile_app_ui_design/homepage.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  late TextEditingController controller;
  late TextEditingController controller1;

  late String phone;
  late String pass;
  late bool ok;
  late String token;

  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
    controller1 = TextEditingController();
  }

  @override
  void dispose(){
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/photo-1611080626919-7cf5a9dbab5b.jpg"), fit: BoxFit.fitHeight )
        ),
        child: Container(
              width:  MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height * 0.53, 
             margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38),
               decoration: const BoxDecoration(
                      color: Colors.white,
                                 borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )
                    ),
          child: Column(children: [
    
            const DefaultTextStyle(
              style: TextStyle(
                    fontSize: 24,
                     color: Colors.black,),
                                  textAlign: TextAlign.left,
                                  child: Text("Sign_in"),
                                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        setState(() {
                          phone = controller.text;
                        });
                      },
                    ),
                  ),
                ),
                  Container(
                    child: TextField(
                    controller: controller1,
                    onSubmitted: (value) {
                      setState(() {
                        pass = controller1.text;
                      });
                    },
                     ),
                  ),
                      Center(
                               child: GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: MediaQuery.of(context).size.height * 0.04,
                                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
                            decoration: const BoxDecoration(color: Colors.yellow,
                          borderRadius: BorderRadius.all (Radius.circular(24),
                        )
                            ),
                            child: const Center(
                              child: DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        //fontFamily: 'Dire_Dawa',
                                      ),
                                      textAlign: TextAlign.center,
                                      child: Text('Sign in'),
                                    ),
                            ),
                        
                          ),
                          onTap: () async {
                            sendrequest();
                            if(await sendrequest()){
                               Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                      homepage(token),
                                  )
                             );
                            }
                          },
                       )
                    )
          ]),
        ),
      ),
    );
  }
  Future<bool> sendrequest() async {
    try{
    var response =  await http.post(
        Uri.parse("https://stagingapi.chipchip.social/v1/users/login"),
        body: json.encode({
    "phone": controller.text,
    "password": controller1.text,
    "country": "ETH"}),
          // headers: {
          //     'Content-type' : 'application/json',
          //   },
      );
      var data = jsonDecode(response.body);
      ok= data['ok'];
  if(ok){
    token = data['data']['token'];
    return true;
  }
  else{
    _showMyDialog("Invalid Phone and Password");
    return false;
  }
    }
    catch (e){_showMyDialog("Unknown Error has occured plaease try again");

    print("Error ${e}");
    return false;
  }
  }

  Future<void> _showMyDialog( String x) async {
  String message = x;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ERROR'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
              Text('Press ok to try again'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}