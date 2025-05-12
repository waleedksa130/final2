import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfinal2/homepage.dart';
import 'package:testfinal2/sqldb.dart';
import 'package:testfinal2/update.dart';
import 'package:testfinal2/users.dart';

class ControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ControlPage();
}

class _ControlPage extends State<ControlPage> {
  final numbercontrol = TextEditingController();
  final codecontrol = TextEditingController();

  insertUser() async {
    if (numbercontrol.text.isNotEmpty && codecontrol.text.isNotEmpty) {
      final db = await SqlDb.instance.intialDb();
      final result = await db.query(
        'users',
        where: 'number = ? AND code = ?',
        whereArgs: [numbercontrol.text, codecontrol.text],
      );

      if (result.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("المستخدم موجود مسبقًا"),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.fixed,
        ));
        return;
      }

      var response = await SqlDb.instance.createUser(
        Users(number: numbercontrol.text, code: codecontrol.text),
      );

      if (response > 0) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("فشل في إضافة المستخدم"),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.fixed,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("الرجاء تعبئة جميع الحقول"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
      ));
    }
  }

  update() async {
    var user = await SqlDb.instance.loginUser(numbercontrol.text, codecontrol.text);
    if (user != null) {
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(user: user)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("خطأ كلمة المرور او الكود"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
      ));
    }
  }

  delete() async {
    var user = await SqlDb.instance.loginUser(numbercontrol.text, codecontrol.text);
    if (user != null) {
      if (!mounted) return;
      await SqlDb.instance.deleteUser(user);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
        title: Text("Control Page"),
        backgroundColor: Colors.teal,  // نفس اللون
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],  // نفس اللون الخلفية
        ),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(16),
          childAspectRatio: 1,
          shrinkWrap: true,
          children: <Widget>[
            TextField(
              controller: numbercontrol,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Number",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            TextField(
              controller: codecontrol,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Code",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            ElevatedButton(
              onPressed: insertUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,  // نفس اللون
                fixedSize: Size(150, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Create"),
            ),
            ElevatedButton(
              onPressed: delete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,  // نفس اللون
                fixedSize: Size(150, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Delete"),
            ),
            ElevatedButton(
              onPressed: update,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,  // نفس اللون
                fixedSize: Size(150, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Update"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,  // نفس اللون
                fixedSize: Size(150, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
