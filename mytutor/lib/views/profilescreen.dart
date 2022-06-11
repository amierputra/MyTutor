// ignore_for_file: unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:mytutor/views/subjectscreen.dart';
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


class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key,  required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}