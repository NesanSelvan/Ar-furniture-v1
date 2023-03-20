import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? model;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final val = await FirebaseFirestore.instance.collection('models').get();

      model = val.docs[0].data()["url"];
      print(model);
      for (var element in val.docs) {
        final dataInDB = element.data();
        print(dataInDB);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () => FirebaseCrashlytics.instance.crash(),
        child: const Text("Throw Test Exception"),
      ),
    );
  }
}
