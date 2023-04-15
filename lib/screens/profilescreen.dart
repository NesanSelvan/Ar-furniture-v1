import 'package:arapp/screens/aboutusscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name;
  var email;
  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    dynamic user = auth.currentUser;
    email = user.email;
    getuser(email);
    // TODO: implement initState
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
      name = data["full_name"];
      setState(() {});
    } catch (e) {
      return 'Error fetching user';
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Colors.te,
      child: Stack(children: [
        ListView(children: <Widget>[
          ListTile(
            title: Text(
              name ?? "User",
              style: GoogleFonts.poppins(
                  // fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(email ?? "empty"),
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              // NetworkImage(
              //   "https://firebasestorage.googleapis.com/v0/b/homear-4ccea.appspot.com/o/23.png?alt=media&token=4c2a5ce6-6b07-4df9-9e02-83345166bfce",
              // ),
              backgroundImage: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/homear-4ccea.appspot.com/o/designing-a-cartoon-avatar-removebg-preview-modified.png?alt=media&token=a576d761-7209-4c3a-b7df-b5feb97ffdb8",
                fit: BoxFit.cover,
              ).image,
              radius: 25,
            ),
          ),
          // const Spacer(),
          ListTile(
            title: Text(
              'Orders',
              style: GoogleFonts.openSans(
                  fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.teal,
            ),
            leading: const Icon(
              Icons.shopping_bag,
              size: 24,
              color: Colors.teal,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'My Details',
              style: GoogleFonts.openSans(
                  fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.teal,
            ),
            leading: const Icon(
              Icons.feed,
              size: 24,
              color: Colors.teal,
            ),
            onTap: () {
              Navigator.pushNamed(context, "personal_details");
            },
          ),
          ListTile(
            title: Text(
              'Delivery Adddress',
              style: GoogleFonts.openSans(
                  fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.teal,
            ),
            leading: const Icon(
              Icons.location_on,
              size: 24,
              color: Colors.teal,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Payment Methods',
              style: GoogleFonts.openSans(
                  fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.teal,
            ),
            leading: const Icon(
              Icons.credit_card,
              size: 24,
              color: Colors.teal,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Notifcations',
              style: GoogleFonts.openSans(
                  fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.teal,
            ),
            leading: const Icon(
              Icons.notifications_active,
              size: 24,
              color: Colors.teal,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Help',
              style: GoogleFonts.openSans(
                  fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.teal,
            ),
            leading: const Icon(
              Icons.help,
              size: 26,
              color: Colors.teal,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'About Us',
              style: GoogleFonts.openSans(
                  fontSize: 19,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.teal,
            ),
            leading: const Icon(
              Icons.info,
              size: 24,
              color: Colors.teal,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          )
        ])
      ]),
    );
  }
}
