import 'package:bikayi_project/screens/home_screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formGlobalKey = GlobalKey<FormState>();
  final name1 = TextEditingController();
  final name2 = TextEditingController();
  bool _isHidden = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bikayi_images/back.jpeg'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.5),
                ),
                Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.3),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Center(
                          child: const Text('Login or Signin\n',
                              style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                        )),
                    Form(
                        key: formGlobalKey,
                        child: Column(children: [
                          Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                  '\nEmail/Phone number\n',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white))),
                          TextFormField(
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              controller: name1,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(20),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                                  hintText: "Enter email or phone number"),
                              validator: (value) {
                                if (isEmailValid(value) ||
                                    isPhoneValid(value))
                                  return null;
                                return 'Enter valid email or phone number';
                              }),
                          const SizedBox(height: 5),
                          Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                  '\nName\n',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white))),
                          TextFormField(
                              style: TextStyle(color: Colors.white, fontSize: 18),
                              controller: name2,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(20),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                                  hintText: "Enter your name"),
                              validator: (value) {
                                if (value.isNotEmpty)
                                  return null;
                                return 'Name field is required';
                              }),

                          const SizedBox(height: 60),
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              color: Colors.white.withOpacity(0.8),
                              child: Text('Continue', style: TextStyle(fontSize: 20, color: Colors.black45, fontWeight: FontWeight.bold)),
                            ),
                            onTap: () {
                              if (formGlobalKey.currentState.validate()) {
                                formGlobalKey.currentState.save();
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => HomePage(name: name2.text)));
                              }
                            },
                          ),

                        ])),
                  ]
                )
              ),
            ])
          ),
        )
      ),
    );
  }
  bool isEmailValid(String email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(email)) ? false : true;
  }

  bool isPhoneValid(String num) {
    var pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(num)) ? false : true;
  }


}
