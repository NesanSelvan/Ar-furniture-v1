import 'package:arapp/screens/searchpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  static bool isseemore = false;
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
      final val = FirebaseFirestore.instance
          .collection('models')
          .where("type", isEqualTo: "chair")
          .snapshots();

      print(val.length);
    });
  }

  var list = [
    "chair",
    "armchair",
    "sofa",
    "table",
    "cabinet",
    "bed",
    "coffin",
    "electronics"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          for (int i = 0; i <= 7; i++)
            EachCategory(
              type: list[i],
            )
        ]),
      ),
    );
  }
}

class EachCategory extends StatefulWidget {
  String type = "";
  EachCategory({Key? key, required this.type}) : super(key: key);

  @override
  State<EachCategory> createState() => _EachCategoryState();
}

class _EachCategoryState extends State<EachCategory> {
  late int productlen;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("models")
                  .where("type", isEqualTo: widget.type)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final userSnapshot = snapshot.data?.docs;
                if (userSnapshot!.isEmpty) {
                  return const Text("no data");
                }

                var size = MediaQuery.of(context).size;
                double itemHeight = 150;
                final double itemWidth = size.width / 0.2;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        // color: Colors.red,
                        height: size.height * 0.32,
                        // width: 350,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(widget.type.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 19,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryTypeScreen(
                                                      type: widget.type)));
                                    });
                                    print("type${widget.type}");
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "See More",
                                        style: GoogleFonts.poppins(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 15,
                                        color: Colors.teal,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: userSnapshot.length < 3
                                    ? userSnapshot.length
                                    : 3,
                                // controller: ScrollController,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      var currentindex = index;
                                      print(
                                          "network image ${userSnapshot[index]["image"]}");
                                      print(
                                          "index ${userSnapshot[index].data()}");
                                      final data = userSnapshot[index].data();
                                      final dataid = userSnapshot[index].id;
                                      if (data is Map<String, dynamic>) {
                                        if (data.containsKey('url')) {
                                          await Navigator.pushNamed(
                                              context, "product_screen",
                                              arguments: {
                                                "url": data['url'],
                                                "productname": data["name"],
                                                "productrate": data["rate"],
                                                "description":
                                                    data["description"],
                                                "docid": dataid
                                              });
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      child: Container(
                                        // height: MediaQuery.of(context).size.height * 0.09,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          // color: Colors.yellow,
                                          border: Border.all(
                                              color:
                                                  Colors.teal.withOpacity(0.3)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          // image: DecorationImage(
                                          //   image:
                                          //       NetworkImage(userSnapshot[index]["image"]),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRect(
                                              child: Container(
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.grey.shade100,
                                                  // border: Border.all(
                                                  // color: Colors.teal.withOpacity(0.3)
                                                  // ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          userSnapshot[index]
                                                              ["image"]),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // height: 72,
                                              decoration: const BoxDecoration(
                                                  // color: Colors.red,
                                                  shape: BoxShape.rectangle,
                                                  // border: Border.all(
                                                  // color: Colors.teal.withOpacity(0.3),
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15))),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.event_seat,
                                                              size: 15,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "Furniture",
                                                              style: GoogleFonts.sourceSansPro(
                                                                  textStyle: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .grey)),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 6),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        userSnapshot[index]
                                                            ["name"],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 19,
                                                                color:
                                                                    Colors.teal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: const [
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                size: 17,
                                                              ),
                                                              Text(
                                                                "4.9",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            "₹ ${userSnapshot[index]["rate"]}",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                textStyle: const TextStyle(
                                                                    letterSpacing:
                                                                        0.2,
                                                                    color: Colors
                                                                        .teal)),
                                                          ),
                                                        ]),
                                                  ),
                                                  // const SizedBox(
                                                  //   height: 20,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class CategoryTypeScreen extends StatefulWidget {
  String type = "";
  CategoryTypeScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<CategoryTypeScreen> createState() => _CategoryTypeScreenState();
}

