// ignore_for_file: unused_import, avoid_print

import 'package:flutter/material.dart';
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

class SubjectScreen extends StatefulWidget {
  
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Subjects> subjectlist = <Subjects>[];
  String titlecenter = "";
  int _currentIndex = 0;
  String maintitle = "Subjects";
  List<User> userList = <User>[];
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    _loadSubject();
  }

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
        
        body: subjectlist.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Your Current Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(subjectlist.length, (index) {
                          return Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/courses/" +
                                      subjectlist[index].subject_id.toString() +
                                      ".png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            subjectlist[index].subject_name
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: resWidth * 0.045,
                                                fontWeight: FontWeight.bold)),
                                        Text("Rating:"+
                                          subjectlist[index].subject_rating
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ));
                        }),
                      ),
                    ),
                  ),
                ],
              ),
        
    );
}

void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Subjects";
      }
      if (_currentIndex == 1) {
        maintitle = "Tutors";
      }
      if (_currentIndex == 2) {
        maintitle = "Subscribe";
      }
      if (_currentIndex == 3) {
        maintitle = "Favourites";
      }
      if (_currentIndex == 4) {
        maintitle = "Profile";
      }
    });
  }

void _loadSubject() {
    http
        .post(
      Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/loadsubjects.php"),
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        print (extractdata);
        if (extractdata['subjects'] != null) {
          subjectlist = <Subjects>[];
          extractdata['subjects'].forEach((v) {
            subjectlist.add(Subjects.fromJson(v));
          });
          titlecenter = subjectlist.length.toString() + " Subjects Available";
        } else {
          titlecenter = "No Subject Available";
          subjectlist.clear();
        }
        setState(() {});
      } else {
        //do something
        titlecenter = "No Subject Available";
        subjectlist.clear();
        setState(() {});
      }
    });
  }
}