import 'package:chat_material3/models/user_model.dart';
import 'package:chat_material3/provider/provider.dart';
import 'package:chat_material3/screens/home/chat_home_screen.dart';
import 'package:chat_material3/screens/home/contact_home_screen.dart';
import 'package:chat_material3/screens/home/group_home_screen.dart';
import 'package:chat_material3/screens/home/setting_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LayoutApp extends StatefulWidget {
  const LayoutApp({super.key});

  @override
  State<LayoutApp> createState() => _LayoutAppState();
}

class _LayoutAppState extends State<LayoutApp> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProviderApp>(context, listen: false).getValuesPref();
    Provider.of<ProviderApp>(context, listen: false).getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatUser? me= Provider.of<ProviderApp>(context).me;
    return Scaffold(
      body: me == null ? Center(child: CircularProgressIndicator(),)
      :PageView(
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        controller: pageController,
        children: const [
          ChatHomeScreen(),
          GroupHomeScreen(),
          ContactHomeScreen(),
          SettingHomeScreen()
        ],
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            currentIndex = value;
            pageController.jumpToPage(value);
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.message), label: "Chat"),
          NavigationDestination(icon: Icon(Iconsax.messages), label: "Group"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Contacts"),
          NavigationDestination(icon: Icon(Iconsax.setting), label: "Setting"),
        ],
      ),
    );
  }
}
