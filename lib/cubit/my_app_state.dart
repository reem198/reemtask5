import 'package:flutter/material.dart';

@immutable
sealed class MyAppState {}

final class MyAppInitial extends MyAppState {}

class MyAppIntial extends MyAppState {}

class LoadingState extends MyAppState {}

class ErrorState extends MyAppState {}

class DoneState extends MyAppState {}

class PickImageState extends MyAppState {}

class GetSum extends MyAppState {}

// for login
class LoginLoadingState extends MyAppState {}

class LoginErrorState extends MyAppState {
  final String error;
  LoginErrorState(this.error);
}

class LoginDoneState extends MyAppState {}

// for create acc
class CreateAccLoadingState extends MyAppState {}

class CreateAccErrorState extends MyAppState {
  final String error;
  CreateAccErrorState(this.error);
}

class CreateAccDoneState extends MyAppState {}

// for get user data
class GetDatDoneState extends MyAppState {}

class GetDatLoadingState extends MyAppState {}

class GetDatErrorState extends MyAppState {
  final String error;
  GetDatErrorState(this.error);
}

// for upload image
class UploadDoneState extends MyAppState {}

class UploadLoadingState extends MyAppState {}

class UploadErrorState extends MyAppState {
  final String error;
  UploadErrorState(this.error);
}
