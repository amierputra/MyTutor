// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutoradmin/constants.dart';
import 'loginscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/admin.dart';

class MainScreen extends StatefulWidget {
  final Admin admin;
  const MainScreen({Key? key, required this.admin}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Admin> adminList = <Admin>[];
  late double screenHeight, screenWidth, resWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTutor'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.admin.name.toString()),
              accountEmail: Text(widget.admin.email.toString()),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: CONSTANTS.server +
                        "/mytutoradmin/mobile/assets/profiles/" +
                        widget.admin.id.toString() +
                        '.jpg',
                        fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            _createDrawerItem(
              icon: Icons.list_alt_outlined,
              text: 'My Products',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.local_shipping,
              text: 'My Orders',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.verified_user,
              text: 'My Profile',
              onTap: () {},
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('This is main page.'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: "New Product",
        onPressed: () {},
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}