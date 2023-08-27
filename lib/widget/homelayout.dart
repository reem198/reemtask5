// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskk5/pages/homepage.dart';
import 'package:taskk5/pages/profile.dart';
import 'package:taskk5/pages/signup.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  void getPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    const Homepage(),
    const Profile(),
  ];

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: () async {
            await signOut().then((value) {
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const signup();
                }));
              }
            });
          },
          icon: const Icon(Icons.logout),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
        title: const Text(
          "Hello",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white,
            fontSize: 35,
          ),
        ),
        actions: [
          const Icon(
            Icons.search,
            color: Colors.brown,
            size: 30,
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.brown),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            getPage(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
            )
          ],
        ),
      ),
    );
  }
}
