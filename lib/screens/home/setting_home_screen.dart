import 'package:chat_material3/models/user_model.dart';
import 'package:chat_material3/provider/provider.dart';
import 'package:chat_material3/screens/settings/profile.dart';
import 'package:chat_material3/screens/settings/qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SettingHomeScreen extends StatefulWidget {
  const SettingHomeScreen({super.key});

  @override
  State<SettingHomeScreen> createState() => _SettingHomeScreenState();
}

class _SettingHomeScreenState extends State<SettingHomeScreen> {

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderApp>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            ListTile(
              minVerticalPadding: 40,
              leading:  CircleAvatar(radius: 30,),
              title: Text(prov.me!.name.toString()),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrCodeScreen(),
                        ));
                  },
                  icon: Icon(Iconsax.scan_barcode)),
            ),
            Card(
              child: ListTile(
                title: Text("Profile"),
                leading: Icon(Iconsax.user),
                trailing: Icon(Iconsax.arrow_right_3),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    )),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: Color(prov.mainColor) ,
                            onColorChanged: (value) {
                              print(value.value.toRadixString(16));
                              prov.changeColor(value.value);
                            },
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Done"))
                        ],
                      );
                    },
                  );
                },
                title: Text("Theme"),
                leading: Icon(Iconsax.color_swatch),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Dark Mode"),
                leading: Icon(Iconsax.user),
                trailing: Switch(
                  value: prov.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    prov.ChangeMode(value);
                  },
                  
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async => await FirebaseAuth.instance.signOut(),
                title: Text("Signout"),
                trailing: Icon(Iconsax.logout_1),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
