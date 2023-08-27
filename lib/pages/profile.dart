import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskk5/cubit/my_app_cubit.dart';
import 'package:taskk5/pages/login.dart';

import '../cubit/my_app_state.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              color: Colors.brown,
              onPressed: () async {
                await signOut().then((value) {
                  if (value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  }
                });
              },
              icon: const Icon(Icons.logout),
            ),
          ),
          BlocBuilder<MyAppCubit, MyAppState>(
            builder: (context, state) {
              if (context.read<MyAppCubit>().userData != null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: context
                                        .read<MyAppCubit>()
                                        .userData!
                                        .image ==
                                    ''
                                ? const NetworkImage(
                                    'https://cdn2.vectorstock.com/i/1000x1000/54/41/young-and-elegant-woman-avatar-profile-vector-9685441.jpg')
                                : NetworkImage(
                                    context.read<MyAppCubit>().userData!.image),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(90)),
                              child: IconButton(
                                onPressed: () {
                                  context.read<MyAppCubit>().pickImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        style: ListTileStyle.list,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.brown)),
                        title: Text(
                          context.read<MyAppCubit>().userData!.email,
                          textAlign: TextAlign.center,
                        ),
                        leading: const Icon(Icons.email),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        style: ListTileStyle.list,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.brown)),
                        title: Text(
                          context.read<MyAppCubit>().userData!.name,
                          textAlign: TextAlign.center,
                        ),
                        leading: const Icon(Icons.person),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        style: ListTileStyle.list,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.brown)),
                        title: Text(
                          context.read<MyAppCubit>().userData!.phone,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Urbanist', fontSize: 20),
                        ),
                        leading: const Icon(Icons.phone),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        style: ListTileStyle.list,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.brown)),
                        title: Text(
                          context.read<MyAppCubit>().userData!.password,
                          textAlign: TextAlign.center,
                        ),
                        leading: const Icon(Icons.security),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        style: ListTileStyle.list,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.brown)),
                        title: Text(
                          context.read<MyAppCubit>().userData!.uid,
                          textAlign: TextAlign.center,
                        ),
                        leading: const Icon(Icons.insert_drive_file),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('ERROR');
              }
            },
          ),
        ],
      ),
    );
  }
}
