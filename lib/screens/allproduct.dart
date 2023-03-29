import 'package:arapp/screens/ar_design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProduct extends StatefulWidget {
  final void Function(String) url;

  const AllProduct({Key? key, required this.url}) : super(key: key);

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  final _auth = FirebaseAuth.instance;
  String? model;
  var _currentindex;
  var selectedindex;
  @override
  void initState() {
    super.initState();
    print("index$_currentindex");
    if (_currentindex != null) {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final val = await FirebaseFirestore.instance.collection('models').get();
        print(val.docs[_currentindex]);
        // model = val.docs[_currentindex].data()["url"];
        // print(model);
        // for (var element in val.docs) {
        //   final dataInDB = element.data();
        //   print(dataInDB);
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("models").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final userSnapshot = snapshot.data?.docs;
              if (userSnapshot!.isEmpty) {
                return const Text("no data");
              }
              var size = MediaQuery.of(context).size;
              double itemHeight = MediaQuery.of(context).size.height * 0.265;
              final double itemWidth = size.width / 2;
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 2),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: selectedindex == index
                                          ? Colors.teal
                                          : Colors.teal.withOpacity(0.2))),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          // width: MediaQuery.of(context).size.width *
                                          //     0.28,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Image.network(
                                              userSnapshot[index]["image"])),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height:
                                  //       MediaQuery.of(context).size.height * 0.5,
                                  // ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      // color: Colors.red,
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.42,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 18),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                userSnapshot[index]["name"],
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.teal,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.012,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 17,
                                                      ),
                                                      Text(
                                                        "4.9",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      // color: Colors.red,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18, right: 18),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "₹ ${userSnapshot[index]["rate"]}",
                                                // textAlign: TextAlign.right,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          // IconButton(
                                          //   onPressed: () {},
                                          //   icon: const Icon(Icons.favorite),
                                          //   color: Colors.red,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // leading: Image.network(productData["image"]),
                              // title: Text(productData["name"]),
                            ),
                          ),
                          onTap: () => {
                                setState(() {}),
                                selectedindex = index,
                                print("indexof${userSnapshot[index]["name"]}"),
                                ArDesign.url = userSnapshot[index]["url"],
                                print("link${ArDesign.url}"),
                                // widget.url =  userSnapshot[index]["url"]
                              });
                    },
                    separatorBuilder: ((context, index) {
                      return const Divider();
                    }),
                    itemCount: userSnapshot.length,
                  ));
            }),
      ),
    );
  }
}
