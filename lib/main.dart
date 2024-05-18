import 'package:chat_material3/layout.dart';
import 'package:chat_material3/provider/provider.dart';
import 'package:chat_material3/screens/auth/login_screen.dart';
import 'package:chat_material3/screens/auth/setup_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => ProviderApp(),
      child: Consumer<ProviderApp>(
        builder: (context,value,child) =>MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: value.themeMode,
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(value.mainColor),
                  brightness: Brightness.dark),
            ),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(value.mainColor),
                  brightness: Brightness.light),
              useMaterial3: true,
            ),
            home: StreamBuilder(stream: FirebaseAuth.instance.userChanges(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (FirebaseAuth.instance.currentUser!.displayName == "" ||
                    FirebaseAuth.instance.currentUser!.displayName == null) {
                  return SetupProfile();

                }else {
                  return LayoutApp();
                }
                }else {
                return LoginScreen();
              }


            },
            )),
      ),
    );
  }
}
