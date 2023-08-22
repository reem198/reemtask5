// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskk5/widget/homelayout.dart';


class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signup();
}

class _signup extends State<signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signup({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      // ignore: prefer_const_constructors
                      return  HomeLayout();
                    }));
              }
            });
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
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
      },
        SetOptions(merge: true),
      );
      return true;
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('email'),
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email must be not empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Name'),
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'name must be not empty';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('phone'),
              TextFormField(
                controller: phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'phone must be not empty';
                  } else if (value.length < 11) {
                    return 'phone must be 11 number';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('password'),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'password must be not empty';
                  } else if (value.length < 6) {
                    return 'password must be 6 numbers';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await signup(
                      email: email.text,
                      password: password.text,
                      phone: phone.text,
                      name: name.text,
                    );
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.brown),
                      ),
                  child: const Text('Sign up'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
