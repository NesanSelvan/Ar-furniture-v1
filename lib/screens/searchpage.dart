import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchname;
  TextEditingController searctext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          // leading: ,
          elevation: 0,
          // shadowColor: Colors.teal,
          leading: const BackButton(
            color: Colors.teal,
          ),

          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchname = value;
                  });
                },
                controller: searctext,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.teal,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.teal,
                      ),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('models').snapshots(),
        builder: (context, snapshot) {
          final userSnapshot = snapshot.data?.docs;

          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: userSnapshot!.length,
                  itemBuilder: (context, index) {
                    var data =
                        userSnapshot[index].data() as Map<String, dynamic>;
                    if (data["name"]
                        .toString()
                        .toLowerCase()
                        .startsWith(searchname.toString().toLowerCase())) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "product_screen",
                                arguments: {
                                  "url": data['url'],
                                  "productname": data["name"],
                                  "productrate": data["rate"],
                                  "description": data["description"],
                                  "docid": data[index]
                                });
                          },
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.grey.shade200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(10)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Image.network(data["image"]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    data["name"],
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (searchname.toString().isEmpty) {
                      const Text("null");
                    }
                    return Container();
                  },
                );
        },
      ),
    );
  }
}
