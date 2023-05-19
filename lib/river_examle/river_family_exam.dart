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

//create UserRepositary_family_example_Provider provider
final UserRepositary_family_example_Provider =
    Provider((ref) => UserRepositary());

class UserRepositary {
  Future<UserModel> fetchUserData(int num) async {
    var url = "https://jsonplaceholder.typicode.com/todos/$num";
    return http
        .get(Uri.parse(url))
        .then((value) => UserModel.fromJson(value.body));
  }
}

final fetchUserProvider = FutureProvider.family((ref, int num) {
  final userrepositaryFamilyExample =
      ref.watch(UserRepositary_family_example_Provider);
  return userrepositaryFamilyExample.fetchUserData(num);
});

class Riv_Family_Example extends ConsumerStatefulWidget {
  const Riv_Family_Example({super.key});

  @override
  ConsumerState<Riv_Family_Example> createState() => _Riv_Family_ExampleState();
}

class _Riv_Family_ExampleState extends ConsumerState<Riv_Family_Example> {
  @override
  Widget build(BuildContext context) {
    int userNo = 1;
    return ref.watch(fetchUserProvider(userNo)).when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Future Provider'),
        ),
        body: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                setState(() {
                  userNo = int.parse(value);
                });
              },
            ),
            Text(data.title)
          ],
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
