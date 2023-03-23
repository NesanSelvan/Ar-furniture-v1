import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

List<String> allFav = [];

class _FavouritesScreenState extends State<FavouritesScreen> {
  Future<Object> showdata({required String email}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");
      try {
        final allData =
            ((await users.doc(email).get()).data() as Map<String, dynamic>);
        allFav = (allData['favourites'] as List).cast<String>();
        // log("allData:  $allFav");
      } catch (e) {
        // log("allData Error: $e");
      }

      // await users.doc(email).update({
      //   "favourites": allFav.contains(docid) ? allFav : [...allFav, docid]
      // });
      return allFav;
    } catch (e) {
      return "error loading user";
    }
  }

  void favlist() {
    for (int i = 0; i < allFav.length; i++) {
      print(allFav[i]);
    }
  }

  var email;
  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    dynamic user = auth.currentUser;
    email = user.email;
    showdata(email: email);
    // log("fav list$allFav");
    favlist();
    setState(() {});
    super.initState();
  }

  List<String> val = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream:
          FirebaseFirestore.instance.collection("users").doc(email).snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) return const Text("Loading...");
        final allFav = (snapshot.data?.data()?["favourites"] as List?) ?? [];
        return ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("models")
                    .doc("${allFav[index]}")
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  final productData = snapshot.data?.data();
                  if (productData != null) {
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
                                  color: Colors.teal.withOpacity(0.2))),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.28,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child:
                                          Image.network(productData["image"])),
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
                                            productData["name"],
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold),
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
                                                MainAxisAlignment.spaceBetween,
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
                                  height: MediaQuery.of(context).size.height,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18, right: 18),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "₹ ${productData["rate"]}",
                                            // textAlign: TextAlign.right,
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.favorite),
                                        color: Colors.red,
                                      )
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
                      onTap: () => Navigator.pushNamed(
                          context, "product_screen",
                          arguments: {
                            "url": productData['url'],
                            "productname": productData["name"],
                            "productrate": productData["rate"],
                            "description": productData["description"],
                            "docid": allFav[index]
                          }),
                    );
                  } else {
                    return const Text("No Such Product");
                  }
                });
          },
          separatorBuilder: ((context, index) {
            return const Divider();
          }),
          itemCount: allFav.length,
        );
        // return Center(
        //   child: Container(
        //     color: Colors.red,
        //     height: MediaQuery.of(context).size.height,
        //     width: MediaQuery.of(context).size.width,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: const <Widget>[
        //         // ListView.builder(
        //         //   itemCount: 1,
        //         //   itemBuilder: (BuildContext context, int index) {
        //         //     return Column(
        //         //       children: const [
        //         //         Expanded(
        //         //           child: Text("data"),
        //         //         ),
        //         //       ],
        //         //     );
        //         //   },
        //         // ),
        //         // Expanded(
        //         //   child: ListView.builder(
        //         //     shrinkWrap: true,
        //         //     itemCount: snapshot.data["favourites"].length,
        //         //     itemBuilder: (BuildContext context, int index) {
        //         //       return Card(
        //         //           child: ListTile(
        //         //               title: Text(snapshot.data["favourites"]),
        //         //               onTap: () {
        //         //                 print("hello");
        //         //               }));
        //         //     },
        //         //   ),
        //         // ),
        //       ],
        //     ),
        //   ),
        // );

        // return Center(
        //   child: SizedBox(
        //     // color: Colors.,
        //     height: MediaQuery.of(context).size.height,
        //     width: MediaQuery.of(context).size.width,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           snapshot.data["favourites"].toString(),
        //           style: const TextStyle(fontSize: 25),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
