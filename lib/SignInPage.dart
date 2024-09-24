import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:profile3/HomePage.dart';
import 'package:profile3/SignUpPage.dart';
import 'package:profile3/database_helper.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(
              16, MediaQuery.of(context).size.height * .24, 16, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _usernamecontroller,
                  decoration: const InputDecoration(
                      hintText: "Username", icon: Icon(Icons.phone)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  obscureText: true,
                  controller: _passwordcontroller,
                  decoration: const InputDecoration(
                      hintText: "Password", icon: Icon(Icons.lock)),
                ),
              ),
              Center(
                  child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: ButtonTheme(
                  minWidth: 250,
                  height: 40,
                  child: ElevatedButton(
                    // elevation: 2,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(18.0),
                    //     side: const BorderSide(color: Colors.blue)),
                    // color: Colors.white,
                    onPressed: loginAuthentication,
                    // textColor: Colors.blue,
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: ButtonTheme(
                          minWidth: 250,
                          height: 40,
                          child: ElevatedButton(
                            // elevation: 2,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(18.0),
                            //     side: const BorderSide(color: Colors.blue)),
                            // color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const SignUpPage()));
                            },
                            // textColor: Colors.blue,
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  loginAuthentication() async {
    List<Map<String, dynamic>> verifyusernamepassword =
        await DatabaseHelper.instance.queryAll();
    bool boolean = false;
    for (var element in verifyusernamepassword) {
      if (element["_username"] == _usernamecontroller.text &&
          element["_password"] == _passwordcontroller.text) {
        boolean = true;
      }
    }

    if (boolean == true) {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()));
    } else {
      Fluttertoast.showToast(
          msg: "Username or Password is wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
