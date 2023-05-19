import 'dart:convert';

import 'package:flutter/material.dart';
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
final AllUserRepositaryProvider = Provider((ref) => AllUserRepositary());

class AllUserRepositary {
  Future<List<UserModel>> fetchUserData() async {
    const url = "https://jsonplaceholder.typicode.com/todos/";
    return http.get(Uri.parse(url)).then((value) {
      var data = jsonDecode(value.body);
      List<UserModel> list = [];
      print(data);
      for (var i in data) {
        list.add(UserModel.fromMap(i));
      }

      // return data.map((e) => UserModel.fromJson(e)).toList();
      return list;
    });
  }
}

final fetchAllUserProvider = FutureProvider((ref) {
  final alluserRepositary = ref.watch(AllUserRepositaryProvider);

  return alluserRepositary.fetchUserData();
});

class AllDataExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Data'),
      ),
      body: ref.watch(fetchAllUserProvider).when(data: (data) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Card(
                    color: index / 2 == 0 ? Colors.red : Colors.green[300],
                    child: Column(
                      children: [
                        Text(data[index].title.toString()),
                        Text(data[index].id.toString())
                      ],
                    ),
                  ),
                );
              }),
          // child: Text(data[3].title.toString()),
        );
      }, error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
