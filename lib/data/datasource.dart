// ignore_for_file: avoid_web_libraries_in_flutter, depend_on_referenced_packages, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskk5/data/product.dart';
import 'package:taskk5/data/userdata.dart';

class DataSource {
  static List<Product> products = [];
  static bool isLoading = true;
  static bool isLoadingProfile = true;

  static Future<UserDataModel?> getDataFromFirebase() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;

      UserDataModel? user;

      DocumentSnapshot UserA =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      user = UserDataModel(
          email: UserA['email'],
          phone: UserA['phone'],
          name: UserA['name'],
          password: UserA['password'],
          uid: UserA['uid']);

      return user;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  static UserDataModel? userData;
}
