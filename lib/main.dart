import 'package:arapp/screens/ar_screen.dart';
import 'package:arapp/screens/homescreen.dart';
import 'package:arapp/screens/loginpage.dart';
import 'package:arapp/screens/productscreen.dart';
import 'package:arapp/screens/signinpage.dart';
import 'package:arapp/screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print('ARCORE IS AVAILABLE?');
  // print(await ArCoreController.checkArCoreAvailability());
  print('\nAR SERVICES INSTALLED?');
  //print(await ArCoreController.checkIsArCoreInstalled());
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? 'login_screen'
          : 'home_screen',
      onGenerateRoute: (settings) {
        late Widget currentScreen;
        switch (settings.name) {
          case 'registration_screen':
            currentScreen = SignIn();
            break;
          case 'login_screen':
            currentScreen = LoginPage();
            break;
          case 'home_screen':
            currentScreen = const HomeScreen();
            break;
          case 'product_screen':
            final args = settings.arguments as Map<String, dynamic>;

            currentScreen = ProductScreen(
              url: args["url"].toString(),
              productname: args["productname"].toString(),
              productrate: args["productrate"].toString(),
              description: args["description"].toString(),
            );
            break;
          case 'ar_screen':
            final args = settings.arguments as Map<String, dynamic>;

            currentScreen = ArScreen(
              finalpath: args["finalpath"].toString(),
            );

            break;
          case 'testpage':
            final args = settings.arguments as Map<String, dynamic>;

            currentScreen = TestPage(
              filepath: args["filepath"].toString(),
            );
            break;
          default:
            currentScreen = SignIn();
            break;
        }
        return MaterialPageRoute(builder: (context) => currentScreen);
      },
    );
  }
}
