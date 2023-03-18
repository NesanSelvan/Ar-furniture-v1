import "dart:developer";
import "dart:io";

import "package:babylonjs_viewer/babylonjs_viewer.dart";
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:path_provider/path_provider.dart";

class ProductScreen extends StatefulWidget {
  final String url;
  final String productname;
  final String productrate;
  final String description;
  const ProductScreen(
      {Key? key,
      required this.url,
      required this.productname,
      required this.productrate,
      required this.description})
      : super(key: key);
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isLoading = true;
  String filePath = "";
  bool isfav = false;
  bool canScroll = true;
  Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '$dir/$fileName';
    String myUrl = '';

    if (await File(filePath).exists()) {
      return filePath;
    }

    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else {
        filePath = 'Error code: ${response.statusCode}';
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  performInit() async {
    print(widget.url);
    final path = await getTemporaryDirectory();
    filePath = await downloadFile(
      widget.url,
      widget.url.split("/").last,
      path.path,
    );
    log(filePath);
    final length = await File(filePath).length();
    log("File Length: $length");

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    performInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GestureDetector(
        onTapDown: (v) {
          log("Pan Gesture ${v.globalPosition}");
          if (v.globalPosition.dy > 440) {
            canScroll = true;
          } else {
            canScroll = false;
          }
          setState(() {});
        },
        child: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          physics: canScroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                // Text(canScroll.toString()),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                      // color: Colors.re,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: isLoading && filePath == ""
                        ? const CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              canScroll = false;
                              setState(() {});
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: Colors.re,
                                    border: Border.all(
                                        color: Colors.teal.withOpacity(0.2),
                                        width: 2)),
                                child: BabylonJSViewer(
                                  src: 'file://$filePath',
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              widget.productname.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 37,
                                  fontWeight: FontWeight.bold,
                                  textStyle: const TextStyle(
                                      letterSpacing: 0.2, color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 18)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: const BorderSide(color: Colors.teal)))),
                              onPressed: () {
                                Navigator.pushNamed(context, "testpage",
                                    arguments: {"filepath": widget.url});
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.view_in_ar),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("AR"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.039,
                          ),
                          Text(
                            "₹ ${widget.productrate}",
                            style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                textStyle: const TextStyle(
                                    letterSpacing: 0.2, color: Colors.teal)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.034,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Text(
                            "Description",
                            style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                textStyle: const TextStyle(
                                    letterSpacing: 0.2, color: Colors.black)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Text(
                            widget.description,
                            style: GoogleFonts.asap(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                wordSpacing: 1,
                                textStyle:
                                    const TextStyle(color: Colors.black)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          height: 85,
          // color: Colors.transparent,
          // elevation: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // GestureDetector(
                //   onTap: () {},
                //   child: Container(
                //       height: MediaQuery.of(context).size.height * 0.07,
                //       width: MediaQuery.of(context).size.width * 0.35,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(25),
                //         color: Colors.teal,
                //       ),
                //       child: const Center(child: Text("data"))),
                // )
                SizedBox(
                  height: 100,
                  width: 180,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.teal)))),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Container(
                            decoration:
                                BoxDecoration(color: Colors.amber.shade800),
                            child: Text(
                              "Successfully added to cart",
                              style: GoogleFonts.cantoraOne(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.amber.shade800,
                        ));
                      },
                      child: Row(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.shopify,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add To Cart",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                textStyle: const TextStyle(
                                    fontSize: 20, letterSpacing: 0.2)),
                          )
                        ],
                      )),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      // if (isfav = false) {
                      isfav = true;
                      // }
                      // else if (isfav = true) {
                      //   isfav = false;
                      // }
                    });
                  },
                  icon: Icon(
                    isfav ? Icons.favorite : Icons.favorite_border,
                    size: 35,
                  ),
                  color: isfav ? Colors.red : Colors.grey.shade600,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
