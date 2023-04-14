import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyDialogBox extends StatefulWidget {
  static String name = "";
  static int rate = 0;
  const BuyDialogBox({super.key});

  @override
  State<StatefulWidget> createState() => BuyDialogBoxState();
}

class BuyDialogBoxState extends State<BuyDialogBox>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 225,
            width: 300,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  // Text(
                  //   BuyDialogBox.name.toUpperCase(),
                  //   style: GoogleFonts.poppins(
                  //       fontSize: 23,
                  //       color: Colors.teal,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  const Spacer(),
                  Text(
                    "Total Price",
                    style: GoogleFonts.poppins(
                        fontSize: 19,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹${BuyDialogBox.rate * quantity}",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Quantity",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 38,
                        width: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            // side: BorderSide(color: Colors.yellow, width: 5),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontStyle: FontStyle.normal),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                          ),
                          onPressed: () {
                            setState(() {
                              if (quantity <= 0) {
                                quantity = 0;
                              } else {
                                quantity--;
                              }
                            });
                          },
                          child: const Icon(
                            Icons.remove,
                            size: 19,
                          ),
                        ),
                      ),
                      Text(
                        quantity.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 38,
                        width: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            // side: BorderSide(color: Colors.yellow, width: 5),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontStyle: FontStyle.normal),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                          ),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          child: const Icon(
                            Icons.add,
                            size: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 38,
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              // side: BorderSide(color: Colors.yellow, width: 5),
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal),
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.teal, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13))),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  letterSpacing: 1.5,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      SizedBox(
                          height: 38,
                          width: 110,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              // side: BorderSide(color: Colors.yellow, width: 5),
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal),
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.teal, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13))),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Confirm",
                              style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  letterSpacing: 1.5,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
