// ignore_for_file: unused_import, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mytutor/views/subjectscreen.dart';
import 'package:mytutor/views/favouritescreen.dart';
import 'package:mytutor/views/subscribescreen.dart';
import 'package:mytutor/views/profilescreen.dart';
import 'package:mytutor/views/tutorscreen.dart';

import 'dart:convert';
import '../models/user.dart';
import '../models/subjects.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
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
  late int _selectedIndex;
  late List<Widget> _pages;
  late Widget _page1, _page2, _page3, _page4, _page5;
  late Widget _currentPage;
  String text = '';
  String text1 = "Subjects";
  String text2 = "Tutors";
  String text3 = "Subscribe";
  String text4 = "Favourite";
  String text5 = "Profile";

  @override
  void initState() {
    super.initState();

    _page1 = SubjectScreen();
    _page2 = TutorScreen();
    _page3 = SubscribeScreen();
    _page4 = FavouriteScreen();
    _page5 = ProfileScreen(
      user: widget.user,
    );
    _pages = [_page1, _page2, _page3, _page4, _page5];
    _selectedIndex = 0;
    _currentPage = _page1;
    text = text1;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _pages[index];

      switch (index) {
        case 0:
          text = text1;
          break;

        case 1:
          text = text2;
          break;

        case 2:
          text = text3;
          break;

        case 3:
          text = text4;
          break;

        case 4:
          text = text5;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTutor'),
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books,
                ),
                label: "Subjects"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.co_present,
                ),
                label: "Tutors"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assignment_turned_in,
                ),
                label: "Subscribe"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: "Favourites"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                label: "Profile"),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            _onItemTapped(index);
          }),
    );
  }
}
