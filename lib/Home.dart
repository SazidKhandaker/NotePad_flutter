import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'Nextpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var box = Hive.box("mybox");
  TextEditingController textEditingController = TextEditingController();
  Future<void> addData() async {
    int num = box.length + 1;
    if (textEditingController.text != '') {
      num++;
      setState(() {
        box.put(num, textEditingController.text);
      });
      textEditingController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Note Pad",
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: ((BuildContext context) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 98,
                    width: MediaQuery.of(context).size.width * 0.98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                              hintText: "Topic",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black87),
                              )),
                        ),
                      ),
                      TextButton(onPressed: addData, child: Text("click")),
                    ]),
                  ),
                );
              }));
        }),
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 3),
                            blurRadius: 5,
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)]),
                        BoxShadow(
                            offset: Offset(-3, -3),
                            blurRadius: 5,
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)]),
                      ],
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(112, 90, 62, 62),
                        Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                      ], begin: Alignment.bottomLeft, end: Alignment.center),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: ListTile(
                                title: Text(box.getAt(index)),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 100,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      box.deleteAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
