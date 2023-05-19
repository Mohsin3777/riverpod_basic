// ignore_for_file: public_member_api_docs, sort_constructors_first
// Future Provider

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserModel {
  final int id;
  final String title;

  UserModel(this.id, this.title);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['id'] as int,
      map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

//create userRepositary provider
final UserRepositaryProvider = Provider((ref) => UserRepositary());

class UserRepositary {
  Future<UserModel> fetchUserData() async {
    const url = "https://jsonplaceholder.typicode.com/todos/1";
    return http
        .get(Uri.parse(url))
        .then((value) => UserModel.fromJson(value.body));
  }
}

final fetchUserProvider = FutureProvider((ref) {
  final userRepositary = ref.watch(UserRepositaryProvider);
  return userRepositary.fetchUserData();
});

class FutureProvExample extends ConsumerWidget {
  const FutureProvExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchUserProvider).when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Future Provider'),
        ),
        body: Container(
          child: Column(
            children: [Text(data.title)],
          ),
        ),
      );
    }, error: (error, StackTrace) {
      return Center(
        child: Text(error.toString()),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
