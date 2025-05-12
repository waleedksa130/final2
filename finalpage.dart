import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfinal2/homepage.dart';
import 'package:testfinal2/users.dart';
import 'package:testfinal2/sqldb.dart';

class FinalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FinalPage();
  Users usr;
  FinalPage({super.key, required this.usr});
}

class _FinalPage extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        backgroundColor: Colors.teal, // اللون متناسق مع باقي الصفحات
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // نفس اللون المستخدم في باقي الصفحات
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("Number"),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("${widget.usr.number}"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("Code"),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("${widget.usr.code}"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 60),
                          backgroundColor: Colors.teal, // نفس اللون
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("All Data"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 60),
                          backgroundColor: Colors.red, // نفس اللون
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black12,
                child: FutureBuilder<List<Users>>(
                  future: SqlDb.instance.getAllUsers(),
                  builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Records Found'));
                      } else {
                        List<Users> users = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              Users s = users[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(s.id.toString()),
                                            const Spacer(),
                                            Text(s.number),
                                            const Spacer(),
                                            Text(s.code),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
