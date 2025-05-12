import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfinal2/finalpage.dart';
import 'package:testfinal2/homepage.dart';
import 'package:testfinal2/sqldb.dart';
import 'package:testfinal2/users.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final numbercontroler = TextEditingController();
  final codecontroler = TextEditingController();

  login() async {
    var user = await SqlDb.instance.loginUser(numbercontroler.text, codecontroler.text);
    if (user != null) {
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalPage(usr: user)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("خطأ كلمة المرور او الكود"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        backgroundColor: Colors.teal,  // تغيير اللون
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // تغيير اللون الخلفية
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: numbercontroler,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Number",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: codecontroler,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Code",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // تغيير اللون
                      fixedSize: Size(150, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Login"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // تغيير اللون
                      fixedSize: Size(150, 60),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Home"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
