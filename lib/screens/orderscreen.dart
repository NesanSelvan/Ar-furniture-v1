import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatefulWidget {
  String total;
  String quantity;
  OrderScreen({Key? key, required this.total, required this.quantity})
      : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? gender; //no radio button will be selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        iconTheme: const IconThemeData(color: Colors.teal),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            "Checkout",
            style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 17),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Address",
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("Change",
                            style: GoogleFonts.poppins(
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Room 201,Sarvodaya Chawl,Khambadevi Road,Dharavi,Mumbai - 400017",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.2,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phone Number",
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text("Change",
                              style: GoogleFonts.poppins(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)))
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "9769426625",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.2,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Options",
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text(
                        "Free Delivery",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 16),
                      ),
                      subtitle: const Text("Delivery on Monday"),
                      value: "Free",
                      activeColor: Colors.teal,
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "₹ 100",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 16),
                      ),
                      activeColor: Colors.teal,
                      value: "₹ 100",
                      groupValue: gender,
                      subtitle: const Text("Delivered before Thursday"),
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method",
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text("Change",
                              style: GoogleFonts.poppins(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)))
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.credit_card,
                          color: Colors.teal,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "HDFC Bank Credit Card",
                          style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            "48** **** **** **85",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text("₹${widget.total}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping",
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Text("Free",
                            style: GoogleFonts.poppins(
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Text("₹${widget.total}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70),
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
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(color: Colors.teal)))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Place Your Order",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                textStyle: const TextStyle(
                                    fontSize: 20, letterSpacing: 0.2)),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
