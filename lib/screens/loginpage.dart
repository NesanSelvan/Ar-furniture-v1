import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const kTextFieldDecoration = InputDecoration(
//     hintText: 'Enter a value',
//     hintStyle: TextStyle(color: Colors.grey),
//     contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(32.0)),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//       borderRadius: BorderRadius.all(Radius.circular(32.0)),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//       borderRadius: BorderRadius.all(Radius.circular(32.0)),
//     ));

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.red[50],
                    child: const CustomPaint(
                        //painter: CurvedPainter(),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Hey,",
                          style: GoogleFonts.nunitoSans(
                              textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            letterSpacing: 1.9,
                          ))),
                      Text("Login Now",
                          style: GoogleFonts.nunitoSans(
                              textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            letterSpacing: 1.9,
                          ))),
                      const SizedBox(
                        height: 0.02,
                      ),
                      Row(
                        children: [
                          Text(
                            "If you're new /",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5)),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, "registration_screen");
                              },
                              child: Text(
                                "Create New",
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        color: Colors.teal,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800)),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                            //Do something with the user input.
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hoverColor: Colors.teal,
                            fillColor: Colors.black12,
                            filled: true,

                            // enabledBorder: OutlineInputBorder(
                            //     borderSide: BorderSide(
                            //       color: Colors.grey,
                            //       width: 2.0,
                            //     ),
                            //     borderRadius: BorderRadius.circular(9)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(9)),
                            hintText: 'Email',
                            alignLabelWithHint: true,
                            label: const Icon(
                              Icons.mail,
                              color: Colors.teal,
                            ),
                            // labelText: "Email"
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                            //Do something with the user input.
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.black12, filled: true,
                            hoverColor: Colors.teal,
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: Colors.grey,
                            //     width: 2.0,
                            //   ),
                            //   borderRadius: BorderRadius.circular(9),
                            // ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.teal,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(9)),
                            label: const Icon(
                              Icons.password_sharp,
                              color: Colors.teal,
                            ),
                            hintText: 'Password',
                          )),
                      const SizedBox(
                        height: 24.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            Navigator.pushReplacementNamed(
                                context, 'home_screen');
                          } catch (e) {
                            var error = e.toString().split(']');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                content: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  child: Text(error[1]),
                                ),
                              ),
                            );
                            print(error[1]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: Text(
                          "Login",
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // TextButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, "registration_screen");
                      //     },
                      //     child: Text("register"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
