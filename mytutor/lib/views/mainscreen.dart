// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import '../models/user.dart';
import '../constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<User> userList = <User>[];
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
              accountName: Text(widget.user.name.toString()),
              accountEmail: Text(widget.user.email.toString()),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: CONSTANTS.server +
                        "/mytutor/mobile/assets/profiles/" +
                        widget.user.id.toString() +
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
