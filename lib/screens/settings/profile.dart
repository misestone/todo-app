import 'dart:io';

import 'package:chat_material3/firebase/fire_database.dart';
import 'package:chat_material3/firebase/fire_storage.dart';
import 'package:chat_material3/models/user_model.dart';
import 'package:chat_material3/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController aboutCon = TextEditingController();


  ChatUser? me;
  String _img= "";
  bool nameEdite = false;
  bool aboutEdite = false;
  @override
  void initState() {
    // TODO: implement initState

    me = Provider.of<ProviderApp>(context , listen: false).me;
    super.initState();
    nameCon.text = me!.name!;
    aboutCon.text = me!.about!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                   _img == ""? me!.image == "" ? CircleAvatar(
                      radius: 70,
                    ): CircleAvatar(
                     radius: 70,
                     backgroundImage: NetworkImage(me!.image!),
                     ): CircleAvatar(
                     radius: 70,
                     backgroundImage: FileImage(File(_img)),
                   ),
                    Positioned(
                        bottom: -5,
                        right: -5,
                        child: IconButton.filled(
                            onPressed: () async{
                              ImagePicker imagePicker = ImagePicker();
                              XFile? image =await imagePicker.pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  _img = image.path;
                                });
                                FireStorage()
                                    .updateProfileImage(file: File(image.path));
                              }
                            }, icon: Icon(Iconsax.edit)))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.user_octagon),
                  trailing:
                      IconButton(onPressed: () {
                        setState(() {
                          nameEdite = true;
                        });
                      }, icon: Icon(Iconsax.edit)),
                  title: TextField(
                    controller: nameCon,
                    enabled: nameEdite,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Iconsax.information),
                  trailing:
                      IconButton(onPressed: () {
                        setState(() {
                          aboutEdite = true;
                        });
                      }, icon: Icon(Iconsax.edit)),
                  title: TextField(
                    controller: aboutCon,
                    enabled: aboutEdite,
                    decoration: InputDecoration(
                      labelText: "About",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                    leading: Icon(Iconsax.direct),
                    title: Text("Email"),
                    subtitle: Text(me!.email.toString())),
              ),
              Card(
                child: ListTile(
                    leading: Icon(Iconsax.timer_1),
                    title: Text("Joined On"),
                    subtitle: Text(me!.createdAt.toString())),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameCon.text.isNotEmpty && aboutCon.text.isNotEmpty) {
                    FireData()
                        .editeProfile(nameCon.text, aboutCon.text)
                        .then((value)  {
                      setState(() {
                        nameEdite =false;
                        aboutEdite = false;
                      });
                    });
                  }  

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  padding: const EdgeInsets.all(16),
                ),
                child: Center(
                  child: Text(
                    "Save".toUpperCase(),
                    // style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
