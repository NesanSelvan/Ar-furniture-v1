import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("models")
              .where("type", isEqualTo: "armchair")
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      print("network image ${userSnapshot[index]["image"]}");
                      print("index ${userSnapshot[index].data()}");
                      final data = userSnapshot[index].data();
                      final dataid = userSnapshot[index].id;
                      if (data is Map<String, dynamic>) {
                        if (data.containsKey('url')) {
                          await Navigator.pushNamed(context, "product_screen",
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
                          border:
                              Border.all(color: Colors.teal.withOpacity(0.3)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
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
                                      padding: const EdgeInsets.symmetric(
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
                                                  textStyle: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey)),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
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
                                          Text(
                                            "₹ ${userSnapshot[index]["rate"]}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                textStyle: const TextStyle(
                                                    letterSpacing: 0.2,
                                                    color: Colors.teal)),
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
    );
  }
}
