import 'package:flutter/material.dart';
import 'package:reach_me/screens/add_post_screen.dart';
import 'package:reach_me/screens/feed_screen.dart';

const webScreen = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('Notif'),
  Text('Profile'),
];