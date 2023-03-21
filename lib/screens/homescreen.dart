import 'package:arapp/screens/favourites.dart';
import 'package:arapp/screens/frontpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late User loggedinUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  var email;
  var username;
  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    dynamic user = auth.currentUser;
    // var id = user.DisplayName;
    email = user.email;
    getuser(email);

    super.initState();
  }

  Future<String?> getuser(
    String email,
  ) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      username = data["full_name"];
      print("name $username");
    } catch (e) {
      return 'Error fetching user';
    }
    return username;
  }

  //using this function you can use the credentials of the user

  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.teal),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () {
          setState(() {
            _currentindex = 5;
          });
        },
        backgroundColor: _currentindex == 5 ? Colors.black : Colors.white,
        child: Center(
          child: IconButton(
            icon: Image.asset(
              "assets/cart.png",
              height: 30,
              width: 25,
              color: _currentindex == 5 ? Colors.white : Colors.teal,
            ),
            onPressed: () {
              setState(() {
                _currentindex = 5;
              });
            },
          ),
        ), //icon inside button
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            // boxShadow: [
            //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            // ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomAppBar(
              //bottom navigation bar on scaffold
              color: Colors.teal,

              shape: const CircularNotchedRectangle(), //shape of notch
              notchMargin:
                  7, //notche margin between floating button and bottom appbar
              child: Row(
                //children inside bottom appbar
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 4, left: 5),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/home.png",
                        height: 25,
                        width: 20,
                        color: _currentindex == 0 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentindex = 0;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/categories.png",
                        height: 25,
                        width: 20,
                        color: _currentindex == 1 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        //   Navigator.pushNamed(context, "category_screen");
                        setState(() {
                          _currentindex = 1;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: IconButton(
                      icon: Icon(
                        Icons.card_giftcard_outlined,
                        color: _currentindex == 2 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _currentindex = 2;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        "assets/settings.png",
                        height: 25,
                        width: 20,
                        color: _currentindex == 3 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "ar_screen");
                        setState(() {
                          _currentindex = 3;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            if (_currentindex == 0)
              const FrontPage()
            else if (_currentindex == 7)
              const FavouritesScreen(),
          ],
        ),
      )),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.teal,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.teal),
                accountName: Text(
                  username.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                accountEmail: Text(email.toString()),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
                _currentindex == 6;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_outlined),
              title: const Text('Faviourites'),
              onTap: () {
                Navigator.pop(context);
                _currentindex == 7;
                setState(() {});
                // Navigator.pushNamed(context, "favourites_screen");
                // const FavouritesScreen();
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard_outlined),
              title: const Text('Offers'),
              onTap: () {
                Navigator.pop(context);
                _currentindex == 8;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_on),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                _currentindex == 9;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "login_screen");
                _signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class _SliderView extends StatefulWidget {
//   final Function(String)? onItemClick;
//   const _SliderView({Key? key, this.onItemClick}) : super(key: key);

//   @override
//   State<_SliderView> createState() => _SliderViewState();
// }

// late String userEmail;
// final _auth = FirebaseAuth.instance;
// var name;
// var onlyname;

// class _SliderViewState extends State<_SliderView> {
//   @override
//   void initState() {
//     dynamic user = _auth.currentUser;
//     userEmail = user.email;
//     name = userEmail.toString().split("@");
//     onlyname = name[0].toString().split(RegExp(r"[0-9]"))[0];
//     print(name[0].toString().split(RegExp(r"[0-9]"))[1]);
//     setState(() {});
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width: MediaQuery.of(context).size.width * 0.8,
//       color: Colors.grey.shade200,
//       padding: const EdgeInsets.only(top: 30),
//       child: ListView(
//         children: <Widget>[
//           const SizedBox(
//             height: 30,
//           ),
//           CircleAvatar(
//             radius: 65,
//             backgroundColor: Colors.deepPurple.shade400,
//             child: CircleAvatar(
//               radius: 60,
//               backgroundImage: Image.asset('assets/earth.jpg').image,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           // IconButton(
//           //     onPressed: () {
//           //       print(name[0].toString().split(RegExp(r"[0-9]"))[9]);
//           //     },
//           //     icon: Icon(Icons.access_alarms_outlined)),
//           Text(
//             // "nesan",
//             name[0].toString().split(RegExp(r"[0-9]"))[0] == ""
//                 ? name[0].toString().split(RegExp(r"[0-9]"))[9]
//                 : name[0].toString().split(RegExp(r"[0-9]"))[0],
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 30,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ...[
//             Menu(Icons.home, 'Home'),
//             Menu(Icons.card_giftcard_outlined, 'Offers'),
//             Menu(Icons.notifications_active, "Notifications"),
//             Menu(Icons.favorite, 'Likes'),
//             Menu(Icons.settings, 'Setting'),
//             Menu(Icons.arrow_back_ios, 'LogOut')
//           ]
//               .map((menu) => _SliderMenuItem(
//                   title: menu.title,
//                   iconData: menu.iconData,
//                   onTap: widget.onItemClick))
//               .toList(),
//         ],
//       ),
//     );
//   }
// }

// class _SliderMenuItem extends StatelessWidget {
//   final String title;
//   final IconData iconData;
//   final Function(String)? onTap;

//   const _SliderMenuItem(
//       {Key? key,
//       required this.title,
//       required this.iconData,
//       required this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//         title: Text(title,
//             style: const TextStyle(
//                 color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
//         leading: Icon(iconData, color: Colors.black),
//         onTap: () => onTap?.call(title));
//   }
// }

// class Menu {
//   final IconData iconData;
//   final String title;

//   Menu(this.iconData, this.title);
// }
// // class GetUserName extends StatelessWidget {
// //   final String documentId = "MLdluph4xQOe8iqH8GIR";

// //   @override
// //   Widget build(BuildContext context) {
// //     CollectionReference users =
// //         FirebaseFirestore.instance.collection('furnitures');

// //     return FutureBuilder<DocumentSnapshot>(
// //       future: users.doc(documentId).get(),
// //       builder:
// //           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
// //         if (snapshot.hasError) {
// //           return Text("Something went wrong");
// //         }

// //         if (snapshot.hasData && !snapshot.data!.exists) {
// //           return Text("Document does not exist");
// //         }

// //         if (snapshot.connectionState == ConnectionState.done) {
// //           Map<String, dynamic>? data =
// //               snapshot.data?.data() as Map<String, dynamic>?;
// //           return Text("Full Name: ${data!['furniture-name']}");
// //         }

// //         return Text("loading");
// //       },
// //     );
// //   }
// // }
// // class AddData extends StatelessWidget {
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       backgroundColor: Colors.green,
//   //       title: Text("data"),
//   //     ),
//   //     body: StreamBuilder(
//   //       stream: FirebaseFirestore.instance.collection('furnitures').snapshots(),
//   //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//   //         if (!snapshot.hasData) {
//   //           return Center(
//   //             child: CircularProgressIndicator(),
//   //           );
//   //         }

//   //         return ListView(
//   //           children: snapshot.data!.docs.map((document) {
//   //             print(document.data());

//   //             return Container(
//   //               child: Center(child: Text(document['furniture-name'])),
//   //             );
//   //           }).toList(),
//   //         );
//   //       },
//   //     ),
//   //   );
//   // }
// // }
