// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:profile3/SignInPage.dart';
import 'package:profile3/database_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _firstnamecontroller = TextEditingController();

  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String _value = "Male";
  String dropdownvalue = "0";

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Registeration"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 100),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernamecontroller,
                    decoration: const InputDecoration(
                        hintText: "Username", icon: Icon(Icons.person_pin)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _firstnamecontroller,
                    decoration: const InputDecoration(
                        hintText: "First Name", icon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _lastnamecontroller,
                    decoration: const InputDecoration(
                        hintText: "Last Name",
                        icon: Icon(Icons.person_rounded)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Radio(
                          value: "Male",
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                            });
                          },
                        ),
                        title: const Text("Male"),
                      ),
                      ListTile(
                        leading: Radio(
                          value: "Female",
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                            });
                          },
                        ),
                        title: const Text("Female"),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 20, 10),
                    child: Row(
                      children: [
                        const Text("Date of Birth :-    "),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          // color: Colors.blue, // Refer step 3
                          child: const Text(
                            'Select date',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 20, 10),
                  child: Row(
                    children: <Widget>[
                      const Text("Experience  :-    "),
                      DropdownButton<String>(
                          value: dropdownvalue,
                          onChanged: (newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                          items: <String>[
                            "0",
                            "1",
                            "2",
                            "3",
                            "4",
                            "5",
                            "6",
                            "7",
                            "8",
                            "9",
                            "10"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList())
                    ],
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
                ElevatedButton(
                  onPressed: verifyusername,
                  // color: Colors.blue,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  insertData() async {
    print(dropdownvalue);
    print(_value);
    print(_usernamecontroller.text);
    print(_firstnamecontroller.text);
    print(_lastnamecontroller.text);
    print(selectedDate);
    print(_passwordcontroller.text);

    String datadate = selectedDate.toString();

    var dateTime = DateTime.parse(datadate);

    var dateString = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

    await DatabaseHelper.instance.insert({
      DatabaseHelper.columnUsername: _usernamecontroller.text,
      DatabaseHelper.columnfirstName: _firstnamecontroller.text,
      DatabaseHelper.columnlastName: _lastnamecontroller.text,
      DatabaseHelper.columngender: _value,
      DatabaseHelper.columndob: dateString,
      DatabaseHelper.columnexperience: dropdownvalue,
      DatabaseHelper.columnpassword: _passwordcontroller.text,
    });
  }
// verifying usernmae, to make it unique

  verifyusername() async {
    List<Map<String, dynamic>> verifyusernames =
        await DatabaseHelper.instance.queryAll();
    print(verifyusernames);
    bool boolean = false;
    for (var element in verifyusernames) {
      print(element);
      if (element["_username"] == _usernamecontroller.text) {
        boolean = true;
      }
    }

    if (boolean == true) {
      _usernamecontroller.clear();
      _firstnamecontroller.clear();
      _lastnamecontroller.clear();
      _passwordcontroller.clear();
      _value = "Male";
      dropdownvalue = "0";
      selectedDate = DateTime.now();

      //Toast to aware user about the username already exist

      Fluttertoast.showToast(
          msg: "Username Already Exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      insertData();

      _usernamecontroller.clear();
      _firstnamecontroller.clear();
      _lastnamecontroller.clear();
      _passwordcontroller.clear();
      _value = "Male";
      dropdownvalue = "0";
      selectedDate = DateTime.now();

      Fluttertoast.showToast(
          msg: "Registeration Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
      });
    }
  }
}
