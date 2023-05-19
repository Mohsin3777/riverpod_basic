// ignore_for_file: public_member_api_docs, sort_constructors_first
// State Notifier and StateNotifier Provider

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class User {
  final String name;
  final int age;

  const User(this.name, this.age);

  User copyWith({
    String? name,
    int? age,
  }) {
    return User(
      name ?? this.name,
      age ?? this.age,
    );
  }
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(const User('', 0)) {
    updateName('MohsiniRFAN');
  }

  void updateName(String n) {
    state = state.copyWith(name: n);
  }

  void updateAge(int n) {
    state = state.copyWith(age: n);
  }
}

final stat_notif_prov =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

class State_not_Prov_Example extends ConsumerWidget {
  const State_not_Prov_Example({super.key});

  void onSubmit(WidgetRef ref, String name) {
    ref.read(stat_notif_prov.notifier).updateName(name);
  }

  void onSubmitAge(WidgetRef ref, int num) {
    ref.read(stat_notif_prov.notifier).updateAge(num);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(stat_notif_prov);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Column(
        children: [
          TextField(
            onSubmitted: (value) => onSubmit(ref, value),
          ),
          TextField(
            onSubmitted: (value) => onSubmitAge(ref, int.parse(value)),
          ),
          Center(
            child: Text(user.age.toString()),
          ),
        ],
      ),
    );
  }
}