class _CategoryTypeScreenState extends State<CategoryTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.teal),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              });
              // showSearch(context: context,delegate: SearchPage(builder: , filter: , items: ))
            },
            icon: const Icon(Icons.search, color: Colors.teal, size: 25),
          ),
          // const SizedBox(
          //   width: 20,
          // )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/${widget.type}.png",
                        scale: 5,
                        color: Colors.teal,
                      ),
                    ),
                    Text(widget.type.toUpperCase(),
                        style: GoogleFonts.poppins(
                            fontSize: 19,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("models")
                      .where("type", isEqualTo: widget.type)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final userSnapshot = snapshot.data?.docs;
                    if (userSnapshot!.isEmpty) {
                      return const Text("no data");
                    }
                    var size = MediaQuery.of(context).size;
                    double itemHeight = 240;
                    final double itemWidth = size.width / 2;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: (itemWidth / itemHeight),
                        ),
                        itemCount: userSnapshot.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              var currentindex = index;
                              print(
                                  "network image ${userSnapshot[index]["image"]}");
                              print("index ${userSnapshot[index].data()}");
                              final data = userSnapshot[index].data();
                              final dataid = userSnapshot[index].id;
                              if (data is Map<String, dynamic>) {
                                if (data.containsKey('url')) {
                                  await Navigator.pushNamed(
                                      context, "product_screen",
                                      arguments: {
                                        "url": data['url'],
                                        "productname": data["name"],
                                        "productrate": data["rate"],
                                        "description": data["description"],
                                        "docid": dataid
                                      });
                                }
                              }
                              // ar_screen
                              // _currentindex = index;
                              // print("index ${userSnapshot[index].data()}");
                              // final data = userSnapshot[index].data();
                              // if (data is Map<String, dynamic>) {
                              //   if (data.containsKey('url')) {
                              //     Navigator.pushNamed(
                              //       context, "ar_screen",
                              //       // arguments: {
                              //       //   "url": data['url'],
                              //       // }
                              //     );
                              //   }
                              // }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Container(
                                // height: 900,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  // color: Colors.yellow,
                                  border: Border.all(
                                      color: Colors.teal.withOpacity(0.3)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  // image: DecorationImage(
                                  //   image:
                                  //       NetworkImage(userSnapshot[index]["image"]),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                child: Column(
                                  children: [
                                    ClipRect(
                                      child: Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.grey.shade100,
                                          // border: Border.all(
                                          // color: Colors.teal.withOpacity(0.3)
                                          // ),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  userSnapshot[index]["image"]),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // height: 72,
                                      decoration: const BoxDecoration(
                                          // color: Colors.red,
                                          shape: BoxShape.rectangle,
                                          // border: Border.all(
                                          // color: Colors.teal.withOpacity(0.3),
                                          // ),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15))),
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.event_seat,
                                                      size: 15,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Furniture",
                                                      style: GoogleFonts.sourceSansPro(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                userSnapshot[index]["name"],
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 19,
                                                    color: Colors.teal,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
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
                                                  Text(
                                                    "₹ ${userSnapshot[index]["rate"]}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textStyle:
                                                            const TextStyle(
                                                                letterSpacing:
                                                                    0.2,
                                                                color: Colors
                                                                    .teal)),
                                                  ),
                                                ]),
                                          ),
                                          // const SizedBox(
                                          //   height: 20,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                        // itemCount: userSnapshot.length,
                        // // itemBuilder: (context, index) {
                        // children: [
                        //   Container(
                        //     margin: EdgeInsets.only(bottom: 15),
                        //     decoration: BoxDecoration(
                        //         color: Colors.deepPurple.shade400,
                        //         borderRadius: BorderRadius.circular(24)),
                        //     //title: Text(userSnapshot[index]["url"].toString()),
                        //     width: MediaQuery.of(context).size.width * 1,
                        //     height: MediaQuery.of(context).size.height * 0.15,
                        //     child: Center(child: Text(userSnapshot[0]["name"])),
                        //   ),
                        // ]
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
