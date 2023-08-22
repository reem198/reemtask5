// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import '../data/datasource.dart';
import '../data/userdata.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    if (DataSource.isLoadingProfile) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.getDataFromFirebase();
        setState(() {
          DataSource.userData = data as UserDataModel?;
          DataSource.isLoadingProfile = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataSource.isLoadingProfile
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black)),
                    title: Text(
                      DataSource.userData!.email,
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
                        side: const BorderSide(color: Colors.black)),
                    title: Text(
                      DataSource.userData!.name,
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
                        side: const BorderSide(color: Colors.black)),
                    title: Text(
                      DataSource.userData!.phone,
                      textAlign: TextAlign.center,
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
                        side: const BorderSide(color: Colors.black)),
                    title: Text(
                      DataSource.userData!.password,
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
                        side: const BorderSide(color: Colors.black)),
                    title: Text(
                      DataSource.userData!.uid,
                      textAlign: TextAlign.center,
                    ),
                    leading: const Icon(Icons.insert_drive_file),
                  ),
                ],
              ),
            ),
    );
  }
}
