import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskk5/cubit/my_app_state.dart';
import 'package:taskk5/data/product.dart';
import 'package:taskk5/data/userdata.dart';

class MyAppCubit extends Cubit<MyAppState> {
  MyAppCubit() : super(MyAppInitial());

  List<Product> products = [];

  UserDataModel? userData;



  Future<void> getDataFromFirebase() async {
    try {
      emit(GetDatLoadingState() as MyAppState);
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userA =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = UserDataModel(
          name: userA['name'],
          password: userA['password'],
          phone: userA['phone'],
          email: userA['email'],
          uid: userA['uid'],
          image: userA['image']);
      emit(GetDatDoneState() as MyAppState);
    } catch (e) {
      emit(GetDatErrorState(e.toString()) as MyAppState);
      print(e);
    }
  }

  Future<void> login(
      String email,
      String password,
      ) async {
    try {
      emit(LoginLoadingState() as MyAppState);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (value.user != null) {
          emit(LoginDoneState() as MyAppState);
        }
      });
    } catch (e) {
      emit(LoginErrorState(e.toString()) as MyAppState);
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    try {
      emit(CreateAccLoadingState() as MyAppState);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (value.user != null) {
          saveUserData(
            email: email,
            password: password,
            name: name,
            phone: phone,
            uid: value.user!.uid,
          ).then((value) {
            if (value) {
              emit(CreateAccDoneState() as MyAppState);
            } else {
              emit(CreateAccErrorState(' ***saveUserData error ') as MyAppState);
            }
          });
        }
      });
    } catch (e) {
      emit(CreateAccErrorState(e.toString()) as MyAppState);
    }
  }

  Future<bool> saveUserData({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String uid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
        'uid': uid,
        'image': '',
      }, SetOptions(merge: true));
      return true;
    } catch (error) {
      return false;
    }
  }

  double sum = 0;

  void getSum(
      double input1,
      double input2,
      ) {
    sum = input1 + input2;
    emit(GetSum() as MyAppState);
  }

  ImagePicker picker = ImagePicker();
  File? img;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      img = File(image.path);
      uploadImageToUserData(File(image.path));
      emit(PickImageState() as MyAppState);
    } else {
    }
  }

  Future<void> uploadImageToUserData(File image) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child('usersImages')
          .child('${DateTime.now()}.jpg');

      await ref.putFile(File(image.path));

      String? url;

      url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'image': url,
        },
      );
    } catch (e) {}
  }
}
