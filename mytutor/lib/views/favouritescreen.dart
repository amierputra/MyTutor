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

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
  
}

class _FavouriteScreenState extends State<FavouriteScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}