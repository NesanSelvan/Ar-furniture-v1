import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
        backgroundColor: Colors.teal.shade50,
        elevation: 0.5,
      ),
      backgroundColor: Colors.teal.shade50,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "our team".toUpperCase(),
                  // overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/homear-4ccea.appspot.com/o/IMG-20230403-WA0016.jpg?alt=media&token=5482e120-7e53-4f67-9b95-82ea1f4317b6'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(
                      color: Colors.teal,
                      width: 4.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "members".toUpperCase(),
                  // overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    width: 110.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/homear-4ccea.appspot.com/o/Screenshot%202023-04-16%20011207.png?alt=media&token=a302e126-6e80-419e-a2c4-1dab8f7a0021"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(75.0)),
                      border: Border.all(
                        color: Colors.teal,
                        width: 4.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "nesan selvan".toUpperCase(),
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                  letterSpacing: 0.2, color: Colors.teal)),
                        ),
                        Text(
                          "Developer",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              textStyle: TextStyle(
                                  letterSpacing: 0.2,
                                  color: Colors.grey.shade600)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    width: 110.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/homear-4ccea.appspot.com/o/IMG-20230120-WA0006.jpg?alt=media&token=fdeb90dc-cd02-4dee-8316-e229b70ec313'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(75.0)),
                      border: Border.all(
                        color: Colors.teal,
                        width: 4.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vishal Mamluskar".toUpperCase(),
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                  letterSpacing: 0.2, color: Colors.teal)),
                        ),
                        Text(
                          "Developer",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              textStyle: TextStyle(
                                  letterSpacing: 0.2,
                                  color: Colors.grey.shade600)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/homear-4ccea.appspot.com/o/IMG-20230120-WA0005.jpg?alt=media&token=cc32138b-a177-4bf3-84bc-89497c4ff168'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(75.0)),
                      border: Border.all(
                        color: Colors.teal,
                        width: 4.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Akash sawant".toUpperCase(),
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                  letterSpacing: 0.2, color: Colors.teal)),
                        ),
                        Text(
                          "Hacker",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              textStyle: TextStyle(
                                  letterSpacing: 0.2,
                                  color: Colors.grey.shade600)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/homear-4ccea.appspot.com/o/IMG-20230403-WA0016%20(2).jpg?alt=media&token=6e21a4db-5075-48c3-9c61-085d253e785e'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(75.0)),
                      border: Border.all(
                        color: Colors.teal,
                        width: 4.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "allen lopes".toUpperCase(),
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                  letterSpacing: 0.2, color: Colors.teal)),
                        ),
                        Text(
                          "Developer",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              textStyle: TextStyle(
                                  letterSpacing: 0.2,
                                  color: Colors.grey.shade600)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
