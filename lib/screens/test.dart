import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String filepath;
  const TestPage({Key? key, required this.filepath}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    final path = widget.filepath;
    print("file path $path");
    // TODO: implement initState
    super.initState();
  }

// ignore: prefer_typing_uninitialized_variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  // print();
                  Navigator.pushNamed(context, "ar_screen",
                      arguments: {"finalpath": widget.filepath});
                },
                child: const Text("data"))),
      ),
    );
  }
}
